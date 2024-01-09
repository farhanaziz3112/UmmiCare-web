import 'package:flutter/material.dart';
import 'package:ummicare/screens/nav/mainNavItem.dart';

class medicalStaffMenu extends StatelessWidget {
  const medicalStaffMenu({super.key, required this.selected});
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        mainNavItem('/medicalstaff/home', selected == 0, 'Home'),
        mainNavItem('/medicalstaff/patient', selected == 1, 'Patient'),
        mainNavItem('/medicalstaff/settings', selected == 2, 'Settings'),
      ],
    );
  }
}
