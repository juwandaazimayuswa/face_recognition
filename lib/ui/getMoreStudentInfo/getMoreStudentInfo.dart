import "package:flutter/material.dart";
import "package:file_picker/file_picker.dart";
import "package:path_provider/path_provider.dart";
import "package:studentapp/ui/getMoreStudentInfo/getFaceId.dart";
import "package:studentapp/widgets/generic_button.dart";
import "dart:io";
import "dart:async";
import "package:camera/camera.dart";
import 'package:studentapp/utils/ml_service.dart';


class GetMoreStudentInfo extends StatefulWidget {
  @override
  _GetMoreStudentInfoState createState() => _GetMoreStudentInfoState();
}

class _GetMoreStudentInfoState extends State<GetMoreStudentInfo> {
  File? profilePicFile;
  List? faceId;

  void _selectProfilePicture() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );



    if (result != null) {
      File resultFile = await MLService().resizeImage(File(result.files.first.path!), 500, 500);
      setState(() {
        profilePicFile = resultFile;
      });
    }
  }

  void _getFaceId() async {
    List? _faceId = await Navigator.push(context, MaterialPageRoute(builder: (context) => GetFaceId()));
    setState(() {
      faceId = _faceId;
    });
  }

  void validateInput() {
    if(faceId != null && profilePicFile != null) {
      Navigator.pop(context, {"profile_pic_file" : File(profilePicFile!.path!) , "face_id" : faceId!});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/UOB6-2.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GenericButton(onPressed: _selectProfilePicture, text: "Choose Profile Pic"),
            SizedBox(height: 20),
            GenericButton(onPressed: _getFaceId, text: "Face ID"),
            SizedBox(height: 30),
            GenericButton(onPressed: validateInput, text: "Submit", isEnabled: faceId != null && profilePicFile != null )
          ],
        )
      ),
    );
  }
}

