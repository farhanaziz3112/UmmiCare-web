import 'package:flutter/material.dart';
import 'package:ummicare/screens/advisorPages/advisorLeftPane.dart';
import 'package:ummicare/screens/advisorPages/advisorMainPane.dart';

class advisorHome extends StatefulWidget {
  const advisorHome({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<advisorHome> createState() => _advisorHomeState();
}

class _advisorHomeState extends State<advisorHome> {
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
              child: advisorLeftPane(selected: page)),
          Expanded(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: advisorMainPane(currentPage: page)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}