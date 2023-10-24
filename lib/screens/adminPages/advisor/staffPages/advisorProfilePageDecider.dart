import 'package:flutter/material.dart';
import 'package:ummicare/screens/adminPages/adminLeftPane.dart';
import 'package:ummicare/screens/adminPages/advisor/staffPages/pendingAdvisorProfile.dart';
import 'package:ummicare/screens/adminPages/advisor/staffPages/rejectedAdvisorProfile.dart';
import 'package:ummicare/screens/adminPages/advisor/staffPages/verifiedAdvisorProfile.dart';

class advisorProfilePageDecider extends StatefulWidget {
  const advisorProfilePageDecider(
      {super.key, required this.currentPage, required this.staffId});
  final String staffId;
  final int currentPage;

  @override
  State<advisorProfilePageDecider> createState() =>
      _advisorProfilePageDeciderState();
}

class _advisorProfilePageDeciderState extends State<advisorProfilePageDecider> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      pendingAdvisorProfile(staffId: widget.staffId),
      rejectedAdvisorProfile(staffId: widget.staffId),
      verifiedAdvisorProfile(staffId: widget.staffId)
    ];

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
                  alignment: Alignment.topLeft,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
                  child: pages[page])),
        ],
      ),
    );
  }
}
