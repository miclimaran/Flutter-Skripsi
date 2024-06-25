import 'package:flutter/material.dart';
import 'package:sekolah_app/Teacher%20Android/ProfileTeacher.dart';

void main() {
  runApp(MyAccountTeacher());
}

class MyAccountTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Account',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAccountScreenTeacher(),
    );
  }
}

class MyAccountScreenTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileTeacher()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('images/Profile.png'), // Replace with user's profile image
                  ),
                  SizedBox(height: 16),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     // Functionality to change profile picture
                  //     // Implement your logic here
                  //   },
                  //   child: Text('Change Profile Picture'),
                  // ),
                ],
              ),
            ),
            SizedBox(height: 20),
            buildTextField('Username', 'Kevin'), // Replace with user data
            buildTextField('Role', 'Teacher'), // Replace with user data
            buildTextField('Wali Kelas', 'X IPA 2'), // Replace with user data
            buildTextField('Email', 'Kevin@example.com'), // Replace with user data
            buildTextField('Phone Number', '123-456-7890'), // Replace with user data
            buildTextField('Gender', 'Male'), // Replace with user data
            buildTextField('Date of Birth', 'January 1,1980'), // Replace with user data
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String title, String content) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(content),
          ),
        ],
      ),
    );
  }
}
