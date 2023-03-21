import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String? name;
  String? id;
  List<String?> students;
  String? code;

  Course({this.name, this.id, this.students = const [], this.code});

  factory Course.fromfirestore(var document) {
    final data = document.data() as Map<String, dynamic>;
    return Course(
      name: data['name'] as String,
      id: data['id'] as String,
      students : data['students'] as List<String?>,
      code: data['code'] as String
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name' : name,
      'id' : id,
      'students' : students,
      'code' : code
    };
  }

  void addStudent(String newStudentId) {
    students.add(newStudentId);
  }

  void removeStudent(String studentId) {
    students.remove(studentId);
  }

  bool get isStudPresent {
    return students.contains(FirebaseAuth.instance.currentUser!.uid);
  }

}