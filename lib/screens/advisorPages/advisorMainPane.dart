import 'package:flutter/material.dart';
import 'package:ummicare/screens/advisorPages/home/advisorDashboard.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorSettingsMain.dart';
import 'package:ummicare/screens/advisorPages/parent/parentMain.dart';

class advisorMainPane extends StatefulWidget {
  const advisorMainPane({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<advisorMainPane> createState() => _advisorMainPaneState();
}

class _advisorMainPaneState extends State<advisorMainPane> {

  final pages = [
    const advisorDashboard(),
    const parentMain(),
    const advisorSettingsMain(),
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