import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sekolah_app/Admin%20Android/ClassroomAdmin.dart';

void main() {
  runApp(MaterialApp(
    title: 'Create New Class',
    home: CreateNewClassPage(),
  ));
}

class CreateNewClassPage extends StatefulWidget {
  @override
  _CreateNewClassPageState createState() => _CreateNewClassPageState();
}

class _CreateNewClassPageState extends State<CreateNewClassPage> {
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController waliKelasController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> createClass(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      String className = classNameController.text.trim();
      String waliKelas = waliKelasController.text.trim();

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      CollectionReference classes = firestore.collection('classes');

      await classes.add({
        'name': className,
        'teacherId': waliKelas,
      });

      // Display a success message
      print('Class created successfully');

      classNameController.clear();
      waliKelasController.clear();

      // Show a pop-up dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Class Created'),
            content: Text('The class has been created successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  // Navigate to the ClassroomAdmin page after acknowledging the dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => ClassroomAdminPage()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Classroom'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: classNameController,
                decoration: InputDecoration(
                  labelText: 'Nama Kelas',
                  hintText: 'Enter the class name',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Class Name is required.';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: waliKelasController,
                decoration: InputDecoration(
                  labelText: 'Homeroom Teacher Id',
                  hintText: 'Enter the Homeroom Teacher Id',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Homeroom Teacher ID is required.';
                  }
                  if (!value.startsWith('TCH')) {
                    return 'Homeroom Teacher ID must start with "TCH".';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  createClass(context); // Pass the context to the function
                },
                child: Text('Create Class'),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF3D73EB),
                  onPrimary: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
