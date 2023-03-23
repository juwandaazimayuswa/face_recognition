import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class UserData {

  late String name;
  late String userId;
  late String faceIdUrl;
  late String profilePicUrl;
  late String email;
  late String password;

  UserData({required this.name, required this.userId, required this.faceIdUrl, required this.profilePicUrl, required this.email, required this.password});

  factory UserData.fromFirestore(var doc) {
    late Map<String, dynamic> data;
    try {
      data = doc.data() ?? {};
    } catch(e) {
      debugPrint("Unable to extract data from user document: $e");
    }

    return UserData(
      name: data['name'],
      userId: data['id'] ?? FirebaseAuth.instance.currentUser!.uid,
      faceIdUrl: data['face_id_url'],
      profilePicUrl: data['profile_pic_url'],
      email: data['email'],
      password: data['password']
    );
  }

}