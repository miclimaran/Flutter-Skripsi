import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date and time formatting
import 'package:carousel_slider/carousel_slider.dart'; // Import carousel_slider package
import 'package:sekolah_app/Model/DataUser.dart';
import 'package:sekolah_app/StudentAndroid/LogInPage.dart';
import 'package:sekolah_app/StudentAndroid/NotificationStudent.dart';
import 'package:sekolah_app/StudentAndroid/ProfileStudent.dart';
import 'package:sekolah_app/StudentAndroid/ScheduleStudent.dart';
import 'Schedule2.dart';
import 'package:sekolah_app/Model/UserRepo.dart';

void main() {
  runApp(Homepage2Top());
}

class Homepage2Top extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Homepage',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => Homepage2());
          case '/Schedule2':
            return MaterialPageRoute(builder: (_) => Schedule2());
          case '/ScheduleStudent':
            return MaterialPageRoute(builder: (_) => ScheduleStudent());
          case '/NotificationStudent':
            return MaterialPageRoute(builder: (_) => NotificationStudent());
          case '/ProfileStudent':
            return MaterialPageRoute(builder: (_) => ProfileStudent());
          // Add more cases for other routes if needed

          
          default:
            return null;
        }
      },
    );
  }
}

class Homepage2 extends StatelessWidget {
  final String username = "Michael";
  final String imageUrl = "images/Profile.png";

  final List<String> imageList = [
    'images/Baazar.png',
    'images/Baazar2.jpg',
    'images/Baazar3.jpeg',
    'images/Baazar4.png',
  ];

  @override
  Widget build(BuildContext context) {

DataUser dataUser = DataUser();

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
                  'Good Morning, ' + dataUser.name,
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
              color: Color(0xFF6491EE),
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
                      MaterialPageRoute(builder: (context) => Schedule2()),
                    );
                    // Action when 'Check Schedule' button is pressed
                  },
                  child: Text('Lihat Jadwal', style: TextStyle(fontSize: 16,
                    color: Color(0xFF000000),)),
                  
                ),
              ],
            ),
          ),
          Expanded(
            child: CarouselSlider(
              options: CarouselOptions(
                height: 400,
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
              color: Color(0xFF6491EE),
             ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    print('Home Button Pressed');
                  },
                  icon: Image.asset('images/HomeButtonWhite.png'), // Replace with your home icon asset
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScheduleStudent()),
                    );
                  },
                  icon: Image.asset('images/CalendarButtonWhite.png'), // Replace with your schedule icon asset
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationStudent()),
                    );
                  },
                  icon: Image.asset('images/ScheduleButtonWhite.png'), // Replace with your notification icon asset
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfileStudent()),
                    );
                  },
                  icon: Image.asset('images/ProfileButtonWhite.png'), // Replace with your profile icon asset
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
