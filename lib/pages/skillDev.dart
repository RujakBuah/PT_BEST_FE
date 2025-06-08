import 'package:pt_best/models/requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class skillDev extends StatefulWidget {
  const skillDev({super.key});

  @override
  State<skillDev> createState() => _skillDevState();
}

class _skillDevState extends State<skillDev> {
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        children: [
          Text("Testing"),
        ],
      ),
    );
  }
}