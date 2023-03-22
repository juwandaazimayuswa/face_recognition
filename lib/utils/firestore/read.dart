import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studentapp/models/course.dart';

Future<List<Course>> getAllCourses() async{
  List<Course> courses = [];
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  QuerySnapshot courseSnapshots = await db.collection("courses").get();
  List<QueryDocumentSnapshot> courseDocs = courseSnapshots.docs;
  for(QueryDocumentSnapshot doc in courseDocs) {
    courses.add(Course.fromfirestore(doc));
  }
  return courses;
}
