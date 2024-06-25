// import 'package:flutter/material.dart';
// import 'package:sekolah_app/Model/DataUser.dart';
// import 'package:sekolah_app/Model/UserRepo.dart';

// class ClassroomDetailPage extends StatefulWidget {
//   final String className;

//   ClassroomDetailPage({required this.className});

//   @override
//   _ClassroomDetailPageState createState() => _ClassroomDetailPageState();
// }

// class _ClassroomDetailPageState extends State<ClassroomDetailPage> {
//   List<String> studentsInClass = [];
//   List<String> displayedStudents = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchStudentClasses();
//   }

//   Future<void> fetchStudentClasses() async {
//     UserRepo userRepo = UserRepo();
//     List<String> studentClasses =
//         await userRepo.getStudentForClass(widget.className);
//     setState(() {
//       studentsInClass = studentClasses;
//       displayedStudents = studentsInClass;
//     });
//   }

//   void filterStudents(String query) {
//     setState(() {
//       displayedStudents = studentsInClass
//           .where((student) =>
//               student.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }

//   void viewStudentDetails(String studentName) {
//     // Navigate to the Student Details page
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => StudentDetailsPage(studentName: studentName),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     String classroomName = DataUser().adminClassName;
    
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Classroom Detail ($classroomName)'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             TextField(
//               onChanged: (value) => filterStudents(value),
//               decoration: InputDecoration(
//                 labelText: 'Search Student',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             SizedBox(height: 20.0),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: displayedStudents.length,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () =>
//                         viewStudentDetails(displayedStudents[index]),
//                     child: Card(
//                       color: Color(0xFF3D73EB),
//                       child: ListTile(
//                         title: Text(
//                           displayedStudents[index],
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



// class StudentDetailsPage extends StatefulWidget {
//   final String studentName;

//   const StudentDetailsPage({required this.studentName});

//   @override
//   _StudentDetailsPageState createState() => _StudentDetailsPageState();
// }

// class _StudentDetailsPageState extends State<StudentDetailsPage> {
//   List<String> detailStudent = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchStudentDetails();
//   }

//   Future<void> fetchStudentDetails() async {
//     // Simulating the data fetching process
//     // Replace this with the actual logic to fetch student details
//     UserRepo userRepo = UserRepo();
//     List<String> studentDetails = await userRepo.getAllStudentDetails(widget.studentName);

//     // Simulated data
//     // List<String> studentDetails = [
//     //   'Name: Michael Limaran',
//     //   'Email: Michael.limaran@student.ac.id',
//     //   'Role: Student',
//     //   'ID: STD001',
//     //   'Class: XA1',
//     // ];

//     setState(() {
//       detailStudent = studentDetails;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Student Details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             for (var detail in detailStudent)
//               Card(
//                 elevation: 4.0,
//                 margin: EdgeInsets.only(bottom: 12.0),
//                 child: ListTile(
//                   leading: Icon(
//                     Icons.person,
//                     color: Colors.blue,
//                   ),
//                   title: Text(
//                     detail,
//                     style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:sekolah_app/Admin%20Android/CreateNewStudent.dart';
import 'package:sekolah_app/Model/DataUser.dart';
import 'package:sekolah_app/Model/UserRepo.dart'; // Import the new student page

class ClassroomDetailPage extends StatefulWidget {
  final String className;

  ClassroomDetailPage({required this.className});

  @override
  _ClassroomDetailPageState createState() => _ClassroomDetailPageState();
}

class _ClassroomDetailPageState extends State<ClassroomDetailPage> {
  List<String> studentsInClass = [];
  List<String> displayedStudents = [];

  @override
  void initState() {
    super.initState();
    fetchStudentClasses();
  }

  Future<void> fetchStudentClasses() async {
    UserRepo userRepo = UserRepo();
    List<String> studentClasses =
        await userRepo.getStudentForClass(widget.className);
    setState(() {
      studentsInClass = studentClasses;
      displayedStudents = studentsInClass;
    });
  }

  void filterStudents(String query) {
    setState(() {
      displayedStudents = studentsInClass
          .where((student) =>
              student.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void viewStudentDetails(String studentName) {
    // Navigate to the Student Details page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentDetailsPage(studentName: studentName),
      ),
    );
  }

  Future<void> _navigateToCreateNewStudent() async {
    // Navigate to the Create New Student page
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateNewStudentPage(),
      ),
    );

    // If a student was created, refresh the list
    if (result == true) {
      fetchStudentClasses();
    }
  }

  @override
  Widget build(BuildContext context) {
    String classroomName = DataUser().adminClassName;

    return Scaffold(
      appBar: AppBar(
        title: Text('Classroom Detail ($classroomName)'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              onChanged: (value) => filterStudents(value),
              decoration: InputDecoration(
                labelText: 'Search Student',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: displayedStudents.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () =>
                        viewStudentDetails(displayedStudents[index]),
                    child: Card(
                      color: Color(0xFF3D73EB),
                      child: ListTile(
                        title: Text(
                          displayedStudents[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _navigateToCreateNewStudent,
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF3D73EB), // Blue color
                padding: EdgeInsets.symmetric(vertical: 15.0),
              ),
              child: Text(
                'Create New Student',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class StudentDetailsPage extends StatefulWidget {
  final String studentName;

  const StudentDetailsPage({required this.studentName});

  @override
  _StudentDetailsPageState createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  List<String> detailStudent = [];

  @override
  void initState() {
    super.initState();
    fetchStudentDetails();
  }

  Future<void> fetchStudentDetails() async {
    // Simulating the data fetching process
    // Replace this with the actual logic to fetch student details
    UserRepo userRepo = UserRepo();
    List<String> studentDetails = await userRepo.getAllStudentDetails(widget.studentName);

    // Simulated data
    // List<String> studentDetails = [
    //   'Name: Michael Limaran',
    //   'Email: Michael.limaran@student.ac.id',
    //   'Role: Student',
    //   'ID: STD001',
    //   'Class: XA1',
    // ];

    setState(() {
      detailStudent = studentDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var detail in detailStudent)
              Card(
                elevation: 4.0,
                margin: EdgeInsets.only(bottom: 12.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  title: Text(
                    detail,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}