import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/adminPages/adminLeftPane.dart';
import 'package:ummicare/screens/adminPages/adminMenu.dart';
import 'package:ummicare/screens/adminPages/teacher/staffPages/pendingTeacher.dart';
import 'package:ummicare/screens/adminPages/teacher/staffPages/rejectedTeacher.dart';
import 'package:ummicare/screens/adminPages/teacher/announcement/teacherAnnouncement.dart';
import 'package:ummicare/screens/adminPages/teacher/report/teacherReport.dart';
import 'package:ummicare/screens/adminPages/teacher/staffPages/verifiedTeacher.dart';
import 'package:ummicare/services/staffDatabase.dart';

class adminTeacher extends StatefulWidget {
  const adminTeacher({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<adminTeacher> createState() => _adminTeacherState();
}

class _adminTeacherState extends State<adminTeacher> {
  final pages = [
    pendingTeacher(),
    rejectedTeacher(),
    verifiedTeacher(),
    teacherReport(),
    teacherAnnouncement()
  ];

  bool viewMenu = false;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    int page = widget.currentPage;
    userModel? user = Provider.of<userModel?>(context);

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
              StreamBuilder<staffUserModel>(
                  stream: staffDatabase(staffId: user!.userId).staffData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      staffUserModel? staff = snapshot.data;
                      return ImageNetwork(
                          image: staff!.staffProfileImg,
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
                    adminMenu(selected: 2),
                    Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 80),
                              child: pages[page]),
                        )),
                  ],
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 70, vertical: 80),
                              child: pages[page]),
                        )),
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
                child: const adminLeftPane(selected: 2)),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 80),
                    child: pages[page])),
          ],
        ),
      );
    }
  }
}
