import 'package:flutter/material.dart';
import 'package:mytutor/model/user.dart';
import 'package:mytutor/view/coursescreen.dart';
import 'package:mytutor/view/favouritescreen.dart';
import 'package:mytutor/view/profilescreen.dart';
import 'package:mytutor/view/subscribescreen.dart';
import 'package:mytutor/view/tutorscreen.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;

  String maintitle = "Profile";

  @override
  void initState() {
    super.initState();
    tabchildren = [
      //CourseScreen(user: widget.user),
      //TutorScreen(user: widget.user),
      const SubscribeScreen(),
      const FavouriteScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.library_books_outlined,
              ),
              label: "Course"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.school,
              ),
              label: "Tutor"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.circle_notifications,
              ),
              label: "Subscribe"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.bookmark,
              ),
              label: "Favourite"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
              ),
              label: "Profile")
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {}
      if (_currentIndex == 1) {}
      if (_currentIndex == 2) {}
      if (_currentIndex == 3) {}
      if (_currentIndex == 4) {}
    });
  }
}
