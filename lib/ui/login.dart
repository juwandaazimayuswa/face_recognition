import 'dart:ui';

 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:studentapp/utils/auth.dart';


class login extends StatefulWidget {
   login({super.key});

  @override
  State<login> createState() => loginState();
}



class loginState extends State<login> {

final usernameController = TextEditingController();
final passwordController = TextEditingController();
bool isLoading = false;

FocusNode inputNode = FocusNode();
// to open keyboard call this function;
void openKeyboard(){
  FocusScope.of(context).requestFocus(inputNode);
}


  void startLoading() {
    setState((){
      isLoading = true;
    });
  }

  void stopLoading() {
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
  double scrHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(32),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/UOB6-2.png"),
          fit: BoxFit.cover,
          ),
      ),
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body:  SingleChildScrollView(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                     child: const Image( image: AssetImage('images/UoB.png'), width: 170, height: 170 ),
                        ),
                     //),
                    //),
                  //Hello again
                  const Center(
                    child: Text(
                      'University Of Bahrain',
                       style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                        ),
                      ),
                  ),
                    const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      controller: usernameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Email',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ),
                   const SizedBox(height: 10),
                   Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.red),
                          borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Password',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                   ),
                   const SizedBox(height: 20),
                    Container(
                     height: 60,
                     width: 360,
                     decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: const Color.fromARGB(255, 90, 4, 4),
                  width: 2.0,
                 ),
                   borderRadius: BorderRadius.circular(12)
                   ),
                   child: ElevatedButton(
                    onPressed: ()async{
                      debugPrint("Logging user in");
                      startLoading();
                      try{
                        await loginUser(email: usernameController.text, password: passwordController.text, context: context);
                      }catch(e) {
                        debugPrint("$e");
                      }
                      stopLoading();
                      // Navigator.pushNamed(context, '/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 126, 13, 13),
                    ),
                    child: const Text(
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
      ),
    );
    
  }    
}



