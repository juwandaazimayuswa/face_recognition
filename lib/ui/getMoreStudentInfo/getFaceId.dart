import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studentapp/utils/ml_service.dart';

class GetFaceId extends StatefulWidget {
  @override
  _GetFaceIdState createState() => _GetFaceIdState();
}

class _GetFaceIdState extends State<GetFaceId> {
  late CameraController _controller;
  Future<void>? _initializeControllerFuture;
  List? faceId;
  bool isLoading = false;

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


  void startLoading() {
    setState((){
      isLoading = true;
    });
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
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
      startLoading();
      await _initializeControllerFuture;
      File inputImageFile = File((await _controller.takePicture()).path);
      List? faceId = await MLService().predictFaceId(inputImageFile);
      Future.delayed(const Duration(seconds: 3), () async{
        Navigator.pop(context, faceId);
      });

      debugPrint("SUCCESSFULLY TOOK PICTURE");

    } catch (e) {
      debugPrint('Error in take photo: ${e.toString()}');
      stopLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Face Id')),
      body: Stack(
        children: [
          ModalProgressHUD(
            inAsyncCall: isLoading,
            child: _initializeControllerFuture == null
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
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
            ),
          ),
          Center(
              child: SvgPicture.asset(
                'images/face_id.svg',
                height: MediaQuery.of(context).size.height * 0.8,
                width: MediaQuery.of(context).size.width * 0.7,
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePhoto,
        tooltip: 'Take Photo',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
