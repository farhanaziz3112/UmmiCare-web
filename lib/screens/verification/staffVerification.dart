import 'package:flutter/material.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/screens/advisor_pages/home_advisor.dart';
import 'package:ummicare/screens/medicalStaff_pages/home_medicalStaff.dart';
import 'package:ummicare/screens/teacher_pages/home_teacher.dart';
import 'package:ummicare/screens/verification/userNotVerified.dart';
import 'package:ummicare/services/staffDatabase.dart';

class staffVerification extends StatefulWidget {
  const staffVerification({super.key, required this.staffId});
  final String staffId;

  @override
  State<staffVerification> createState() => _staffVerificationState();
}

class _staffVerificationState extends State<staffVerification> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<staffUserModel?>(
      stream: staffDatabase(staffId: widget.staffId).staffData,
      builder: (context, snapshot) {
        staffUserModel? staff = snapshot.data;
        if (staff!.isVerified == 'true') {
          if (staff.staffUserType == 'advisor') {
            return HomeAdvisor();
          } else if (staff.staffUserType == 'teacher'){
            return HomeTeacher();
          } else if (staff.staffUserType == 'medicalStaff'){
            return HomeMedicalStaff();
          } else {
            return userNotVerified();
          }
        } else {
          return userNotVerified();
        }
      },
    );
  }
}