import 'package:flutter/material.dart';
import 'package:ummicare/screens/advisorPages/advisorLeftPane.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorContactUs.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorEditProfile.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorPrivacyOfPolicy.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorSystemSettings.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorTermsOfUse.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorVersion.dart';

class advisorSettingsPages extends StatefulWidget {
  const advisorSettingsPages({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<advisorSettingsPages> createState() => _advisorSettingsPagesState();
}

class _advisorSettingsPagesState extends State<advisorSettingsPages> {

  final pages = [
    advisorEditProfile(),
    advisorSystemSettings(),
    advisorVersion(),
    advisorPrivacyOfPolicy(),
    advisorTermsOfUse(),
    advisorContactUs()
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
              child: const advisorLeftPane(selected: 2)),
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