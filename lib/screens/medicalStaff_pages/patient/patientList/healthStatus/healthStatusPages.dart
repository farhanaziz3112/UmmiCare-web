import 'package:flutter/material.dart';
import 'package:ummicare/screens/medicalStaff_pages/medicalStaffLeftPane.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/healthStatus/chronicConditionMain.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/healthStatus/healthConditionMain.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/healthStatus/physicalConditionMain.dart';

class healthStatusPages extends StatefulWidget {
  const healthStatusPages({super.key, required this.healthStatusId, required this.currentPage});
  final String healthStatusId;
  final int currentPage;

  @override
  State<healthStatusPages> createState() => _healthStatusPagesState();
}

class _healthStatusPagesState extends State<healthStatusPages> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      healthConditionMain(healthStatusId: widget.healthStatusId),
      physicalConditionMain(healthStatusId: widget.healthStatusId),
      chronicConditionMain(healthStatusId: widget.healthStatusId)
    ];

    int page = widget.currentPage;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: 300,
              color: const Color(0xff71CBCA),
              child: const medicalStaffLeftPane(selected: 1)),
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