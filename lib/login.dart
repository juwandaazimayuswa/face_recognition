import 'dart:ui';

 
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/home.dart';


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
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      body:  Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(32),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/UOB6-2.png"),
            fit: BoxFit.cover,
            ),
        ),
          /*decoration: BoxDecoration(
            color: Color.fromARGB(255, 105, 14, 8)
          ),*/
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  //decoration: BoxDecoration(
                    //image: DecorationImage(
                 child: Image( image: AssetImage('images/UoB.png'), width: 170, height: 170,
                 //Image.asset('images/UoB-removebg.png'),
                  ),
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
               /* SizedBox(height: 10),
                Text(
                'Welcome back',
                 style: TextStyle(
                  fontSize: 18,
                  ),
                ),*/
                SizedBox(height: 50),
          
          
              //email textfield
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
              //password textfiled
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
                  Navigator.pushNamed(context, '/home');
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
      
    );
    
  }    
}

/*class loginPage extends StatelessWidget {
  const loginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return Home();
          } else{
            return login();
          }
        }
      ),
    );
  }
}*/






 /*final emailController = TextEditingController();
final passwordController = TextEditingController();

Future signIn() async{
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: emailController.text.trim(),
     password: passwordController.text.trim(),
     );
}

@override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }*/