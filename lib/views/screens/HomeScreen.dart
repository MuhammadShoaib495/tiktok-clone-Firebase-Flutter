import 'package:flutter/material.dart';
import 'package:tiktok/constants.dart';

import '../widgets/Custom_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (idx) {
          setState(() {
            pageIdx = idx;
          });
        },
        backgroundColor: backgroundColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          currentIndex: pageIdx,
          items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30), label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30), label: 'Home'),
        BottomNavigationBarItem(
            icon: CustomIcon(), label: 'Home'),
        BottomNavigationBarItem(
            icon: Icon(Icons.message, size: 30), label: 'Message'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 30), label: 'Profile'),
      ]),
      body: pages[pageIdx],
    );
  }
}
