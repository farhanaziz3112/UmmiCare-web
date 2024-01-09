import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/teacherPages/settings/registerNewSchool.dart';
import 'package:ummicare/screens/teacherPages/settings/schoolRegistration.dart';
import 'package:ummicare/screens/teacherPages/settings/teacherContactUs.dart';
import 'package:ummicare/screens/teacherPages/settings/teacherEditProfile.dart';
import 'package:ummicare/screens/teacherPages/settings/teacherPrivacyOfPolicy.dart';
import 'package:ummicare/screens/teacherPages/settings/teacherTermsOfUse.dart';
import 'package:ummicare/screens/teacherPages/settings/teacherVersion.dart';
import 'package:ummicare/screens/teacherPages/teacherLeftPane.dart';
import 'package:ummicare/screens/teacherPages/teacherMenu.dart';
import 'package:ummicare/services/teacherDatabase.dart';

class teacherSettingsPages extends StatefulWidget {
  const teacherSettingsPages({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<teacherSettingsPages> createState() => _teacherSettingsPagesState();
}

class _teacherSettingsPagesState extends State<teacherSettingsPages> {
  bool viewMenu = false;

  final pages = [
    const teacherEditProfile(),
    const schoolRegistration(),
    const teacherVersion(),
    const teacherPrivacyOfPolicy(),
    const teacherTermsOfUse(),
    const teacherContactUs(),
    const registerNewSchool()
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
              StreamBuilder<teacherModel>(
                  stream: teacherDatabase(teacherId: user!.userId).teacherData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      teacherModel? teacher = snapshot.data;
                      return ImageNetwork(
                          image: teacher!.teacherProfileImg,
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
                    teacherMenu(selected: 3),
                    Expanded(
                        child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 80),
                              child: pages[page]),
                        )
                  ],
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 80),
                              child: pages[page]),
                        )
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
                child: teacherLeftPane(selected: page)),
            Expanded(
                child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 70, vertical: 80),
                      child: pages[page]),
                )
          ],
        ),
      );
    }
  }
}
