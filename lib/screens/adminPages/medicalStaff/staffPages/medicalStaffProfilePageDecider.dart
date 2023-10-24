import 'package:flutter/material.dart';
import 'package:ummicare/screens/adminPages/adminLeftPane.dart';
import 'package:ummicare/screens/adminPages/medicalStaff/staffPages/pendingMedicalStaffProfile.dart';
import 'package:ummicare/screens/adminPages/medicalStaff/staffPages/rejectedMedicalStaffProfile.dart';
import 'package:ummicare/screens/adminPages/medicalStaff/staffPages/verifiedMedicalStaffProfile.dart';

class medicalStaffProfilePageDecider extends StatefulWidget {
  const medicalStaffProfilePageDecider({super.key, required this.currentPage, required this.staffId});
  final String staffId;
  final int currentPage;

  @override
  State<medicalStaffProfilePageDecider> createState() => _medicalStaffProfilePageDeciderState();
}

class _medicalStaffProfilePageDeciderState extends State<medicalStaffProfilePageDecider> {
  @override
  Widget build(BuildContext context) {

    final pages = [
      pendingMedicalStaffProfile(staffId: widget.staffId),
      rejectedMedicalStaffProfile(staffId: widget.staffId),
      verifiedMedicalStaffProfile(staffId: widget.staffId),
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