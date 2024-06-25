import 'package:flutter/material.dart';
import 'package:sekolah_app/StudentAndroid/Homepage2.dart';
import 'package:sekolah_app/StudentAndroid/ProfileStudent.dart';

void main() {
  runApp(MyAccountStudent());
}

class MyAccountStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Account',

      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyAccountScreenStudent(),
    );
  }
}

class MyAccountScreenStudent extends StatelessWidget {
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
              MaterialPageRoute(builder: (context) => ProfileStudent()),
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
                    radius: 70,
                    backgroundImage: AssetImage(
                        'images/Profile.png'), // Replace with user's profile image
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
            buildTextField(
                'Username', 'Michael Limaran'), // Replace with user data
            buildTextField('Role', 'Student'), // Replace with user data
            buildTextField('Wali Kelas', 'XII IPA 2'), // Replace with user data
            buildTextField('Email',
                'Michael.limaran@student.ac.id'), // Replace with user data
            buildTextField(
                'Phone Number', '08123456789'), // Replace with user data
            buildTextField('Gender', 'Male'), // Replace with user data
            buildTextField(
                'Date of Birth', 'January 1, 2000'), // Replace with user data
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
