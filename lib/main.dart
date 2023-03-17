import 'package:flutter/material.dart';

import 'package:studentapp/excuses.dart';
import 'package:studentapp/login.dart';
import 'package:studentapp/home.dart';
import 'package:studentapp/courses.dart';

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
    },
  ));
}