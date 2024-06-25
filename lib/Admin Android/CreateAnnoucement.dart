import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sekolah_app/Model/DataUser.dart';
import 'package:sekolah_app/Model/UserRepo.dart';

class AnnouncementPage extends StatefulWidget {
  @override
  _AnnouncementPageState createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends State<AnnouncementPage> {
  UserRepo userRepo = UserRepo();
  String selectedCategory = 'Semua';
  String adminEmail = '';
  String adminIds = '';
  List<String> recipients = [];
  TextEditingController announcementController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch admin ID when the widget is created
    fetchAdminID();
  }

  Future<void> fetchAdminID() async {
    adminEmail = DataUser().email;
    UserRepo userRepo = UserRepo();
    String classroomList = await userRepo.getStudentIdbyEmail(adminEmail);
    setState(() {
      adminIds = classroomList;
    });
  }

  Future<void> sendAnnouncement() async {
    if (announcementController.text.isEmpty) {
      _showErrorSnackBar('Please write the announcement!');
      return;
    }

    if ((selectedCategory == 'Guru' || selectedCategory == 'Murid') && recipients.isEmpty) {
      _showErrorSnackBar('Please choose recipients individually!');
      return;
    }

    final CollectionReference announcements = FirebaseFirestore.instance.collection('Announcement');
    String adminId = adminIds;
    String currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

    Map<String, dynamic> data = {
      'adminId': adminId,
      'announcement': announcementController.text,
      'date': currentDate,
      'recipient': recipients.join(', '), // Join recipients into a single string
    };

    await announcements.add(data);

    announcementController.clear();
    recipients.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Announcement Sent!'),
      ),
    );
  }

  Future<void> _showRecipientsDialog(BuildContext context) async {
    UserRepo userRepo = UserRepo();
    List<String> allStudentName = await userRepo.getAllStudent();
    List<String> allTeacherName = await userRepo.getAllTeacher();

    List<String> allRecipients =
        selectedCategory == 'Guru' ? allTeacherName : allStudentName;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Recipients'),
          content: SingleChildScrollView(
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  children: [
                    for (String recipient in allRecipients)
                      CheckboxListTile(
                        title: Text(recipient),
                        value: recipients.contains(recipient),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null) {
                              if (value) {
                                recipients.add(recipient);
                              } else {
                                recipients.remove(recipient);
                              }
                            }
                          });
                        },
                      ),
                  ],
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (recipients.isEmpty) {
                  _showErrorSnackBar('Please choose at least one recipient!');
                } else {
                  Navigator.of(context).pop();
                }
              },
              child: Text('Done'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Announcement'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // DropdownButton<String>(
            //   value: selectedCategory,
            //   onChanged: (newValue) {
            //     setState(() {
            //       selectedCategory = newValue!;
            //       recipients.clear(); // Clear recipients when category changes
            //     });
            //   },
            //   items: [
            //     'Semua',
            //     'Guru',
            //     'Murid',
            //   ].map<DropdownMenuItem<String>>((String value) {
            //     return DropdownMenuItem<String>(
            //       value: value,
            //       child: Text(value),
            //     );
            //   }).toList(),
            // ),
            SizedBox(height: 20),
            if (selectedCategory == 'Guru' || selectedCategory == 'Murid') ...[
              ElevatedButton(
                onPressed: () {
                  _showRecipientsDialog(context);
                },
                child: Text('Choose Recipients'),
              ),
              SizedBox(height: 20),
            ],
            TextField(
              controller: announcementController,
              decoration: InputDecoration(
                labelText: 'Announcement',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                sendAnnouncement();
              },
              child: Text('Send Announcement to all'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AnnouncementPage(),
  ));
}
