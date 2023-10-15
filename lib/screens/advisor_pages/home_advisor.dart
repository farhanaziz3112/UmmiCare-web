import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/screens/advisor_pages/advisor/advisorMain.dart';
import 'package:ummicare/screens/advisor_pages/mentee/menteeMain.dart';
import 'package:ummicare/screens/advisor_pages/settings/advisorSettingsMain.dart';

class HomeAdvisor extends StatefulWidget {
  const HomeAdvisor({super.key});

  @override
  State<HomeAdvisor> createState() => _HomeAdvisorState();
}

class _HomeAdvisorState extends State<HomeAdvisor> {
  int pageIndex = 0;

  final pages = [
    const advisorMain(),
    const menteeMain(),
    const advisorSettingsMain(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 3.0,
        actions: <Widget>[
          IconButton(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 15.0, 0.0),
            icon: const Icon(
              Icons.notifications,
              color: Colors.grey,
              size: 30.0,
            ),
            onPressed: () => {},
          ),
        ],
        title: const Text(
          "UmmiCare",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
              offset: const Offset(0, 3),
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
