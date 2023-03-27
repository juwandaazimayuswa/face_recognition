// import 'dart:html';
import 'dart:io';

import "package:firebase_auth/firebase_auth.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "package:flutter/material.dart";
import 'package:studentapp/models/user_data.dart';
import "package:studentapp/ui/getMoreStudentInfo/getMoreStudentInfo.dart";
import "package:path/path.dart" as path;
import '../ui/home/home.dart';
import 'package:studentapp/data/user_data.dart';


Future<void> loginUser({ required String email,  required String password, required BuildContext context}) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    debugPrint('Logged in user: ${userCredential.user!.email}');
    if(await isUserInfoComplete(userEmail: email, userPwd: password, context: context)) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      debugPrint("Failed to log user in");
      await FirebaseAuth.instance.signOut();
    }
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


Future<bool> isUserInfoComplete({required String userEmail, required String userPwd, required BuildContext context}) async{
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  //Try getting this users information
  try{
    late DocumentSnapshot doc;
    await db.runTransaction((transaction) async{
      DocumentReference userDocRef = db.collection("students").doc(auth.currentUser!.uid);
      doc = await transaction.get(userDocRef);
    });

    debugPrint("User data from firebase: \n profile_pic_url: ${doc['profile_pic_url']}\n face_id: ${doc['face_id']}");

    if(doc.exists && doc['profile_pic_url'] != null && doc['face_id'] != null) {
      debugPrint("Successfully retrieved user data from firebase");
      myUserData = UserData.fromFirestore(doc);
      return true;
    }

  } catch(e) {
    debugPrint("$e");
  }

  /// Get more information about the student
  Map<String, dynamic> userInfo = await Navigator.push(context, MaterialPageRoute(builder: (context) => GetMoreStudentInfo()));

  File profilePicFile = userInfo["profile_pic_file"];
  String profilePicExtension = path.extension(profilePicFile.path);
  List? faceId = userInfo["face_id"];
  // String faceIdFileExtension = path.extension(faceIdFile.path);
  String filename = auth.currentUser!.uid;
  Reference profilePicStorageRef = storage.ref().child('profile_pictures/$filename$profilePicExtension');
  // Reference faceIdStorageRef = storage.ref().child('face_ids/$filename$faceIdFileExtension');

  UploadTask profilePicUploadTask =  profilePicStorageRef.putFile(profilePicFile);
  // UploadTask faceIdUploadTask = faceIdStorageRef.putFile(faceIdFile);
  // bool isFaceIdUploadComplete = false;
  bool isProfilePicUploadComplete = false;
  int timeout = 120000; // timeout after 60000 milliseconds
  int uploadTime = 0;

  ///Get download urls

  String? profilePicDownloadUrl;
  // String? faceIdDownloadUrl;

  // try {
  //   profilePicDownloadUrl = await profilePicStorageRef.getDownloadURL();
  //   faceIdDownloadUrl = await faceIdStorageRef.getDownloadURL();
  //   debugPrint("Profile Pic download UrL: $profilePicDownloadUrl");
  //   debugPrint("face Id download Url: $faceIdDownloadUrl");
  // } catch(e) {
  //   debugPrint("Unable to get download url: $e");
  //   return false;
  // }


  //listen to upload task as and update the ui accordingly
  profilePicUploadTask.snapshotEvents.listen((taskSnapshot) async{
    /// Update the ui based on the amount of the file uploaded
  });

  // faceIdUploadTask.snapshotEvents.listen((taskSnapshot) async{
  //   /// Update the ui based on the amount of the file uploaded
  // });
  //
  // faceIdUploadTask.whenComplete(() async{
  //   faceIdDownloadUrl = await faceIdStorageRef.getDownloadURL();
  //   debugPrint("face Id download Url: $faceIdDownloadUrl");
  //   isFaceIdUploadComplete = true;
  // });

  profilePicUploadTask.whenComplete(()async{
    profilePicDownloadUrl = await profilePicStorageRef.getDownloadURL();
    debugPrint("Profile Pic download UrL: $profilePicDownloadUrl");
    isProfilePicUploadComplete = true;
  });

  /// check at interval of 100 milliseconds if the upload process is complete
  while((isProfilePicUploadComplete == false)) {
    await Future.delayed(const Duration(milliseconds: 100));
    uploadTime += 100;
    if (uploadTime > timeout) {
      debugPrint("Profile pic upload timeout");
      break;
    }
  }

  if (uploadTime > timeout) return false;

  ///Save complete user details in firestore database
  debugPrint("Saving user data in database");
  try {
    DocumentReference docRef = db.collection("students").doc(auth.currentUser!.uid);
    await docRef.set(
      { "name": "N/A",
        "email": userEmail,
        "password": userPwd,
        "profile_pic_url": profilePicDownloadUrl,
        "face_id": faceId
      }, SetOptions(merge: true));

    // await db.runTransaction((transaction) async{
    //   transaction.set(docRef, {
    //     "name": "N/A",
    //     "email": userEmail,
    //     "password": userPwd,
    //     "profile_pic_url": profilePicDownloadUrl,
    //     "face_id_url": faceIdDownloadUrl
    //   }, SetOptions(merge: true));
    // });

    myUserData = UserData(
        name: "N/A",
        userId: auth.currentUser!.uid,
        faceId: faceId ?? [],
        profilePicUrl: profilePicDownloadUrl ?? "",
        email: userEmail,
        password: userPwd);

    debugPrint("Successfully saved user data");
    return true;
  } catch(e) {
    debugPrint("Failed to save user data");
    debugPrint("$e");
    return false;
  }

}

Future<void> signOut(BuildContext context) async{
  FirebaseAuth.instance.signOut();
  Navigator.pushNamed(context, '/');
}