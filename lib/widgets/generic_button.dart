import "package:flutter/material.dart";
import 'package:studentapp/constants.dart';


class GenericButton extends StatelessWidget {
  Function onPressed;
  String text;
  bool isEnabled;

  GenericButton({Key? key,required this.onPressed, required this.text, this.isEnabled = true}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        width: 360,
        decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(
              color: Color.fromARGB(255, 90, 4, 4),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12)
        ),
        child: ElevatedButton(
          onPressed: (){
            onPressed();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isEnabled ?  kEnabledButtonColor : kDisabledButtonColor,
          ),
          child: Text(
           text ,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
  }
}
