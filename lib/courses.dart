import 'package:flutter/material.dart';

import 'home.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => CoursesState();
}

class CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
        backgroundColor: Color.fromARGB(255, 126, 13, 13),
      ),
      drawer: const NavigationDrawer() ,
      // Body
      
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            
          },
          child: Text(
            'Attendence',
            style: TextStyle(
              fontSize: 20,
            ),
            ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 126, 13, 13),
          ),
        ),
      ],
    ),
    );
  }
}