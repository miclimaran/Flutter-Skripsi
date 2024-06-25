import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sekolah_app/Model/DataUser.dart';
import 'package:sekolah_app/Teacher%20Android/AbsenTeacher.dart';
import 'package:sekolah_app/Teacher%20Android/FeedbackTeacher.dart';
import 'package:sekolah_app/Teacher%20Android/NotificationTeacher.dart';
import 'package:sekolah_app/Teacher%20Android/ProfileTeacher.dart';
import 'package:sekolah_app/Teacher%20Android/ScheduleTeacher.dart';
import 'package:sekolah_app/Model/UserRepo.dart';

void main() {
  runApp(HomepageTeacherTop());
}

class HomepageTeacherTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Homepage Teacher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => HomepageTeacher());
          // case '/FeedbackTeacher':
          //   return MaterialPageRoute(builder: (_) => FeedbackTeacher());
          case '/NotificationTeacher':
            return MaterialPageRoute(builder: (_) => NotificationTeacher());
          case '/ScheduleTeacher':
            return MaterialPageRoute(builder: (_) => ScheduleTeacher());
          case '/ProfileTeacher':
            return MaterialPageRoute(builder: (_) => ProfileTeacher());
          case '/AbsenTeacher':
            return MaterialPageRoute(builder: (_) => AbsenTeacher());
          default:
            return null;
        }
      },
    );
  }
}

class HomepageTeacher extends StatefulWidget {
  @override
  _HomepageTeacherState createState() => _HomepageTeacherState();
}

class _HomepageTeacherState extends State<HomepageTeacher> {
  final String username = "Kevin";
  final String imageUrl = "images/Profile.png";
  String teacherId = '';

  @override
  void initState() {
    super.initState();
    fetchTeacherId(); // Fetch teacherId when widget initializes
  }

  Future<void> fetchTeacherId() async {
    String email = DataUser().email; // Get teacher's email
    UserRepo userRepo = UserRepo();
    String id = await userRepo.getTeacherIdbyEmail(email);
    setState(() {
      teacherId = id;
    });
  }

  final List<String> imageList = [
    'images/Baazar.png',
    'images/Baazar2.jpg',
    'images/Baazar3.jpeg',
    'images/Baazar4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Good Morning, $username',
                  style: TextStyle(fontSize: 18),
                ),
                CircleAvatar(
                  backgroundImage: AssetImage(imageUrl),
                  radius: 20,
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xFF3D73EB),
            ),
            child: Column(
              children: [
                Text(
                  DateFormat('EEEE, dd MMMM yyyy').format(DateTime.now()),
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFFFFFFFF),
                    fontFamily: 'Montserrat',
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AbsenTeacher()),
                    );
                    // Action when 'Absen' button is pressed
                  },
                  child: Text('Absen',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF000000),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                viewportFraction: 0.8,
              ),
              items: imageList.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xFF3D73EB),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ScheduleTeacher()),
                    );
                  },
                  icon: Image.asset(
                      'images/CalendarButtonWhite.png'), // Replace with your home icon asset
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FeedbackTeacher(teacherId: teacherId)),
                    );
                  },
                  icon: Image.asset(
                      'images/FeedbackWhite.png'), // Replace with your schedule icon asset
                ),
                IconButton(
                  onPressed: () {
                    // Action for notification button
                  },
                  icon: Image.asset(
                      'images/HomeButtonWhite.png'), // Replace with your notification icon asset
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationTeacher()),
                    );
                  },
                  icon: Image.asset(
                      'images/ScheduleButtonWhite.png'), // Replace with your profile icon asset
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileTeacher()),
                    );
                    // Action for profile button
                  },
                  icon: Image.asset(
                      'images/ProfileButtonWhite.png'), // Replace with your profile icon asset
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
