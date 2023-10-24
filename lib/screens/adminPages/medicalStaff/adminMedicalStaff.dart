import 'package:flutter/material.dart';
import 'package:ummicare/screens/adminPages/adminLeftPane.dart';
import 'package:ummicare/screens/adminPages/medicalStaff/announcement/medicalStaffAnnouncement.dart';
import 'package:ummicare/screens/adminPages/medicalStaff/report/medicalStaffReport.dart';
import 'package:ummicare/screens/adminPages/medicalStaff/staffPages/pendingMedicalStaff.dart';
import 'package:ummicare/screens/adminPages/medicalStaff/staffPages/rejectedMedicalStaff.dart';
import 'package:ummicare/screens/adminPages/medicalStaff/staffPages/verifiedMedicalStaff.dart';

class adminMedicalStaff extends StatefulWidget {
  const adminMedicalStaff({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<adminMedicalStaff> createState() => _adminMedicalStaffState();
}

class _adminMedicalStaffState extends State<adminMedicalStaff> {

  final pages = [
    pendingMedicalStaff(),
    rejectedMedicalStaff(),
    verifiedMedicalStaff(),
    medicalStaffReport(),
    medicalStaffAnnouncement()
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
              child: const adminLeftPane(selected: 3)),
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