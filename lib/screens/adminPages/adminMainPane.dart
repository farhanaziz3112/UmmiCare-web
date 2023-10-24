import 'package:flutter/material.dart';
import 'package:ummicare/screens/adminPages/advisor/advisorMain.dart';
import 'package:ummicare/screens/adminPages/home/adminMain.dart';
import 'package:ummicare/screens/adminPages/medicalStaff/medicalStaffMain.dart';
import 'package:ummicare/screens/adminPages/settings/adminSettingsMain.dart';
import 'package:ummicare/screens/adminPages/teacher/teacherMain.dart';

class adminMainPane extends StatefulWidget {
  const adminMainPane({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<adminMainPane> createState() => _adminMainPaneState();
}

class _adminMainPaneState extends State<adminMainPane> {

  final pages = [
    const adminMain(),
    const advisorMain(),
    const teacherMain(),
    const medicalStaffMain(),
    const adminSettingsMain()
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
      child: pages[widget.currentPage],
      alignment: Alignment.topLeft,
    );
  }
}