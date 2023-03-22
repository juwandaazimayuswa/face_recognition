import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/constants.dart';
import 'package:studentapp/widgets/navigation_drawer.dart';

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class Excuses extends StatefulWidget {
  const Excuses({super.key});

  @override
  State<Excuses> createState() => ExcusesState();
}

class ExcusesState extends State<Excuses> {
 
final textController = TextEditingController();
final NoteController = TextEditingController();

 // file picker

 void openFiles() async {
  FilePickerResult? resultFile = await FilePicker.platform.pickFiles();
    if(resultFile != null){
      PlatformFile file = resultFile.files.first;
      debugPrint(file.name);
      debugPrint("${file.bytes}");
      debugPrint(file.extension);
      debugPrint(file.path);
  } else{
    // if the user cancelled the picker
  }
 }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excuses'),
        backgroundColor: kAppColor,
      ),
      //backgroundColor: Colors.grey,
      drawer: const NavigationDrawer() ,
      //Body
      body: Column(
        children: [
          SizedBox(height: 20,),
          Center(
              child: Text(
                'Choose Your Course',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  ),
                ),
            ),
            //dropDown list
            
            SizedBox(height: 10,),
            DropdownButtonExample(),
            SizedBox(height: 80,),
            // import text field

            Padding(
              padding: const EdgeInsets.fromLTRB(50, 25, 70, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Import Your Excuses File',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  SizedBox(height: 15,),
                  // Import text filed
                  TextField(
                    
                    enabled: true,
                    controller: textController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Drag or Import',
                      suffixIcon: IconButton(
                        onPressed: (){
                          //Clearing Textfield 
                          textController.clear();
                        },
                        icon: Icon(Icons.clear),
                      ),
                      ),
                  ),
                  // import button

                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 40, 20, 10),
                    child: MaterialButton(
                      onPressed: () {
                        // file picker
                        openFiles();
                      },
                      color: kAppColor,
                      child: Text(
                        'Import',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                        ),
                    ),
                  ),
                ],
              ),
            ),
            // Add Note

            Padding(
              padding: const EdgeInsets.fromLTRB(40, 150, 60, 10),
              child: Column(
                children: [
                TextField(
                  controller: NoteController,
                  decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Add a note//',
                  ),
                ),
              ],
              ),
            ),
            
            // Submit button

              Padding(
                padding: const EdgeInsets.fromLTRB(30, 50, 20, 50),
                child: SizedBox(
                  height:50 , width:1000 ,
                  child: ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: ButtonStyle(
                      backgroundColor: 
                      MaterialStatePropertyAll<Color>(Color.fromARGB(255, 126, 13, 13)),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}


// DropDown List
class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        padding: EdgeInsets.fromLTRB(70, 1, 70, 1),
        decoration: BoxDecoration(color: Colors.white70,
         border: Border.all(color: Color.fromARGB(255, 126, 13, 13)),
         ),
        // dropDown Button
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(fontSize: 22, color: Color.fromARGB(255, 126, 13, 13)),
          underline: Container(
            height: 2,
            color: Color.fromARGB(255, 126, 13, 13),
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}