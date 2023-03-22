import 'package:flutter/material.dart';
import 'package:studentapp/widgets/firebase_image.dart';
import 'package:studentapp/constants.dart';

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
        child: FirebaseImage(
          imageUrl: 'https://firebasestorage.googleapis.com/v0/b/${kProjectId}.appspot.com/o/[IMAGE_PATH]' ,
        ),
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