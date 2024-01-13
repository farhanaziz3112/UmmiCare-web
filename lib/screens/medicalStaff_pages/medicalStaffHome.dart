import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/medicalStaffLeftPane.dart';
import 'package:ummicare/screens/medicalStaff_pages/medicalStaffMainPane.dart';
import 'package:ummicare/screens/medicalStaff_pages/medicalStaffMenu.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';

class medicalStaffHome extends StatefulWidget {
  const medicalStaffHome({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<medicalStaffHome> createState() => _medicalStaffHomeState();
}

class _medicalStaffHomeState extends State<medicalStaffHome> {
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
              StreamBuilder<medicalStaffModel>(
                  stream: medicalStaffDatabase().medicalStaffData(user!.userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      medicalStaffModel? medical = snapshot.data;
                      return ImageNetwork(
                          image: medical!.medicalStaffProfileImg,
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
                    medicalStaffMenu(selected: page),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Expanded(child: medicalStaffMainPane(currentPage: page))
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
                          Expanded(child: medicalStaffMainPane(currentPage: page))
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
                child: medicalStaffLeftPane(selected: page)),
            Expanded(
              child: Column(
                children: <Widget>[
                  Expanded(child: medicalStaffMainPane(currentPage: page))
                ],
              ),
            )
          ],
        ),
      );
    }
  }
}
