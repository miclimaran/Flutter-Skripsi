import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sekolah_app/Admin%20Android/ClassroomAdmin.dart';
import 'package:sekolah_app/Admin%20Android/CreateAnnoucement.dart';
import 'package:sekolah_app/Admin%20Android/FeedbackAdmin.dart';
import 'package:sekolah_app/Admin%20Android/ProfileAdmin.dart';
import 'package:sekolah_app/StudentAndroid/LogInPage.dart';

void main() {
  runApp(HomepageAdminTop());
}

class HomepageAdminTop extends StatelessWidget {
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
            return MaterialPageRoute(builder: (_) => HomepageAdmin());
          // case '/FeedbackTeacher':
          //   return MaterialPageRoute(builder: (_) => FeedbackTeacher());
          // case '/NotificationTeacher':
          //   return MaterialPageRoute(builder: (_) => NotificationTeacher());
          // case '/ScheduleTeacher':
          //   return MaterialPageRoute(builder: (_) => ScheduleTeacher());
          // case '/ProfileTeacher':
          //   return MaterialPageRoute(builder: (_) => ProfileTeacher());
          // case '/AbsenTeacher':
          //   return MaterialPageRoute(builder: (_) => AbsenTeacher());
          default:
            return null;
        }
      },
    );
  }
}

class HomepageAdmin extends StatelessWidget {
  // final String emailName = ModalRoute.of(context)!.settings.arguments;

  final String username = 'Irwan';
  final String imageUrl = "images/Profile.png";

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
                  'Good Morning, Admin $username',
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
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 500.0,
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
                          builder: (context) => ClassroomAdminPage()),
                    );
                  },
                  icon: Image.asset(
                      'images/ClassroomButtonWhite.png'), // Replace with your home icon asset
                ),
                // IconButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => FeedbackAdminTop()),
                //     );
                //   },
                //   icon: Image.asset('images/FeedbackWhite.png'), // Replace with your schedule icon asset
                // ),
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
                      MaterialPageRoute(builder: (context) => AnnouncementPage()),
                    );
                  },
                  icon: Image.asset('images/AnnoucementButtonWhite.png'), // Replace with your profile icon asset
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileAdmin()),
                    );
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
