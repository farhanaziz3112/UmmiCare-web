import 'package:flutter/material.dart';
import 'package:ummicare/screens/advisorPages/advisorLeftPane.dart';
import 'package:ummicare/screens/advisorPages/parent/parentPages/parentChat.dart';
import 'package:ummicare/screens/advisorPages/parent/parentPages/parentDashboard.dart';
import 'package:ummicare/screens/advisorPages/parent/parentPages/parentSettings.dart';
import 'package:ummicare/screens/advisorPages/parent/parentPages/parentStatistics.dart';

class parentPages extends StatefulWidget {
  const parentPages(
      {super.key, required this.parentId, required this.currentPage});
  final String parentId;
  final int currentPage;

  @override
  State<parentPages> createState() => _parentPagesState();
}

class _parentPagesState extends State<parentPages> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      parentDashboard(parentId: widget.parentId),
      parentChat(parentId: widget.parentId),
      parentStatistics(parentId: widget.parentId),
      parentSettings(parentId: widget.parentId)
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
