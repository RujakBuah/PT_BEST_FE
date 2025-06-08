// lib/pages/main_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pt_best/pages/home.dart';
import 'package:pt_best/pages/jobList.dart';
import 'package:pt_best/pages/skillDev.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xff868686),
        chipTheme: ChipThemeData(iconTheme: IconThemeData(), showCheckmark: false)
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int myIndex = 0;

  final List<Widget> pages = [
    jobList(),
    skillDev(),
    History(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: myIndex,
        children: pages,
      ),
      bottomNavigationBar: navigationBar(),
    );
  }

  Widget navigationBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xff868686),
          borderRadius: BorderRadius.circular(30),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          currentIndex: myIndex,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.black,
          unselectedItemColor: const Color(0xffC6C9CF),
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: buildIcon('assets/icons/history.svg', 0),
              label: 'Search Jobs',
            ),
            BottomNavigationBarItem(
              icon: buildIcon('assets/icons/certification.svg', 1),
              label: 'Skills',
            ),
            BottomNavigationBarItem(
              icon: buildIcon('assets/icons/orders.svg', 2),
              label: 'Orders',
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIcon(String asset, int index) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: myIndex == index ? Colors.black : const Color(0xffC6C9CF),
      ),
      child: Center(
        child: SvgPicture.asset(
          asset,
          width: 24,
          height: 24,
          color: myIndex == index ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}
