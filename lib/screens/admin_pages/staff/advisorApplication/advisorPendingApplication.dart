import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffapplicationmodel.dart';
import 'package:ummicare/screens/admin_pages/staff/applicationList/applicationList.dart';
import 'package:ummicare/services/staffApplicationDatabaseService.dart';

class advisorPendingApplication extends StatefulWidget {
  const advisorPendingApplication({super.key});

  @override
  State<advisorPendingApplication> createState() => _advisorPendingApplicationState();
}

class _advisorPendingApplicationState extends State<advisorPendingApplication> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<StaffApplicationModel>>.value(
      initialData: [],
      value: staffApplicationDatabaseService().allAdvisorPendingApplications,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Pending Application",
            style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 15,),
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