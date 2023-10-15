import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/screens/admin_pages/staff/applicationList/applicationList.dart';
import 'package:ummicare/services/adminDatabase.dart';

class medicalStaffPendingApplication extends StatefulWidget {
  const medicalStaffPendingApplication({super.key});

  @override
  State<medicalStaffPendingApplication> createState() => _medicalStaffPendingApplicationState();
}

class _medicalStaffPendingApplicationState extends State<medicalStaffPendingApplication> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<staffUserModel>>.value(
      initialData: [],
      value: adminDatabase().allStaffData('false', 'medicalStaff'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Medical Staff Pending Application",
            style: TextStyle(
              color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 3,
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 15,),
                  Container(
                    child: const applicationList(),
                  )
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}