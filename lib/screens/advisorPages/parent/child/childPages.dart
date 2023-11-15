import 'package:flutter/material.dart';
import 'package:ummicare/screens/advisorPages/advisorLeftPane.dart';
import 'package:ummicare/screens/advisorPages/parent/child/childProfile.dart';

class childPages extends StatefulWidget {
  const childPages({super.key, required this.childId, required this.currentPage});
  final String childId;
  final int currentPage;

  @override
  State<childPages> createState() => _childPagesState();
}

class _childPagesState extends State<childPages> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      childProfile(childId: widget.childId)
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