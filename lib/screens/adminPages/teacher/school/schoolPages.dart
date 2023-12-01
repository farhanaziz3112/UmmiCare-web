import 'package:flutter/material.dart';
import 'package:ummicare/screens/adminPages/adminLeftPane.dart';
import 'package:ummicare/screens/adminPages/teacher/school/addSchool.dart';
import 'package:ummicare/screens/adminPages/teacher/school/schoolMain.dart';
import 'package:ummicare/screens/adminPages/teacher/school/schoolProfile.dart';

class schoolPages extends StatefulWidget {
  const schoolPages({super.key, required this.currentPage, required this.schoolId});
  final int currentPage;
  final String schoolId;

  @override
  State<schoolPages> createState() => _schoolPagesState();
}

class _schoolPagesState extends State<schoolPages> {


  @override
  Widget build(BuildContext context) {

    final pages = [
    schoolMain(),
    addSchool(),
    schoolProfile(schoolId: widget.schoolId),
  ];

    int page = widget.currentPage;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 300,
              color: const Color(0xff71CBCA),
              child: const adminLeftPane(selected: 2)),
          Expanded(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
                  child: pages[page])),
        ],
      ),
    );
  }
}