import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/advisorModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/advisorPages/advisorLeftPane.dart';
import 'package:ummicare/screens/advisorPages/advisorMenu.dart';
import 'package:ummicare/screens/advisorPages/parent/parentPages/parentChat.dart';
import 'package:ummicare/screens/advisorPages/parent/parentPages/parentDashboard.dart';
import 'package:ummicare/screens/advisorPages/parent/parentPages/parentStatistics.dart';
import 'package:ummicare/services/advisorDatabase.dart';


class parentPages extends StatefulWidget {
  const parentPages(
      {super.key, required this.parentId, required this.currentPage});
  final String parentId;
  final int currentPage;

  @override
  State<parentPages> createState() => _parentPagesState();
}

class _parentPagesState extends State<parentPages> {
  bool viewMenu = false;

  @override
  Widget build(BuildContext context) {
    final pages = [
      parentDashboard(parentId: widget.parentId),
      parentChat(parentId: widget.parentId),
      parentStatistics(parentId: widget.parentId),
    ];

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
                    advisorMenu(selected: 1),
                    Expanded(
                        child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.fromLTRB(70, 80, 70, 10),
                            child: pages[page]))
                  ],
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            alignment: Alignment.topLeft,
                            padding: const EdgeInsets.fromLTRB(70, 80, 70, 10),
                            child: pages[page]))
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

    // return Scaffold(
    //   body: Row(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       Container(
    //           width: 300,
    //           color: const Color(0xff71CBCA),
    //           child: const advisorLeftPane(selected: 1)),
    // Expanded(
    //     child: Container(
    //         alignment: Alignment.topLeft,
    //         padding: const EdgeInsets.fromLTRB(70, 80, 70, 10),
    //         child: pages[page])),
    //     ],
    //   ),
    // );
  }
}
