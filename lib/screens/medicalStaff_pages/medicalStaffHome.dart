import 'package:flutter/material.dart';
import 'package:ummicare/screens/medicalStaff_pages/medicalStaffLeftPane.dart';
import 'package:ummicare/screens/medicalStaff_pages/medicalStaffMainPane.dart';

class medicalStaffHome extends StatefulWidget {
  const medicalStaffHome({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<medicalStaffHome> createState() => _medicalStaffHomeState();
}

class _medicalStaffHomeState extends State<medicalStaffHome> {
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
              child: medicalStaffLeftPane(selected: page)),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: medicalStaffMainPane(currentPage: page)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}