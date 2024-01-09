import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/teacherPages/teacherLeftPane.dart';
import 'package:ummicare/screens/teacherPages/teacherMainPane.dart';
import 'package:ummicare/screens/teacherPages/teacherMenu.dart';
import 'package:ummicare/services/teacherDatabase.dart';

class teacherHome extends StatefulWidget {
  const teacherHome({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<teacherHome> createState() => _teacherHomeState();
}

class _teacherHomeState extends State<teacherHome> {
  bool viewMenu = false;

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
                    teacherMenu(selected: page),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(child: teacherMainPane(currentPage: page))
                        ],
                      ),
                    )
                  ],
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(child: teacherMainPane(currentPage: page))
                        ],
                      ),
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
              child: Column(
                children: <Widget>[
                  Expanded(child: teacherMainPane(currentPage: page))
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
