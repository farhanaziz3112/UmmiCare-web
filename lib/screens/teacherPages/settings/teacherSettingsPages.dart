import 'package:flutter/material.dart';
import 'package:ummicare/screens/teacherPages/settings/registerNewSchool.dart';
import 'package:ummicare/screens/teacherPages/settings/schoolRegistration.dart';
import 'package:ummicare/screens/teacherPages/settings/teacherContactUs.dart';
import 'package:ummicare/screens/teacherPages/settings/teacherEditProfile.dart';
import 'package:ummicare/screens/teacherPages/settings/teacherPrivacyOfPolicy.dart';
import 'package:ummicare/screens/teacherPages/settings/teacherSystemSettings.dart';
import 'package:ummicare/screens/teacherPages/settings/teacherTermsOfUse.dart';
import 'package:ummicare/screens/teacherPages/settings/teacherVersion.dart';
import 'package:ummicare/screens/teacherPages/teacherLeftPane.dart';

class teacherSettingsPages extends StatefulWidget {
  const teacherSettingsPages({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<teacherSettingsPages> createState() => _teacherSettingsPagesState();
}

class _teacherSettingsPagesState extends State<teacherSettingsPages> {

  final pages = [
    const teacherEditProfile(),
    const schoolRegistration(),
    const teacherSystemSettings(),
    const teacherVersion(),
    const teacherPrivacyOfPolicy(),
    const teacherTermsOfUse(),
    const teacherContactUs(),
    const registerNewSchool()
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
              child: const teacherLeftPane(selected: 3)),
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