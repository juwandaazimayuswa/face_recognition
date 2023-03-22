import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_storage/firebase_storage.dart";
import "dart:io";
import "package:http/http.dart" as http;
import 'package:path_provider/path_provider.dart';

Future<File> getFaceId({String path = "face_ids/"}) async{
  // Get a reference to the image file in Firebase Cloud Storage
  Reference ref = FirebaseStorage.instance.ref(path);

  // Download the image data using its URL
  String downloadUrl = await ref.getDownloadURL();

  // Get the temporary directory to store the downloaded image
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;

  // Generate a unique file name for the downloaded image
  String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.png';
  String filePath = '$tempPath/$fileName';

  // Write the image data to a temporary file
  File file = File(filePath);
  http.Response response = await http.get(Uri.parse(downloadUrl));
  await file.writeAsBytes(response.bodyBytes);

  return file;
}





