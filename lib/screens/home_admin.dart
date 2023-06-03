import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/screens/admin_pages/admin/adminMain.dart';
import 'package:ummicare/screens/admin_pages/advisor/advisorMain_admin.dart';
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
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.grey,
            ),
            onPressed: () => {},
          ),
          TextButton(
            child: Text(
              'Logout',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
          )
        ],
        title: Text(
          "UmmiCare(Admin)",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffe1eef5),
      ),
      body: pages[pageIndex],
      bottomNavigationBar: buildBottomBar(context),
    );
  }

  Container buildBottomBar(BuildContext context) {
    return Container(
        height: 60,
        decoration: BoxDecoration(
          color: Color(0xff8290f0),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
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
                      color: Colors.white,
                      size: 37,
                    )
                  : const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
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
                      color: Colors.white,
                      size: 37,
                    )
                  : const Icon(
                      Icons.group_outlined,
                      color: Colors.white,
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
                      color: Colors.white,
                      size: 37,
                    )
                  : const Icon(
                      Icons.settings_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
          ],
        ));
  }
}
