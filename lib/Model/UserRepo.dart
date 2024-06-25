

import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {

Future<List<String>> getStudentClasses() async {
    List<String> studentClasses = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
        String studentClass = user['class'] as String;
        studentClasses.add(studentClass);
      }
    } catch (e) {
      print('Error fetching student classes: $e');
    }

    Set<String> studentC = Set<String>.from(studentClasses);
    List<String> studentClassList = studentC.toList();

    return studentClassList;
  }

  
Future<List<String>> getAllStudent() async {
    List<String> studentName = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Student')
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
        String studentNames= user['name'] as String;
        studentName.add(studentNames);
      }
    } catch (e) {
      print('Error fetching student classes: $e');
    }

    Set<String> studentC = Set<String>.from(studentName);
    List<String> studentNameList = studentC.toList();

    return studentNameList;
  }

Future<List<String>> getAllTeacher() async {
    List<String> teacherName = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Teacher')
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
        String teacherNames= user['name'] as String;
        teacherName.add(teacherNames);
      }
    } catch (e) {
      print('Error fetching student classes: $e');
    }

    Set<String> studentC = Set<String>.from(teacherName);
    List<String> teacherNameList = studentC.toList();

    return teacherNameList;
  }

  Future<List<String>> getStudentForClass(String kelas) async {
    List<String> studentNames = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'Student')
          .where('class', isEqualTo: kelas)
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
        String studentName = user['name'] as String;
        studentNames.add(studentName);
      }
    } catch (e) {
      print('Error fetching student classes: $e');
    }

    return studentNames;
  }

    Future<List<String>> getAllStudentDetails(String name) async {
    List<String> studentDetails = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('name', isEqualTo: name)
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
        String studentName = user['name'] as String;
        String studentId = user['id'] as String;
        String studentClass = user['class'] as String;
        String role = user['role'] as String;
        String email = user['email'] as String;
        studentDetails.add(studentName);
        studentDetails.add(studentId);
        studentDetails.add(studentClass);
        studentDetails.add(role);
        studentDetails.add(email);
      }
    } catch (e) {
      print('Error fetching studentDetails: $e');
    }

    return studentDetails;
  }

 Future<List<String>> getAllAttendanceDetails(String email) async {
    List<String> studentDetails = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
        String studentName = user['date'] as String;
        String studentId = user['feedback'] as String;
        String studentClass = user['studentId'] as String;
        String role = user['teacherId'] as String;
        String studentNames = '';
        studentDetails.add(studentName);
        studentDetails.add(studentId);
        // studentDetails.add(studentClass);
        studentDetails.add(role);
        studentNames = await getStudentNamebyId(studentClass);  
        studentDetails.add(role);
      }
      



    } catch (e) {
      print('Error fetching studentDetails: $e');
    }

    return studentDetails;
  }

      Future<List<String>> getAllStudentDetailsbyEmail(String email) async {
    List<String> studentDetails = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
        String studentName = user['name'] as String;
        String studentId = user['id'] as String;
        String studentClass = user['class'] as String;
        String role = user['role'] as String;
        String email = user['email'] as String;
        studentDetails.add(studentName);
        studentDetails.add(studentId);
        studentDetails.add(studentClass);
        studentDetails.add(role);
        studentDetails.add(email);
      }
    } catch (e) {
      print('Error fetching studentDetails: $e');
    }

    return studentDetails;
  }

      Future<String> getAdminNamebyEmail(String email) async {
    String Admin = '';

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
        String studentName = user['name'] as String;
        Admin = studentName;
      }
    } catch (e) {
      print('Error fetching studentDetails: $e');
    }

    return Admin;
  }


    Future<void> storeAttendance(String date, String status, String studentId, String teacherId) async {
    try {
      await FirebaseFirestore.instance.collection('Attendance').add({
        'date': date,
        'status': status,
        'studentId': studentId,
        'teacherId': teacherId,
      });
    } catch (e) {
      print('Error storing attendance: $e');
    }
  }

Future<String> getName(String email) async {
    String name = '';

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
        name = user['name'] as String;
      }
          

    } catch (e) {
      print('Error fetching student name: $e');
    }

    return name;
  }


 Future<String> getStudentIdbyEmail(String email) async {
  String studentId = "";

  print(email);

  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
      studentId = user['id'] as String;
    }
  } catch (e) {
    print('Error fetching student classes: $e');
  }

  print(studentId);

  return studentId;
}



