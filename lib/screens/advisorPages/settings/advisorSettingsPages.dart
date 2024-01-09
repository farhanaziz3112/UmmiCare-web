import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/advisorModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/advisorPages/advisorLeftPane.dart';
import 'package:ummicare/screens/advisorPages/advisorMenu.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorContactUs.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorEditProfile.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorPrivacyOfPolicy.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorTermsOfUse.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorVersion.dart';
import 'package:ummicare/services/advisorDatabase.dart';

class advisorSettingsPages extends StatefulWidget {
  const advisorSettingsPages({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<advisorSettingsPages> createState() => _advisorSettingsPagesState();
}

class _advisorSettingsPagesState extends State<advisorSettingsPages> {
  bool viewMenu = false;

  final pages = [
    advisorEditProfile(),
    advisorVersion(),
    advisorPrivacyOfPolicy(),
    advisorTermsOfUse(),
    advisorContactUs()
  ];

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);
    var screenSize = MediaQuery.of(context).size;
    int page = widget.currentPage;
    if (screenSize.width < 1300) {
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              "UmmiCare",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: const Color(0xff71CBCA),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {
                  setState(() {
                    viewMenu = !viewMenu;
                  });
                },
              ),
              SizedBox(width: 10),
              StreamBuilder<advisorModel>(
                  stream: advisorDatabase(advisorId: user!.userId).advisorData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      advisorModel? advisor = snapshot.data;
                      return ImageNetwork(
                          image: advisor!.advisorProfileImg,
                          height: 40,
                          width: 40,
                          borderRadius: BorderRadius.circular(70));
                    } else {
                      return Container();
                    }
                  }),
              SizedBox(width: 10)
            ],
          ),
          body: viewMenu
              ? Column(
                  children: <Widget>[
                    advisorMenu(selected: 2),
                    Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.fromLTRB(70, 80, 70, 10),
                              child: pages[page]),
                        ))
                  ],
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                              alignment: Alignment.topLeft,
                              padding: const EdgeInsets.fromLTRB(70, 80, 70, 10),
                              child: pages[page]),
                        ))
                  ],
                ));
    } else {
      return Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 300,
                color: const Color(0xff71CBCA),
                child: advisorLeftPane(selected: 1)),
            Expanded(
                child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.fromLTRB(70, 80, 70, 10),
                    child: pages[page]))
          ],
        ),
      );
    }
  }
}
