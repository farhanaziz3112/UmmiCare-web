import 'package:flutter/material.dart';
import 'package:ummicare/screens/adminPages/adminLeftPane.dart';
import 'package:ummicare/screens/adminPages/settings/adminContactUs.dart';
import 'package:ummicare/screens/adminPages/settings/adminEditProfile.dart';
import 'package:ummicare/screens/adminPages/settings/adminPrivacyOfPolicy.dart';
import 'package:ummicare/screens/adminPages/settings/adminSystemSettings.dart';
import 'package:ummicare/screens/adminPages/settings/adminTermsOfUse.dart';
import 'package:ummicare/screens/adminPages/settings/adminVersion.dart';

class adminSettings extends StatefulWidget {
  const adminSettings({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<adminSettings> createState() => _adminSettingsState();
}

class _adminSettingsState extends State<adminSettings> {
  final pages = [
    adminEditProfile(),
    adminSystemSettings(),
    adminVersion(),
    adminPrivacyOfPolicy(),
    adminTermsOfUse(),
    adminContactUs()
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
              child: const adminLeftPane(selected: 4)),
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
