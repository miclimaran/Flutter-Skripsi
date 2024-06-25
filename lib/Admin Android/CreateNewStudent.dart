import 'package:flutter/material.dart';
import 'package:sekolah_app/Model/UserRepo.dart';
import 'package:sekolah_app/Model/DataUser.dart';

class CreateNewStudentPage extends StatefulWidget {
  @override
  _CreateNewStudentPageState createState() => _CreateNewStudentPageState();
}

class _CreateNewStudentPageState extends State<CreateNewStudentPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _classController;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _classController = TextEditingController(text: DataUser().adminClassName);
    _roleController = TextEditingController(text: 'Student');
  }

  void createStudent() async {
    if (_formKey.currentState!.validate()) {
      String className = _classController.text.trim();
      String email = _emailController.text.trim();
      String id = _idController.text.trim();
      String name = _nameController.text.trim();
      String role = _roleController.text.trim();

      UserRepo userRepo = UserRepo();
      await userRepo.addStudent(name, email, id, className, role);

      // Navigate back or show a success message
      Navigator.pop(context, true);
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    if (!RegExp(r'^[\w-]+@student\.ac\.id$').hasMatch(value)) {
      return 'Email must be in the format: example@student.ac.id';
    }
    return null;
  }

  String? _validateID(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter ID';
    }
    if (!value.startsWith('STD')) {
      return 'ID must start with "STD"';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _classController,
                decoration: InputDecoration(labelText: 'Class'),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter class';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: _validateEmail,
              ),
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID'),
                validator: _validateID,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _roleController,
                decoration: InputDecoration(labelText: 'Role'),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter role';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                primary: Color(0xFF3D73EB), // Blue color
                padding: EdgeInsets.symmetric(vertical: 15.0),
              ),
                onPressed: createStudent,
                child: Text('Create Student', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
