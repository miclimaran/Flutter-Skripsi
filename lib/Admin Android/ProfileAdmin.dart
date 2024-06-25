import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sekolah_app/Admin%20Android/HomepageAdmin.dart';
import 'package:sekolah_app/Admin%20Android/MyAccountAdmin.dart';
import 'package:sekolah_app/Model/UserRepo.dart';
import 'package:sekolah_app/StudentAndroid/LogInPage.dart';
import 'package:sekolah_app/Teacher%20Android/HomepageTeacher.dart';
import 'package:sekolah_app/Teacher%20Android/MyAccountTeacher.dart';
import 'package:sekolah_app/UserAuth/firebase_auth_services.dart';
import 'package:sekolah_app/Model/DataUser.dart';

void main() {
  runApp(ProfileAdmin());
}

class ProfileAdmin extends StatelessWidget {
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
                MaterialPageRoute(builder: (context) => HomepageAdmin()),
              );
            },
          ),
        ),
        body: ProfileContentAdmin(),
      ),
    );
  }
}

class ProfileContentAdmin extends StatefulWidget {
  @override
  _ProfileContentAdminState createState() => _ProfileContentAdminState();
}



class _ProfileContentAdminState extends State<ProfileContentAdmin> {

  String Email = DataUser().email;
  String AdminName = '';

  @override
  void initState() {
    super.initState();
    fetchStudentDetails();
  }

  Future<void> fetchStudentDetails() async {
    // Simulating the data fetching process
    // Replace this with the actual logic to fetch student details
    UserRepo userRepo = UserRepo();
    String studentDetails = await userRepo.getAdminNamebyEmail(Email);

    // Simulated data
    // List<String> studentDetails = [
    //   'Name: Michael Limaran',
    //   'Email: Michael.limaran@student.ac.id',
    //   'Role: Student',
    //   'ID: STD001',
    //   'Class: XA1',
    // ];

    setState(() {
      AdminName = studentDetails;
    });
  }
  
  @override
  Widget build(BuildContext context) {
fetchStudentDetails();
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
                    AdminName, // Replace with actual teacher's name
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Admin', // Replace with actual teacher's role
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),

          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyAccountAdmin()),
              );
              print('Navigate to My Account');
            },
            icon: Icon(Icons.account_circle),
            label: Text('My Account'),
            style: ElevatedButton.styleFrom(primary: Colors.transparent, onPrimary: Colors.black),
          ),
          // ElevatedButton.icon(
          //   onPressed: () {
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
