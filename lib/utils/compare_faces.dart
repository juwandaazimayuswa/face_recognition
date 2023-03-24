import 'dart:io';

import "package:camera/camera.dart";
import 'package:flutter/foundation.dart';
import "package:google_ml_kit/google_ml_kit.dart";
import "package:firebase_ml_vision/firebase_ml_vision.dart";

class MLService {


  static ImageRotation rotationInt2ImageRotation(int rotation){
      switch(rotation) {
        case 0:
          return ImageRotation.rotation0;
        case 90:
          return ImageRotation.rotation90;
        case 180:
          return ImageRotation.rotation180;
        default:
          assert(rotation == 270);
          return ImageRotation.rotation270;
      }
  }


  static Uint8List concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for(Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }


  Future<File?> extractFace(File imageFile) async{
    final image = FirebaseVisionImage.fromFile(imageFile);
    final faceDetector = FirebaseVision.instance.faceDetector();
    var faces = await faceDetector.processImage(image);
    //Ensure that only one face is detected in the image
    if (faces.length > 1) return null;
  }

}