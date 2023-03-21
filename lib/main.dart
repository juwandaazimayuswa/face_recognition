import 'package:flutter/material.dart';
import 'package:studentapp/constants.dart';

import 'ui/excuses.dart';
import 'ui/login.dart';
import 'ui/home.dart';
import 'ui/courses.dart';
import 'ui/getMoreStudentInfo/getFaceId.dart';
import 'ui/getMoreStudentInfo/getMoreStudentInfo.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

   runApp(MaterialApp(
    initialRoute: '/',
    theme: ThemeData(
      primaryColor: kAppColor,
      primarySwatch: MaterialColor(),
    ),
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