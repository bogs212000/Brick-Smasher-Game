import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/material.dart';

import '../function/functions.dart';
import 'home.screen.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  // String? userEmail = FirebaseAuth.instance.currentUser?.email;
  // late AndroidNotificationChannel channel;
  // late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  // User? currentUser = FirebaseAuth.instance.currentUser;
  // late Future<DocumentSnapshot> notification;
  List<Widget> tabItems = [
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  void initState() {
    super.initState();
    fetchUserData();
    // Navigator.of(context).popUntil((route) => route.isFirst);
    // if (userEmail != null) {
    //   notification =
    //       FirebaseFirestore.instance.collection('Users').doc(userEmail).get();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Scaffold(
      body: Center(
        child: tabItems[_selectedIndex],
      ),
      bottomNavigationBar: FlashyTabBar(
        animationCurve: Curves.linear,
        selectedIndex: _selectedIndex,
        iconSize: 30,
        showElevation: false,
        // use this to remove appBar's elevation
        onItemSelected: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: [
          FlashyTabBarItem(
            icon: Icon(Icons.gamepad_outlined),
            title: Text('Home'),
          ),
          FlashyTabBarItem(
            icon: Icon(Icons.leaderboard),
            title: Text('Leaderboard'),
          ),
        ],
      ),
    );
  }
}
