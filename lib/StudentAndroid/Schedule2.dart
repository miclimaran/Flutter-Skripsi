import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date and time formatting
import 'SubmitFeedback.dart';
import 'AttendanceStudent.dart';

void main() {
  runApp(Schedule2Top());
}

class Schedule2Top extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Homepage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => Schedule2());
          case '/SubmitFeedback':
            return MaterialPageRoute(builder: (_) => SubmitFeedback());
          case '/AttendanceStudent':
            return MaterialPageRoute(builder: (_) => AttendanceStudent());
          // Add more cases for other routes if needed
          default:
            return null;
        }
      },
    );
  }
}

class Schedule2 extends StatelessWidget {
  final String username = "Michael";
  final String imageUrl = "images/Profile.png";

  final Map<String, List<Map<String, String>>> weekSchedule = {
    'Monday': [
      {'time': '08:00 AM', 'lecture': 'Matematika'},
      {'time': '10:00 AM', 'lecture': 'Fisika'},
      {'time': '01:00 PM', 'lecture': 'Kimia'},
      {'time': '03:00 PM', 'lecture': 'Sejarah'},
    ],
    'Tuesday': [
      {'time': '08:00 AM', 'lecture': 'Bahasa Indonesia'},
      {'time': '10:00 AM', 'lecture': 'Bahasa Inggris'},
      {'time': '01:00 PM', 'lecture': 'Fisika'},
      {'time': '03:00 PM', 'lecture': 'Akuntansi'},
    ],
    'Wednesday': [
      {'time': '08:00 AM', 'lecture': 'Sejarah'},
      {'time': '10:00 AM', 'lecture': 'Biologi'},
      {'time': '01:00 PM', 'lecture': 'Fisika'},
      {'time': '03:00 PM', 'lecture': 'Matematika'},
    ],
    'Thursday': [
      {'time': '08:00 AM', 'lecture': 'Matematika'},
      {'time': '10:00 AM', 'lecture': 'OR'},
      {'time': '01:00 PM', 'lecture': 'Bahasa Mandarin'},
      {'time': '03:00 PM', 'lecture': 'Fisika'},
    ],
    'Friday': [
      {'time': '08:00 AM', 'lecture': 'Geografi'},
      {'time': '10:00 AM', 'lecture': 'Seni Musik'},
      {'time': '01:00 PM', 'lecture': 'IT'},
      {'time': '03:00 PM', 'lecture': 'Seni Lukis'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    String currentDay = DateFormat('EEEE').format(DateTime.now());
    List<Map<String, String>> lectureSchedule = weekSchedule[currentDay] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Schedule',
          style: TextStyle(
            color: Colors.white, // Text color of the app bar title
          ),
        ),
        backgroundColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white), // Back button color
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: lectureSchedule.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            lectureSchedule[index]['time']!,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: Text(
                              lectureSchedule[index]['lecture']!,
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.blue[900],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SubmitFeedback()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Submit Feedback'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AttendanceStudent()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('See Attendance'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
