import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sekolah_app/Model/DataUser.dart';
import 'package:sekolah_app/Model/UserRepo.dart';
import 'package:sekolah_app/StudentAndroid/Homepage2.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SubmitFeedback());
}

class FeedbackModel {
  final String feedback;
  final String teacherId;
  final String studentId;
  final Timestamp date;

  FeedbackModel({
    required this.feedback,
    required this.teacherId,
    required this.studentId,
    required this.date,
  });

  factory FeedbackModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return FeedbackModel(
      feedback: data['feedback'] ?? '',
      teacherId: data['teacherId'] ?? '',
      studentId: data['studentId'] ?? '',
      date: data['date'] ?? Timestamp.now(),
    );
  }
}

class SubmitFeedback extends StatelessWidget {
  UserRepo userRepo = UserRepo();
  List<String> teachers = [];
  String userEmail = DataUser().email;
  String studentId = 'TEST';
  String teacherId = 'TEST';

  final CollectionReference _feedbackCollection = FirebaseFirestore.instance.collection('Feedback');

  @override
  Widget build(BuildContext context) {
    TextEditingController _feedbackController = TextEditingController();

    @override
    void dispose() {
      _feedbackController.dispose();
    }

    return FutureBuilder<List<String>>(
      future: userRepo.getTeacher(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          teachers = snapshot.data!;

          return MaterialApp(
            title: 'Submit Feedback',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: Scaffold(
              appBar: AppBar(
                title: Text('Submit Feedback'),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
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
                              'Feedback & Suggestion',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: TextField(
                                controller: _feedbackController,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  hintText: 'Insert your feedback and suggestion here...',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.all(10.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Ditujukan Kepada',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: DropdownButtonFormField<String>(
                                value: teachers.first,
                                items: teachers.map((String teacher) {
                                  return DropdownMenuItem<String>(
                                    value: teacher,
                                    child: Text(teacher),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  // Handle dropdown value change
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                studentId = await userRepo.getStudentIdbyEmail(userEmail);
                                String selectedTeacher = teachers.first;
                                teacherId = await userRepo.getTeacherIdbyName(selectedTeacher);
                                String feedback = _feedbackController.text.trim();
                                
                                if (feedback.isNotEmpty) {
                                  await submitFeedbackToFirestore(feedback, teacherId, studentId);
                                  _showFeedbackSentDialog(context);
                                } else {
                                  _showErrorDialog(context, 'Feedback cannot be empty.');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.black,
                              ),
                              child: Text('Submit'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

    String getFormattedDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    return formattedDate;
  }

  Future<void> submitFeedbackToFirestore(String feedback, String teacherId, String studentId) async {
    try {
      await _feedbackCollection.add({
        'feedback': feedback,
        'teacherId': teacherId,
        'studentId': studentId,
        'date': getFormattedDate(),
      });
    } catch (e) {
      print('Error submitting feedback to Firestore: $e');
      // Handle the error as needed
    }
  }

  Future<void> _showFeedbackSentDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 60),
                SizedBox(height: 20),
                Text(
                  'Feedback Sent!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Thank you for your feedback.',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage2()),
                    );
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showErrorDialog(BuildContext context, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.error, color: Colors.red, size: 60),
                SizedBox(height: 20),
                Text(
                  'Error!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
