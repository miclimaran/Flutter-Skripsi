import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sekolah_app/Model/DataUser.dart';
import 'package:sekolah_app/Model/UserRepo.dart';
import 'package:sekolah_app/StudentAndroid/LogInPage.dart';

void main() {
  runApp(AttendanceStudentTop());
}

class AttendanceStudentTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Homepage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => AttendanceStudent(),
      },
    );
  }
}

class AttendanceStudent extends StatefulWidget {
  @override
  _AttendanceStudentState createState() => _AttendanceStudentState();
}

class _AttendanceStudentState extends State<AttendanceStudent> {
  String userEmail = DataUser().email;
  UserRepo userRepo = UserRepo();
  final String username = "Michael";
  final String imageUrl = "images/Profile.png";
  String attendance = "";

  final List<Map<String, String>> lectureSchedule = [
    {'time': '08:00 AM', 'lecture': 'Mathematics'},
    {'time': '10:00 AM', 'lecture': 'Physics'},
    {'time': '01:00 PM', 'lecture': 'Chemistry'},
    {'time': '03.00 PM', 'lecture': 'Indonesian'},
  ];

  String getFormattedDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    return formattedDate;
  }

  String getFormattedDay() {
    DateTime now = DateTime.now();
    List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];
    int dayIndex = now.weekday - 1;
    return days[dayIndex];
  }

  Future<void> fetchData() async {
    String DateFor = DateFormat('d-M-y').format(DateTime.now());
    attendance = await userRepo.getAttendance(DateFor, userEmail);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
    return Scaffold(
      appBar: AppBar(title: Text('Absen Page')),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(50.0),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      DateFormat('hh:mm a').format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      attendance == "Masuk"
                          ? "Attendance Complete !!"
                          : "Attendance Not Yet Completed For Today !! Please Check with your homeroom teacher !!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
