import 'dart:io';
import "package:camera/camera.dart";
import 'package:flutter/foundation.dart';
// import "package:firebase_ml_vision/firebase_ml_vision.dart";
import "package:google_ml_kit/google_ml_kit.dart";
import 'dart:ui' as ui;
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class MLService {


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
    final file = File('${tempDir.path}/image.png');
    await file.writeAsBytes(pngBytes);
    return file;
  }


  Future<File> cropImage(File imgFile, Rect cropArea) async {
    // final int bytes = await rootBundle.load(imagePath);
    final bytes = await imgFile.readAsBytes();
    final image = img.decodeImage(bytes.buffer.asUint8List());
    final croppedImage = img.copyCrop(image!, x:cropArea.left.toInt(), y:cropArea.top.toInt(), width: cropArea.width.toInt(), height:cropArea.height.toInt());
    // final croppedImage = img.copyCrop(image, cropArea.left.toInt(), cropArea.top.toInt(), cropArea.width.toInt(), cropArea.height.toInt());
    final croppedBytes = img.encodeJpg(croppedImage);
    final codec = await ui.instantiateImageCodec(croppedBytes);
    final frame = await codec.getNextFrame();
    final imageFile = await saveImage(frame.image);
    return imageFile;
  }


  Future<File?> extractFace(File imageFile) async{
    try{
      final image = InputImage.fromFile(imageFile);//fromFilePath(imagePath);
      final faceDetector = GoogleMlKit.vision.faceDetector();
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

}