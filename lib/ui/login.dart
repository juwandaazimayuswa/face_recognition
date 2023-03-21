import 'dart:ui';

 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'package:studentapp/utils/auth.dart';


class login extends StatefulWidget {
   login({super.key});

  @override
  State<login> createState() => loginState();
}



class loginState extends State<login> {

final usernameController = TextEditingController();
final passwordController = TextEditingController();

FocusNode inputNode = FocusNode();
// to open keyboard call this function;
void openKeyboard(){
  FocusScope.of(context).requestFocus(inputNode);
}

  @override
  Widget build(BuildContext context) {
  double scrHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/UOB6-2.png"),
          fit: BoxFit.cover,
          ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:  SingleChildScrollView(
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    //decoration: BoxDecoration(
                      //image: DecorationImage(
                   child: Image( image: AssetImage('images/UoB.png'), width: 170, height: 170 ),
                      ),
                   //),
                  //),
                //Hello again
                Center(
                  child: Text(
                    'University Of Bahrain',
                     // ignore: prefer_const_constructors
                     style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                      ),
                    ),
                ),
                  SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: usernameController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Email',
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                  ),
                 SizedBox(height: 10),
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(12),
                        ),
                        hintText: 'Password',
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                    ),
                 ),
                 SizedBox(height: 20),
                // sign in buttun
                  Container(
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
                    debugPrint("Logging user in");
                    loginUser(email: usernameController.text, password: passwordController.text, context: context);
                    // Navigator.pushNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 126, 13, 13),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                 ),
                  )
              ]
              ),
            ),
        ),
      ),
    );
    
  }    
}



