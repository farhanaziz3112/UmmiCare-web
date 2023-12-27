import 'package:flutter/material.dart';
import 'package:ummicare/screens/medicalStaff_Pages/settings/medicalStaffContactUs.dart';
import 'package:ummicare/screens/medicalStaff_Pages/settings/medicalStaffEditProfile.dart';
import 'package:ummicare/screens/medicalStaff_Pages/settings/medicalStaffPrivacyOfPolicy.dart';
import 'package:ummicare/screens/medicalStaff_Pages/settings/medicalStaffSystemSettings.dart';
import 'package:ummicare/screens/medicalStaff_Pages/settings/medicalStaffVersion.dart';
import 'package:ummicare/screens/medicalStaff_Pages/medicalStaffLeftPane.dart';
import 'package:ummicare/screens/medicalStaff_pages/settings/addNewClinic.dart';
import 'package:ummicare/screens/medicalStaff_pages/settings/clinicRegistration.dart';
import 'package:ummicare/screens/medicalStaff_pages/settings/medicalStaffTermsOfUse.dart';
import 'package:ummicare/screens/medicalStaff_pages/settings/registerNewClinic.dart';

class medicalStaffSettingsPages extends StatefulWidget {
  const medicalStaffSettingsPages({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<medicalStaffSettingsPages> createState() => _medicalStaffSettingsPagesState();
}

class _medicalStaffSettingsPagesState extends State<medicalStaffSettingsPages> {

  final pages = [
    const medicalStaffEditProfile(),
    const clinicRegistration(),
    const medicalStaffSystemSettings(),
    const medicalStaffVersion(),
    const medicalStaffPrivacyOfPolicy(),
    const medicalStaffTermsOfUse(),
    const medicalStaffContactUs(),
    const registerNewClinic(),
    const addNewClinic(),
  ];

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
              child: const medicalStaffLeftPane(selected: 3)),
          Expanded(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
                  child: pages[page])),
        ],
      ),
    );
  }
}