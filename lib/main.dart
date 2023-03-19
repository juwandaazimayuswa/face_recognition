import 'package:flutter/material.dart';

import 'ui/excuses.dart';
import 'ui/login.dart';
import 'ui/home.dart';
import 'ui/courses.dart';
import 'ui/getMoreStudentInfo/getFaceId.dart';
import 'ui/getMoreStudentInfo/getMoreStudentInfo.dart';

void main() async { 
  //WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();

   runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/':(context) => login(),
      '/home':(context) => Home(),
      '/courses':(context) => Courses(),
      '/excuses':(context) => Excuses(),
      '/getMoreStudentInfo' : (context) => GetMoreStudentInfo(),
      '/getFaceId' : (context) => GetFaceId()

    },
  ));
}