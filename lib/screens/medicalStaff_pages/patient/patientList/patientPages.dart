import 'package:flutter/material.dart';
import 'package:ummicare/screens/advisorPages/advisorLeftPane.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/patientProfile.dart';

class patientPages extends StatefulWidget {
  const patientPages({super.key, required this.patientId, required this.currentPage});
  final String patientId;
  final int currentPage;

  @override
  State<patientPages> createState() => _patientPagesState();
}

class _patientPagesState extends State<patientPages> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      patientProfile(patientId: widget.patientId)
    ];

    int page = widget.currentPage;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 300,
              color: const Color(0xff71CBCA),
              child: const advisorLeftPane(selected: 1)),
          Expanded(
              child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.fromLTRB(70, 80, 70, 10),
                  child: pages[page])),
        ],
      ),
    );
  }
}