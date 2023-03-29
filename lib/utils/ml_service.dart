
import 'dart:math';

import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';

import 'dart:io';
import "package:camera/camera.dart";
import 'package:flutter/foundation.dart';
// import "package:firebase_ml_vision/firebase_ml_vision.dart";
// import "package:google_ml_kit/google_ml_kit.dart";
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class MLService {

  static late Interpreter interpreter;

  //Initialize MLService Class
  static Future<void> initialize() async{
    Delegate? delegate;
    try {
      // if (Platform.isAndroid) {
      //   delegate = GpuDelegateV2(
      //       options: GpuDelegateOptionsV2(
      //         isPrecisionLossAllowed: false,
      //         inferencePreference: TfLiteGpuInferenceUsage.fastSingleAnswer,
      //         inferencePriority1: TfLiteGpuInferencePriority.minLatency,
      //         inferencePriority2: TfLiteGpuInferencePriority.auto,
      //         inferencePriority3: TfLiteGpuInferencePriority.auto,
      //       ));
      // } else if (Platform.isIOS) {
      //   delegate = GpuDelegate(
      //     options: GpuDelegateOptions(
      //         allowPrecisionLoss: true,
      //         waitType: TFLGpuDelegateWaitType.active),
      //   );
      // }

      var interpreterOptions = InterpreterOptions();//..addDelegate(delegate!);

      interpreter =  await Interpreter.fromAsset('mobilefacenet.tflite', options: interpreterOptions);
    } catch (e) {
      debugPrint('Failed to load model.');
      debugPrint("$e");
    }
  }

  static InputImageRotation rotationInt2ImageRotation(int rotation){
      switch(rotation) {
        case 0:
          return InputImageRotation.rotation0deg;
        case 90:
          return InputImageRotation.rotation90deg;
        case 180:
          return InputImageRotation.rotation180deg;
        default:
          assert(rotation == 270);
          return InputImageRotation.rotation270deg;
      }
  }

  static Uint8List concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for(Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  Future<File> saveImage(ui.Image image) async {
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    final tempDir = await getTemporaryDirectory();
    //get a random file name
    String filename = DateTime.now().microsecondsSinceEpoch.toString();
    final file = File('${tempDir.path}/$filename.png');
    await file.writeAsBytes(pngBytes);
    return file;
  }

  Future<File> cropImage(File imgFile, Rect cropArea, {int width = 500, int height = 500}) async {
    // final int bytes = await rootBundle.load(imagePath);
    final bytes = await imgFile.readAsBytes();
    final image = img.decodeImage(bytes.buffer.asUint8List());
    final croppedImage = img.copyCrop(image!, x:cropArea.left.toInt(), y:cropArea.top.toInt(), width: cropArea.width.toInt(), height:cropArea.height.toInt());
    final resizedImage = img.copyResize(croppedImage, width: 500, height: 500);
    final croppedBytes = img.encodeJpg(resizedImage);
    final codec = await ui.instantiateImageCodec(croppedBytes);
    final frame = await codec.getNextFrame();
    final imageFile = await saveImage(frame.image);
    return imageFile;
  }

  Future<File> resizeImage(File imgFile, int width, int height) async {
    final bytes = await imgFile.readAsBytes();
    final image = img.decodeImage(bytes.buffer.asUint8List());
    final resizedImage = img.copyResize(image!, width: width, height: height);
    final resizedImageBytes = img.encodeJpg(resizedImage);
    final codec = await ui.instantiateImageCodec(resizedImageBytes);
    final frame = await codec.getNextFrame();
    final imageFile = await saveImage(frame.image);
    return imageFile;
  }

  Future<File?> extractFace(File imageFile) async{
    try{
      final image = InputImage.fromFile(imageFile);//fromFilePath(imagePath);
      final faceDetector = FaceDetector(
        options: FaceDetectorOptions(
            enableContours: true,
            enableClassification: true,
      ),);
      var faces = await faceDetector.processImage(image);
      //Ensure that only one face is detected in the image
      if (faces.length != 1) return null;
      Rect faceArea = faces.first.boundingBox;
      File extractedFace = await cropImage(imageFile, faceArea);
      return extractedFace;
    }catch(e) {
      debugPrint("Unable to extract face");
      debugPrint("$e");
      return null;
    }

  }

  Float32List _imageToByteListFloat32(img.Image image) {
    var convertedBytes = Float32List(1 * 112 * 112 * 3);
    var buffer = Float32List.view(convertedBytes.buffer);
    int pixelIndex = 0;

    for (var i = 0; i < 112; i++) {
      for (var j = 0; j < 112; j++) {
        var pixel = image.getPixel(j, i);
        buffer[pixelIndex++] = (pixel[0] - 128) / 128;
        buffer[pixelIndex++] = (pixel[1] - 128) / 128;
        buffer[pixelIndex++] = (pixel[2] - 128) / 128;
      }
    }
    return convertedBytes.buffer.asFloat32List();
  }

  //Image preprocessing function
  Future<Float32List> _preProcessImage(File imgFile, {bool isResized = false}) async {
    //Resize image to dimensions 112 * 112 * 3 if necessary
    final bytes = await imgFile.readAsBytes();
    img.Image? image = img.decodeImage(bytes.buffer.asUint8List());
    if(isResized == false) image = img.copyResize(image!, width: 112, height: 112);
    return _imageToByteListFloat32(image!);

  }


  Future<List?> predictFaceId(File imgFile) async {
    File? faceImage = await extractFace(imgFile);
    if (faceImage == null) return null;
    List input = await _preProcessImage(faceImage);
    //define input tensor shape
    input = input.reshape([1, 112, 112, 3]);
    //define output tensor shape and initialize the output tensor
    List output = List.generate(1, (index) => List.filled(192, 0));
    interpreter.run(input, output);
    output = output.reshape([192]);
    return List.from(output);
  }

  double euclideanDistance(List l1, List l2) {
    double sum = 0;
    for (int i = 0; i < l1.length; i++) {
      sum += pow((l1[i] - l2[i]), 2);
    }
    return pow(sum, 0.5).toDouble();
  }

  bool compareFaces(List l1, List l2, {double maxDist = 1.0}) {
    double dist = euclideanDistance(l1, l2);
    debugPrint("CALCULATED EUCLIDEAN DISTANCE: $dist");
    if(dist <= maxDist) {
      debugPrint("**FACES ARE IDENTICAL");
      return true;
    }
    debugPrint("**FACES ARE UNIDENTICAL");
    return false;
  }

}