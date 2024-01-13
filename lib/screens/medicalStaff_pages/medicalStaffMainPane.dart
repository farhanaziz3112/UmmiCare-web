import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/medicalStaff/medicalStaffDashboard.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientMain.dart';
import 'package:ummicare/screens/medicalStaff_pages/settings/medicalStaffSettingsMain.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';

class medicalStaffMainPane extends StatefulWidget {
  const medicalStaffMainPane({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<medicalStaffMainPane> createState() => _medicalStaffMainPaneState();
}

class _medicalStaffMainPaneState extends State<medicalStaffMainPane> {

  final pages = [
    const medicalStaffDashboard(),
    const patientMain(),
    const medicalStaffSettingsMain()
  ];


  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel>(context);
    return StreamProvider<medicalStaffModel?>.value(
      value: medicalStaffDatabase().medicalStaffData(user.userId),
      initialData: null,
      catchError: (_, __) {
        return null;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
        child: pages[widget.currentPage],
        alignment: Alignment.topLeft,
      ),
    );
  }
}