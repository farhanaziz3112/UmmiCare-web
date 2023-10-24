import 'package:flutter/material.dart';
import 'package:ummicare/screens/adminPages/adminLeftPane.dart';
import 'package:ummicare/screens/adminPages/adminMainPane.dart';

class adminHome extends StatefulWidget {
  const adminHome({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<adminHome> createState() => _adminHomeState();
}

class _adminHomeState extends State<adminHome> {
  
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
              child: adminLeftPane(selected: page)),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: adminMainPane(currentPage: page)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}