Future<String> getStudentIdbyName(String name) async {
  String studentId = "";

  print(name);

  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: name)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
      studentId = user['id'] as String;
    }
  } catch (e) {
    print('Error fetching student classes: $e');
  }

  print(studentId);

  return studentId;
}


Future<String> getStudentNamebyId(String name) async {
  String studentName = "";

  print(name);

  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: name)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
      studentName = user['id'] as String;
    }
  } catch (e) {
    print('Error fetching student classes: $e');
  }

  print(studentName);

  return studentName;
}

Future<String> getClassTeacherbyEmail(String email) async {
  String className = "";

  print(email);

  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
      className = user['class'] as String;
    }
  } catch (e) {
    print('Error fetching student classes: $e');
  }

  print(className);

  return className;
}


 Future<String> getTeacherIdbyName(String name) async {
  String teacherId = "";

  print(name);

  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: name)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
      teacherId = user['id'] as String;
    }
  } catch (e) {
    print('Error fetching student classes: $e');
  }

  print(teacherId);

  return teacherId;
}

 Future<String> getTeacherIdbyEmail(String email) async {
  String teacherId = "";

  print(email);

  try {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
      teacherId = user['id'] as String;
    }
  } catch (e) {
    print('Error fetching student classes: $e');
  }

  print(teacherId);

  return teacherId;
}

Future<String> getAttendance(String dates, String email) async {
  print(dates);
  print(email);

  String attendance = "";

  try {
    // Get studentId using getStudentId
    String studentId = await getStudentIdbyEmail(email);

    print(studentId);

    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
        .collection('Attendance')
        .where('date', isEqualTo: dates)
        .where('studentId', isEqualTo: studentId)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> attendances in snapshot.docs) {
      attendance = attendances['status'] as String;
    }
  } catch (e) {
    print('Error fetching student classes: $e');
  }
  print(attendance);

  return attendance;
}




Future<List<String>> getTeacher() async {
    List<String> teachers = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: "Teacher")
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> user in snapshot.docs) {
        String teacher = user['name'] as String;
        teachers.add(teacher);
      }
    } catch (e) {
      print('Error fetching student classes: $e');
    }

    Set<String> studentC = Set<String>.from(teachers);
    List<String> studentClassList = studentC.toList();

    return studentClassList;
  }


Future<List<String>> getAllClassroom() async {
    List<String> classrooms = [];

    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('classes')
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> classes in snapshot.docs) {
        String classroom = classes['name'] as String;
        classrooms.add(classroom);
      }
    } catch (e) {
      print('Error fetching student classes: $e');
    }

    Set<String> studentC = Set<String>.from(classrooms);
    List<String> classroomlist = studentC.toList();

    return classroomlist;
  }

   Future<void> addStudent(String name, String email, String id, String className, String role) async {
    try {
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'email': email,
        'id': id,
        'class': className,
        'role': role,
      });
      print('Student added successfully');
    } catch (e) {
      print('Error adding student: $e');
    }
  }
  
}




// StreamBuilder<QuerySnapshot> (
//   stream: FirebaseFirestore.instance.collection('users').snapshots(),builder:(context, snapshot){
//     List<Row> userWidgets = [];

//     String teacherClass = '';

//     if(snapshot.hasData){
//       final users = snapshot.data?.docs.reversed.toList();
//       for(final user in users!){
//         print(Text(user['name']));
//         print(Text(user['class']));
//         print(Text(user['email']));
//         print(Text(user['role']));

//         // if(Text(user['name']) == "Teacher"){
//         //   if(Text(user['email']) == "kevin@teacher.ac.id"){
//         //   teacherClass = Text(user['class']).toString();
//         //   print(teacherClass);
//         // }
//         // }

//         if(Text(user['name']) == "Student"){
//           teacherClass = Text(user['class']).toString();
//           students.add(teacherClass);
//         }

//         // final userWidget = Row(
//         //   children: [
//         //     Text(user['name']),
//         //     Text(user['class']),
//         //     Text(user['email']),
//         //     Text(user['role']),
//         //   ],
//         // );
//         // userWidgets.add(userWidget);
//       }
//     }

//     return ListView(
//       children: userWidgets,
//       );
//   }
// ),