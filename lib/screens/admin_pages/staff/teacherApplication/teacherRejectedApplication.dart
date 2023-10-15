import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/screens/admin_pages/staff/applicationList/applicationList.dart';
import 'package:ummicare/services/adminDatabase.dart';

class teacherRejectedApplication extends StatefulWidget {
  const teacherRejectedApplication({super.key});

  @override
  State<teacherRejectedApplication> createState() => _teacherRejectedApplicationState();
}

class _teacherRejectedApplicationState extends State<teacherRejectedApplication> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<staffUserModel>>.value(
      initialData: [],
      value: adminDatabase().allStaffData('rejected', 'teacher'),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Teacher Rejected Application",
            style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold,
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
                    child: applicationList(),
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