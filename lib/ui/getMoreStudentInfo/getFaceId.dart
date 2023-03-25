import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studentapp/utils/ml_service.dart';

class GetFaceId extends StatefulWidget {
  @override
  _GetFaceIdState createState() => _GetFaceIdState();
}

class _GetFaceIdState extends State<GetFaceId> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    // Get the list of available cameras.
    availableCameras().then((cameras) {
      debugPrint("Retreived available cameras");
      // Select the first camera from the list.
      final firstCamera = cameras[1];
      // Create a CameraController instance and initialize it.
      _controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );
      debugPrint("Initializing Camera controller");

      setState(() {
        _initializeControllerFuture = _controller.initialize();
      });

    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  void _takePhoto() async {
    try {
      // Ensure that the camera is initialized before taking a photo.
      await _initializeControllerFuture;
      File _inputImageFile = File((await _controller.takePicture()).path);
      // final image = InputImage.fromFile(_inputImageFile);
      // File? _outputImageFile = await MLService().extractFace(_inputImageFile.path);
      File? _outputImageFile = await MLService().extractFace(_inputImageFile);
      if (_outputImageFile == null) return;
      setState(() {
        imageFile = XFile(_outputImageFile.path);
      });

      Future.delayed(const Duration(seconds: 3), () async{
        Navigator.pop(context, imageFile);
      });

      debugPrint("SUCCESSFULLY TOOK PICTURE");

    } catch (e) {
      debugPrint('Error in take photo: ${e.toString()}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Face Id')),
      body: _initializeControllerFuture == null
          ? Center(child: CircularProgressIndicator())
          :  FutureBuilder(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  debugPrint("Displaying camera preview");
                  final mediaSize = MediaQuery.of(context).size;
                    return Center(
                      child: Transform.scale(
                          scale: 1 / (_controller.value.aspectRatio  * mediaSize.aspectRatio),
                          alignment: Alignment.center,
                          child: CameraPreview(_controller)),
                    );
                } else if (imageFile != null){
                    return Center(child: Image.file(File(imageFile!.path)));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePhoto,
        tooltip: 'Take Photo',
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
