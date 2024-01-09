import 'package:flutter/material.dart';
import 'package:ummicare/screens/nav/mainNavItem.dart';

class advisorMenu extends StatelessWidget {
  const advisorMenu({super.key, required this.selected});
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        mainNavItem('/advisor/home', selected == 0, 'Home'),
        mainNavItem('/advisor/parent', selected == 1, 'Parent'),
        mainNavItem('/advisor/settings', selected == 2, 'Settings'),
      ],
    );
  }
}
