import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/constants.dart';
import 'package:studentapp/utils/ml_service.dart';

import 'ui/courses.dart';
import 'ui/excuses.dart';
import 'ui/getMoreStudentInfo/getFaceId.dart';
import 'ui/getMoreStudentInfo/getMoreStudentInfo.dart';
import 'ui/home/home.dart';
import 'ui/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await MLService.initialize();

  runApp(MaterialApp(
    initialRoute: '/',
    theme: ThemeData(
      primaryColor: kAppColor,
      primarySwatch: kMaterialAppColor,
    ),
    routes: {
      '/': (context) => login(),
      '/home': (context) => const Home(),
      '/courses': (context) => const Courses(),
      '/excuses': (context) => const Excuses(),
      '/getMoreStudentInfo': (context) => GetMoreStudentInfo(),
      '/getFaceId': (context) => GetFaceId()
    },
  ));
}
