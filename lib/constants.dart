import 'package:flutter/material.dart';

const Color kAppColor = Color.fromARGB(255, 126, 13, 13); //Color.fromARGB(255, 126, 13, 13)
const Color kEnabledButtonColor = Color.fromARGB(255, 126, 13, 13);
const Color kDisabledButtonColor = Colors.grey;
MaterialColor kMaterialAppColor = MaterialColor(
  0xFF7E0D0D, // Replace this with your RGB value
  <int, Color>{
    50: kAppColor.withOpacity(0.1), // Lightest shade
    100: kAppColor.withOpacity(0.2),
    200: kAppColor.withOpacity(0.3),
    300: kAppColor.withOpacity(0.4),
    400: kAppColor.withOpacity(0.5),
    500: kAppColor.withOpacity(0.6), // Primary color
    600: kAppColor.withOpacity(0.7),
    700: kAppColor.withOpacity(0.8),
    800: kAppColor.withOpacity(0.9),
    900: kAppColor.withOpacity(1), // Darkest shade
  },
);
const String kProjectId = "bahrain-student-app";
