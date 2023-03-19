import 'dart:io';

import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import "package:studentapp/ui/getMoreStudentInfo/getMoreStudentInfo.dart";
import "package:path/path.dart" as path;

Future<void> loginUser(String email, String password, BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    debugPrint('Logged in user: ${userCredential.user!.email}');
    // replace this print statement with the code to navigate to the next screen
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      debugPrint('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      debugPrint('Wrong password provided for that user.');
    } else {
      debugPrint('Error: ${e.message}');
    }
  } catch (e) {
    debugPrint('Error: $e');
  }
}



Future<bool> isUserInfoComplete(String userEmail, String userPwd, BuildContext context) async{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;



  //Try getting this users information
  try{
    DocumentSnapshot doc = await db.collection("students").doc(auth.currentUser!.uid).get();
    if(doc.exists) return true;
  } catch(e) {
    debugPrint("$e");
  }


  Map<String, dynamic> userInfo = await Navigator.push(context, MaterialPageRoute(builder: (context) => GetMoreStudentInfo()));
  File profilePicFile = userInfo["profile_pic_file"];
  String profilePicExtension = path.extension(profilePicFile.path)
  File faceIdFile = userInfo["face_id_file"];
  String faceIdFileExtension = path.extension(faceIdFile.path);
  String filename = auth.currentUser!.uid;
  Reference profilePicStorageRef = storage.ref().child('profile_pictures/$filename.$profilePicExtension');
  Reference faceIdStorageRef = storage.ref().child('face_ids/$filename.$faceIdFileExtension');
  String? profilePicDownloadUrl;
  String? faceIdDownloadUrl;
  UploadTask profilePicUploadTask =  profilePicStorageRef.putFile(profilePicFile);
  UploadTask faceIdUploadTask = faceIdStorageRef.putFile(faceIdFile);

  //listen to upload task as and update the ui accordingly
  profilePicUploadTask.snapshotEvents.listen((taskSnapshot) async{
    if (profilePicDownloadUrl == null) {
      profilePicDownloadUrl = await taskSnapshot.ref.getDownloadURL();
    }
    /// Update the ui based on the amount of the file uploaded
  });

  faceIdUploadTask.snapshotEvents.listen((taskSnapshot) async{
    if (faceIdDownloadUrl == null) {
      faceIdDownloadUrl = await taskSnapshot.ref.getDownloadURL();
    }
    /// Update the ui based on the amount of the file uploaded
  });





  ///Save complete user details in firestore database
  await db.runTransaction((transaction) async{
    DocumentReference docRef = db.collection("students").doc(auth.currentUser!.uid);
    transaction.set(docRef, {
      "name" : "N/A",
      "email" : userEmail,
      "password" : userPwd,
    })
  });


}