import 'package:flutter/material.dart';
import 'package:ummicare/screens/nav/mainNavItem.dart';

class teacherMenu extends StatelessWidget {
  const teacherMenu({super.key, required this.selected});
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        mainNavItem('/teacher/home', selected == 0, 'Home'),
        mainNavItem('/teacher/class', selected == 1, 'Class'),
        mainNavItem('/teacher/student', selected == 2, 'Student'),
        mainNavItem('/teacher/settings', selected == 3, 'Settings'),
      ],
    );
  }
}
