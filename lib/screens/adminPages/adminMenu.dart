import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/screens/nav/mainNavItem.dart';

class adminMenu extends StatelessWidget {
  const adminMenu({super.key, required this.selected});
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        mainNavItem('/admin/home', selected == 0, 'Home'),
        mainNavItem('/admin/advisor', selected == 1, 'Advisor'),
        mainNavItem('/admin/teacher', selected == 2, 'Teacher'),
        mainNavItem('/admin/medicalstaff', selected == 3, 'Medical Staff'),
        mainNavItem('/admin/settings', selected == 4, 'Settings'),
      ],
    );
  }
}
