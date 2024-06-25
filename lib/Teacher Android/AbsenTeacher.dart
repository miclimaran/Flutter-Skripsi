import 'package:flutter/material.dart';
import 'package:sekolah_app/Model/DataUser.dart';
import 'package:sekolah_app/Teacher%20Android/HomepageTeacher.dart';
import 'package:sekolah_app/Model/UserRepo.dart';

class AbsenTeacher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Attendance'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomepageTeacher()),
              );
            },
          ),
        ),
        body: AttendanceContent(),
      ),
    );
  }
}

class AttendanceContent extends StatefulWidget {
  @override
  _AttendanceContentState createState() => _AttendanceContentState();
}

class _AttendanceContentState extends State<AttendanceContent> {
  String? selectedClass;
  List<String> classesList = [];
  List<String> students = [];
  Map<String, bool> attendance = {};
  String teacherEmail = DataUser().email;
  UserRepo userRepo = UserRepo();
  String classname = '';

  String getFormattedDate() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.day}-${now.month}-${now.year}";
    return formattedDate;
  }

  String getFormattedDay() {
    DateTime now = DateTime.now();
    List<String> days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    int dayIndex = now.weekday - 1;
    return days[dayIndex];
  }

  @override
  void initState() {
    super.initState();
    fetchStudentClasses();
  }

  Future<void> fetchStudentClasses() async {
    UserRepo userRepo = UserRepo();
    List<String> studentClasses = await userRepo.getStudentClasses();
    setState(() {
      classesList = studentClasses;
    });
  }

  Future<void> fetchStudentsForClass(String className) async {
    UserRepo userRepo = UserRepo();
    List<String> studentsList = await userRepo.getStudentForClass(className);
    setState(() {
      students = studentsList;
    });
  }

  Future<void> fetchClassforTeacher(String email) async {
    UserRepo userRepo = UserRepo();
    String classNames = await userRepo.getClassTeacherbyEmail(email);
    setState(() {
      classname = classNames;
    });
  }

  Future<void> storeAttendanceData() async {
    String formattedDate = getFormattedDate();
    String teacherId = await userRepo.getTeacherIdbyEmail(teacherEmail);
    try {
      for (var entry in attendance.entries) {
        String studentName = entry.key;
        String studentId = await userRepo.getStudentIdbyName(studentName);
        bool status = entry.value;
        String attendanceStatus = status ? 'Masuk' : 'Absen';

        await UserRepo().storeAttendance(formattedDate, attendanceStatus, studentId, teacherId);
      }

      // Show dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Attendance Telah Berhasil !',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  // Navigate back to HomepageTeacher
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomepageTeacher()),
                  );
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error storing attendance data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    fetchClassforTeacher(DataUser().email);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Day : ${getFormattedDay()}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Date : ${getFormattedDate()}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'Kelas Anda: ${classname}',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
          SizedBox(height: 20),
          DropdownButton<String>(
            hint: Text('Select Class'),
            value: selectedClass,
            onChanged: (newValue) {
              setState(() {
                selectedClass = newValue;
                fetchStudentsForClass(newValue!);
              });
            },
            items: classesList.map((className) {
              return DropdownMenuItem<String>(
                value: className,
                child: Text(className),
                key: Key(className),
              );
            }).toList(),
          ),
          SizedBox(height: 20),
          if (selectedClass != null) ...[
            Text(
              'Attendance for $selectedClass',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (BuildContext context, int index) {
                  final student = students[index];
                  return ListTile(
                    title: Text(student),
                    trailing: Checkbox(
                      value: attendance.containsKey(student) ? attendance[student] : false,
                      onChanged: (bool? value) {
                        setState(() {
                          attendance[student] = value!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), // Set the button color
              ),
              onPressed: () {
                storeAttendanceData();
              },
              child: Text('Submit Attendance', style: TextStyle(color: Colors.white)),
            ),
          ],
        ],
      ),
    );
  }
}
