import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:studentapp/data/user_data.dart';
import 'package:studentapp/models/course.dart';
import 'package:studentapp/ui/getMoreStudentInfo/getFaceId.dart';
import 'package:studentapp/utils/firestore/read.dart';
import 'package:studentapp/utils/ml_service.dart';
import 'package:studentapp/widgets/navigation_drawer.dart';
import 'package:studentapp/utils/firestore/write.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => CoursesState();
}

class CoursesState extends State<Courses> {
  List<Course> courses = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    Future(() async{
      debugPrint("Getting courses");
      startLoading();
      var courses_temp = await getAllCourses();
      stopLoading();
      setState(() {
        courses = courses_temp;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
        backgroundColor: Color.fromARGB(255, 126, 13, 13),
      ),
      drawer: const NavigationDrawer() ,

      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) => ListTile(
              title: Text("${courses[index].name}"),
              subtitle: Text("${courses[index].code}".toUpperCase()),
              trailing: Icon(Icons.circle, color: courses[index].isStudPresent ? Colors.green : Colors.grey),
              onTap: () async{
                List faceId = await Navigator.push(context, MaterialPageRoute(builder: (context) => GetFaceId()));
                bool identicalFaces = MLService().compareFaces(faceId, myUserData.faceId);
                if(identicalFaces == true) {
                  startLoading();
                  bool success = await addStudentToCourse(courseId: courses[index].id??"", studentId: auth.currentUser!.uid);
                  var value = await getAllCourses();
                  setState(() => courses = value);
                  stopLoading();
                } else {
                  debugPrint("Unable to record student attendance");
                }
              },
            ),),
      )

    );
  }
}