import "package:flutter/material.dart";
import "package:file_picker/file_picker.dart";
import "package:path_provider/path_provider.dart";
import "package:studentapp/ui/getMoreStudentInfo/getFaceId.dart";
import "package:studentapp/widgets/generic_button.dart";
import "dart:io";
import "dart:async";
import "package:camera/camera.dart";


class GetMoreStudentInfo extends StatefulWidget {
  @override
  _GetMoreStudentInfoState createState() => _GetMoreStudentInfoState();
}

class _GetMoreStudentInfoState extends State<GetMoreStudentInfo> {
  PlatformFile? profilePicFile;
  XFile? faceIdFile;

  void _selectProfilePicture() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        profilePicFile = result.files.first;
      });
    }
  }
  void _getFaceId() async {
    XFile _profilePicFile = await Navigator.push(context, MaterialPageRoute(builder: (context) => GetFaceId()));
    setState(() {
      faceIdFile = _profilePicFile;
    });
  }
  void validateInput() {
    if(faceIdFile != null && profilePicFile != null) {
      Navigator.pop(context, {"profile_pic_file" : File(profilePicFile!.path!) , "face_id_file" : File(faceIdFile!.path)});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GenericButton(onPressed: _selectProfilePicture, text: "Choose Profile Pic"),
          SizedBox(height: 20),
          GenericButton(onPressed: _getFaceId, text: "Face ID"),
          SizedBox(height: 30),
          GenericButton(onPressed: validateInput, text: "Confirm", isEnabled: faceIdFile != null && profilePicFile != null )
        ],
      )
    );
  }
}

