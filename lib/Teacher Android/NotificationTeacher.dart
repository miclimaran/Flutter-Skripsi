import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Announcement Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NotificationTeacher(),
    );
  }
}

class NotificationTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Announcements'),
      ),
      body: NotificationList(),
    );
  }
}

class NotificationList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Announcement').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        if (documents.isEmpty) {
          return Center(child: Text('No Announcements available'));
        }

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            return NotificationBox(
              adminId: documents[index]['adminId'],
              announcement: documents[index]['announcement'],
              date: documents[index]['date'],
            );
          },
        );
      },
    );
  }
}

class NotificationBox extends StatelessWidget {
  final String adminId;
  final String announcement;
  final dynamic date; // Use dynamic to handle both Timestamp and String

  NotificationBox({
    required this.adminId,
    required this.announcement,
    required this.date,
  });

  DateTime _parseDate(dynamic date) {
    if (date is Timestamp) {
      return date.toDate();
    } else if (date is String) {
      try {
        return DateFormat('dd-MM-yyyy').parse(date);
      } catch (e) {
        return DateTime.now(); // Fallback to current date if parsing fails
      }
    } else {
      return DateTime.now(); // Fallback to current date
    }
  }

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate = _parseDate(date);

    return Card(
      margin: EdgeInsets.all(10),
      color: Color(0xFF3D73EB),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/Profile.png'),
                  radius: 25,
                ),
                SizedBox(width: 10),
                Text(
                  adminId,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              announcement,
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFFFFFFF),
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${DateFormat('dd-MM-yyyy').format(parsedDate)}',
              style: TextStyle(
                fontSize: 12,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
