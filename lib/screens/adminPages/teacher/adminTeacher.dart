import 'package:flutter/material.dart';
import 'package:ummicare/screens/adminPages/adminLeftPane.dart';
import 'package:ummicare/screens/adminPages/teacher/staffPages/pendingTeacher.dart';
import 'package:ummicare/screens/adminPages/teacher/staffPages/rejectedTeacher.dart';
import 'package:ummicare/screens/adminPages/teacher/announcement/teacherAnnouncement.dart';
import 'package:ummicare/screens/adminPages/teacher/report/teacherReport.dart';
import 'package:ummicare/screens/adminPages/teacher/staffPages/verifiedTeacher.dart';

class adminTeacher extends StatefulWidget {
  const adminTeacher({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<adminTeacher> createState() => _adminTeacherState();
}

class _adminTeacherState extends State<adminTeacher> {

  final pages = [
    pendingTeacher(),
    rejectedTeacher(),
    verifiedTeacher(),
    teacherReport(),
    teacherAnnouncement()
  ];

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