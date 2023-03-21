import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/models/course.dart';
import 'package:studentapp/ui/getMoreStudentInfo/getFaceId.dart';
import 'package:studentapp/utils/firestore/read.dart';

import 'home.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => CoursesState();
}

class CoursesState extends State<Courses> {
  List<Course> courses = [];


  @override
  void initState() {
    super.initState();
    Future(() async{
      debugPrint("Getting courses");
      var courses_temp = await getAllCourses();
      setState(() {
        courses = courses_temp;
      });
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

      body: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) => ListTile(
            title: Text("${courses[index].name}"),
            subtitle: Text("${courses[index].code}".toUpperCase()),
            trailing: Icon(Icons.circle, color: courses[index].isStudPresent ? Colors.green : Colors.grey),
            onTap: () async{
              XFile faceIdFile = await Navigator.push(context, MaterialPageRoute(builder: (context) => GetFaceId()));

            },
          ),)

      // Body
    // body: Center(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       ElevatedButton(
    //         onPressed: () {
    //
    //         },
    //         child: Text(
    //           'Attendence',
    //           style: TextStyle(
    //             fontSize: 20,
    //           ),
    //           ),
    //         style: ElevatedButton.styleFrom(
    //           backgroundColor: Color.fromARGB(255, 126, 13, 13),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
    );
  }
}