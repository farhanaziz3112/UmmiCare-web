import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/screens/admin_pages/admin/adminMain.dart';
import 'package:ummicare/screens/admin_pages/staff/staffHome.dart';
import 'package:ummicare/screens/settings/settingsMain.dart';
import 'package:ummicare/services/auth.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  State<HomeAdmin> createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  int pageIndex = 0;

  final pages = [
    const adminMain(),
    const advisorMain_admin(),
    const settingsMain(),
  ];

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
            icon: Icon(
              Icons.notifications,
              color: Colors.grey,
              size: 30.0,
            ),
            onPressed: () => {},
          ),
        ],
        title: Text(
          "UmmiCare",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(child: pages[pageIndex]),
      bottomNavigationBar: buildBottomBar(context),
    );
  }

  Container buildBottomBar(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? const Icon(
                      Icons.home_filled,
                      color: Colors.black,
                      size: 37,
                    )
                  : const Icon(
                      Icons.home_outlined,
                      color: Colors.black,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                      Icons.group,
                      color: Colors.black,
                      size: 37,
                    )
                  : const Icon(
                      Icons.group_outlined,
                      color: Colors.black,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: 37,
                    )
                  : const Icon(
                      Icons.settings_outlined,
                      color: Colors.black,
                      size: 35,
                    ),
            ),
          ],
        ));
  }
}
