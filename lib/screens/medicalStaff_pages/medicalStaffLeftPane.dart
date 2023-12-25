import 'package:flutter/material.dart';
import 'package:ummicare/screens/nav/mainNavItem.dart';
import 'package:ummicare/screens/medicalStaff_pages/medicalStaffHomeProfile.dart';

class medicalStaffLeftPane extends StatelessWidget {
  const medicalStaffLeftPane({super.key, required this.selected});
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: const Text(
                  'UmmiCare',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 50),
              mainNavItem('/medicalStaff_pages/home', selected == 0, 'Home'),
              mainNavItem('/medicalStaff_pages/patient', selected == 1, 'Patient'),
              mainNavItem('/medicalStaff_pages/settings', selected == 2, 'Settings'),
              Expanded(child: Container()),
              const medicalStaffHomeProfile(),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ],
    );
  }
}