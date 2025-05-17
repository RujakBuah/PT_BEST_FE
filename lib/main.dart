import 'package:flutter/material.dart';
import 'package:pt_best/pages/home.dart';

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
        chipTheme: ChipThemeData(iconTheme: IconThemeData(), showCheckmark: false),
      ),
      home: History(),
    );
  }
}