import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/medicalStaffLeftPane.dart';
import 'package:ummicare/screens/medicalStaff_pages/medicalStaffMenu.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/healthStatus/healthCondition/addNewHealthCondition.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/healthStatus/healthCondition/editHealthCondition.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/healthStatus/healthCondition/viewHealthCondition.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';

class healthConditionPages extends StatefulWidget {
  const healthConditionPages(
      {super.key, required this.patientId, required this.healthConditionId, required this.currentPage});
  final String patientId;
  final String healthConditionId;
  final int currentPage;

  @override
  State<healthConditionPages> createState() => _healthConditionPagesState();
}

class _healthConditionPagesState extends State<healthConditionPages> {
  bool viewMenu = false;

  @override
  Widget build(BuildContext context) {
    final pages = [
      addNewHealthCondition(patientId: widget.patientId),
      viewHealthCondition(patientId: widget.patientId, healthConditionId: widget.healthConditionId),
      editHealthCondition(patientId: widget.patientId, healthConditionId: widget.healthConditionId)
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
              StreamBuilder<medicalStaffModel>(
                  stream: medicalStaffDatabase()
                      .medicalStaffData(user!.userId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      medicalStaffModel? medicalStaff = snapshot.data;
                      return ImageNetwork(
                          image: medicalStaff!.medicalStaffProfileImg,
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
                    medicalStaffMenu(selected: 1),
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
                child: medicalStaffLeftPane(selected: 1)),
            Expanded(
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
                  child: pages[page]),
            )
          ],
        ),
      );
    }
  }
}
