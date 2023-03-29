import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> addStudentToCourse({required String courseId, required String studentId}) async{
  FirebaseFirestore db = FirebaseFirestore.instance;
  DocumentReference docRef = db.collection("courses").doc(courseId);
  try {
    await docRef.set({
      'students': FieldValue.arrayUnion([studentId])
    },SetOptions(merge: true));
  }catch(e) {
    debugPrint("Failed to add student to course list");
    debugPrint("$e");
    return false;
  }
  return true;
}