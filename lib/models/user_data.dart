import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';


class UserData {

  late String name;
  late String userId;
  late String faceIdUrl;
  late String profilePicUrl;
  late String email;
  late String password;

  UserData({required this.name, required this.userId, required this.faceIdUrl, required this.profilePicUrl, required this.email, required this.password});

  factory UserData.fromFirestore(var doc) {
    Map<String, dynamic> data = doc as Map<String, dynamic>;
    return UserData(
      name: data['name'],
      userId: data['id'],
      faceIdUrl: data['face_id_url'],
      profilePicUrl: data['profile_pic_url'],
      email: data['email'],
      password: data['password']
    );
  }

}