import 'package:flutter/material.dart';
import 'package:ummicare/screens/adminPages/adminLeftPane.dart';
import 'package:ummicare/screens/adminPages/advisor/announcement/advisorAnnouncement.dart';
import 'package:ummicare/screens/adminPages/advisor/report/advisorReport.dart';
import 'package:ummicare/screens/adminPages/advisor/staffPages/pendingAdvisor.dart';
import 'package:ummicare/screens/adminPages/advisor/staffPages/rejectedAdvisor.dart';
import 'package:ummicare/screens/adminPages/advisor/staffPages/verifiedAdvisor.dart';

class adminAdvisor extends StatefulWidget {
  const adminAdvisor({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<adminAdvisor> createState() => _adminAdvisorState();
}

class _adminAdvisorState extends State<adminAdvisor> {

  final pages = [
    pendingAdvisor(),
    rejectedAdvisor(),
    verifiedAdvisor(),
    advisorReport(),
    advisorAnnouncement(),
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
              child: const adminLeftPane(selected: 1)),
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