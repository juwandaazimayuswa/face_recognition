import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class GetFaceId extends StatefulWidget {
  @override
  _GetFaceIdState createState() => _GetFaceIdState();
}

class _GetFaceIdState extends State<GetFaceId> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    // Get the list of available cameras.
    availableCameras().then((cameras) {
      // Select the first camera from the list.
      final firstCamera = cameras.first;
      // Create a CameraController instance and initialize it.
      _controller = CameraController(
        firstCamera,
        ResolutionPreset.high,
      );
      _initializeControllerFuture = _controller.initialize();
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
      XFile _imageFile = await _controller.takePicture();
      setState(() {
        imageFile = _imageFile;
      });

      Future.delayed(Duration(seconds: 3), () async{
        Navigator.pop(context, imageFile);
      });

    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Face Id')),
      body: FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done && imageFile == null ) {
              return CameraPreview(_controller);
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
