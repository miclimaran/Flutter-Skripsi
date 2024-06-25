import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sekolah_app/Admin%20Android/MyAccountAdmin.dart';
import 'package:sekolah_app/StudentAndroid/Homepage2.dart';
import 'package:sekolah_app/StudentAndroid/LogInPage.dart';
import 'package:sekolah_app/StudentAndroid/MyAccountStudent.dart';
import 'package:sekolah_app/UserAuth/firebase_auth_services.dart';

void main() {
  runApp(ProfileStudent());
}

class ProfileStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Homepage2()),
            );
          },
        ),
          
        ),
        body: ProfileStudentContent(),
      ),
    );
  }
}

class ProfileStudentContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            elevation: 4.0,
            color: Colors.blue, // Set the card background color
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('images/Profile.png'), // Replace with teacher's image
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Michael', // Replace with actual teacher's name
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'XII IPA 2', // Replace with actual teacher's role
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyAccountStudent()));
              print('Navigate to My Account');
            },
            icon: Icon(Icons.account_circle),
            label: Text('My Account'),
            style: ElevatedButton.styleFrom(primary: Colors.transparent, onPrimary: Colors.black),
          ),
          // ElevatedButton.icon(
          //   onPressed: () {
          //     // TODO: Navigate to About App screen
          //     // Replace the above line with navigation to your About App screen
          //     print('Navigate to About App');
          //   },
          //   icon: Icon(Icons.info),
          //   label: Text('About App'),
          //   style: ElevatedButton.styleFrom(primary: Colors.transparent, onPrimary: Colors.black),
          // ),
          ElevatedButton.icon(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
              showToast(message: "Successfully signed out");
              print('Log Out');
            },
            icon: Icon(Icons.logout),
            label: Text('Log Out'),
            style: ElevatedButton.styleFrom(primary: Colors.transparent, onPrimary: Colors.black),
          ),
        ],
      ),
    );
  }
}
