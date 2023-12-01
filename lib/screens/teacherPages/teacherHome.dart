import 'package:flutter/material.dart';
import 'package:ummicare/screens/teacherPages/teacherLeftPane.dart';
import 'package:ummicare/screens/teacherPages/teacherMainPane.dart';

class teacherHome extends StatefulWidget {
  const teacherHome({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<teacherHome> createState() => _teacherHomeState();
}

class _teacherHomeState extends State<teacherHome> {
  @override
  Widget build(BuildContext context) {

    int page = widget.currentPage;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 300,
              color: const Color(0xff71CBCA),
              child: teacherLeftPane(selected: page)),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: teacherMainPane(currentPage: page)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}