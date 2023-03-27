import 'package:flutter/material.dart';
import 'package:studentapp/widgets/navigation_drawer.dart';
import 'package:studentapp/data/user_data.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    // Header
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromARGB(255, 126, 13, 13),
      ),
      drawer: const NavigationDrawer() ,
      //backgroundColor: Colors.grey,
      //Body
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(32),
       child: Column(
        children: [
          SizedBox(height: 30,),
          Text(
            'Welcome Back',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            ),
            SizedBox(height: 10,),
            Text(
              myUserData.email,
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 126, 13, 13),
                fontWeight: FontWeight.bold
              ),
              ),
              SizedBox(height: 180,),
              Row(children: [Text(
                'Take Your Attendence',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                  ),
                ),
              ],
              ),
              SizedBox(height: 10,),
                Row( mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(
                  'Now',
                  style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                  ),
                  ),
                  // Click here Button
                  SizedBox(width: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 126, 13, 13),
                    ),
                    onPressed: (){
                      Navigator.pushNamed(context, '/courses');
                    },
                    child: Text(
                      'Click here',
                      style: TextStyle(
                      fontSize: 20,
                      ),
                      ),
                      ),
                  ],
                  ),
        ],
      ),  
      )
    );
  }
}
