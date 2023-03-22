import "package:flutter/material.dart";

class FirebaseImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;

  FirebaseImage({required this.imageUrl,  this.width = 40.0,  this.height = 40.0});

  @override
  Widget build(BuildContext context) {
    return Image(
      image: NetworkImage(imageUrl), //Downloads the first time and retrieves the images from Cache the rest of the time.
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}