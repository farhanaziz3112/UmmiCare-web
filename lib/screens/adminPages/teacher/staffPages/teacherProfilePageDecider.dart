import 'package:flutter/material.dart';
import 'package:ummicare/screens/adminPages/adminLeftPane.dart';
import 'package:ummicare/screens/adminPages/teacher/staffPages/pendingTeacherProfile.dart';
import 'package:ummicare/screens/adminPages/teacher/staffPages/rejectedTeacherProfile.dart';
import 'package:ummicare/screens/adminPages/teacher/staffPages/verifiedTeacherProfile.dart';

class teacherProfilePageDecider extends StatefulWidget {
  const teacherProfilePageDecider({super.key, required this.currentPage, required this.staffId});
  final String staffId;
  final int currentPage;

  @override
  State<teacherProfilePageDecider> createState() => _teacherProfilePageDeciderState();
}

class _teacherProfilePageDeciderState extends State<teacherProfilePageDecider> {
  @override
  Widget build(BuildContext context) {

    final pages = [
      pendingTeacherProfile(staffId: widget.staffId),
      rejectedTeacherProfile(staffId: widget.staffId),
      verifiedTeacherProfile(staffId: widget.staffId),
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
                  alignment: Alignment.topLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
                  child: pages[page])),
        ],
      ),
    );
  }
}