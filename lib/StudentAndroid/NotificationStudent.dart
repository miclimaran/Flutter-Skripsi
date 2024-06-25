import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(NotificationStudent());
}

class NotificationStudent extends StatefulWidget {
  @override
  _NotificationStudentState createState() => _NotificationStudentState();
}

class _NotificationStudentState extends State<NotificationStudent> {
  late Stream<List<Map<String, dynamic>>> _notificationsStream;

  @override
  void initState() {
    super.initState();
    _notificationsStream = fetchNotifications();
  }

  Stream<List<Map<String, dynamic>>> fetchNotifications() {
    return FirebaseFirestore.instance.collection('Announcement').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'adminId': doc['adminId'],
          'announcement': doc['announcement'],
          'date': doc['date'],
        };
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Announcement Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Announcement'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _notificationsStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            List<Map<String, dynamic>> notifications = snapshot.data ?? [];

            if (notifications.isEmpty) {
              return Center(child: Text('No Announcement Available'));
            }

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return NotificationBox(
                  adminId: notifications[index]['adminId'],
                  announcement: notifications[index]['announcement'],
                  date: notifications[index]['date'],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class NotificationBox extends StatelessWidget {
  final String adminId;
  final String announcement;
  final String date;

  NotificationBox({
    required this.adminId,
    required this.announcement,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    DateTime parsedDate;
    try {
      parsedDate = DateFormat('dd-MM-yyyy').parse(date);
    } catch (e) {
      parsedDate = DateTime.now(); // Provide a default fallback date if parsing fails
    }

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
              '${DateFormat('dd-MM-yyyy').format(parsedDate)}',
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
