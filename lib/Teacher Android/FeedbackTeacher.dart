import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sekolah_app/Model/FeedbackModel.dart'; // Adjust the path as per your project structure

class FeedbackTeacher extends StatelessWidget {
  final String teacherId; // Assuming you'll pass teacherId to filter feedbacks
  final CollectionReference feedbackCollection =
      FirebaseFirestore.instance.collection('Feedback');

  FeedbackTeacher({required this.teacherId});

  @override
  Widget build(BuildContext context) {
    DateTime thirtyDaysAgo = DateTime.now().subtract(Duration(days: 100));

    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback Viewer'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: feedbackCollection
            .where('teacherId', isEqualTo: teacherId)
            .where('date', isGreaterThanOrEqualTo: DateFormat('dd-MM-yyyy').format(thirtyDaysAgo))
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No feedback available in the last 30 days.'));
          }

          List<FeedbackModel> feedbackList = snapshot.data!.docs
              .map((doc) => FeedbackModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

          return ListView.builder(
            itemCount: feedbackList.length,
            itemBuilder: (context, index) {
              return FeedbackCard(
                date: feedbackList[index].date,
                feedback: feedbackList[index].feedback,
                studentId: feedbackList[index].studentId,
              );
            },
          );
        },
      ),
    );
  }
}

class FeedbackCard extends StatelessWidget {
  final String date;
  final String feedback;
  final String studentId;

  FeedbackCard({
    required this.date,
    required this.feedback,
    required this.studentId,
  });

  Future<String> getStudentNamebyIdss(String id) async {
    String studentName = "";

    print(id);

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: id)
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
        studentName = user['name'] as String;
      }
    } catch (e) {
      print('Error fetching student name: $e');
    }

    print(studentName);

    return studentName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$date',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Feedback: $feedback',
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            FutureBuilder<String>(
              future: getStudentNamebyIdss(studentId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text(
                    'Loading student name...',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return Text(
                    'Error loading student name',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  );
                }
                return Text(
                  'Student Name: ${snapshot.data}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
