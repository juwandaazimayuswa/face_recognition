import 'package:flutter/material.dart';

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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background1.jpeg"),
            fit: BoxFit.cover,
            ),
        ),
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
              'Student@stu.uob.edu.bh',
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
  //onSide Menu
    Widget buildHeader(BuildContext context) => Container(
      color: Color.fromARGB(255, 126, 13, 13),
      padding: EdgeInsets.only(
        top: 24 + MediaQuery.of(context).padding.top,
        bottom: 24,
      ),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 52,
            //backgroundImage: ,
            ),
            SizedBox(height: 12,),
            Text(
              'Student@stu.uob.edu.bh',
              style: TextStyle(fontSize: 18, color: Colors.white),
              ),
        ],
      ),
    );
  
    Widget buildMenuItms(BuildContext context) => Wrap(
      runSpacing: 12, //vertical
      children: [
        //Home Menu
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text('Home'),
          onTap: (){
            Navigator.pushNamed(context, '/home');
          },
        ),
        //Courses
        ListTile(
          leading: const Icon(Icons.menu_book),
          title: const Text('Courses'),
          onTap: (){
            Navigator.pushNamed(context, '/courses');
          },
        ),
         ListTile(
          leading: const Icon(Icons.file_copy_outlined),
          title: const Text('Excuses'),
          onTap: (){
            Navigator.pushNamed(context, '/excuses');
          },
        ),
        const Divider(color: Colors.black,),
        //Settings
        /*ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: (){},
        ),*/
        //LogOut
        ListTile(
          leading: const Icon(Icons.logout_outlined),
          title: const Text('Log Out'),
          onTap: (){
            Navigator.pushNamed(context, '/');
          },
        ),
      ],
    );

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItms(context),
          ],
        ),
      ),
    );

  }
}