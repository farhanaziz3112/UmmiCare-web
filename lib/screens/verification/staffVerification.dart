import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/screens/advisorPages/advisorHome.dart';
import 'package:ummicare/screens/medicalStaff_pages/medicalStaffHome.dart';
import 'package:ummicare/screens/teacherPages/teacherHome.dart';
import 'package:ummicare/screens/verification/userNotVerified.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';
import 'package:ummicare/services/staffDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';
import 'package:ummicare/shared/loading.dart';

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
        if (snapshot.hasData) {
          staffUserModel? staff = snapshot.data;
          if (staff!.isVerified == 'true') {
            if (staff.staffUserType == 'advisor') {
              return advisorHome(currentPage: 0);
            } else if (staff.staffUserType == 'teacher') {
              return StreamProvider<teacherModel?>.value(
                  value: teacherDatabase(teacherId: staff.staffId).teacherData,
                  initialData: null,
                  catchError: (_, __) {
                    return null;
                  },
                  child: const teacherHome(currentPage: 0));
            } else if (staff.staffUserType == 'medicalstaff') {
              return StreamProvider<medicalStaffModel?>.value(
                  value: medicalStaffDatabase().medicalStaffData(staff.staffId),
                  initialData: null,
                  catchError: (_, __) {
                    return null;
                  },
                  child: const medicalStaffHome(currentPage: 0));
            } else {
              return userNotVerified();
            }
          } else {
            return userNotVerified();
          }
        } else {
          return Loading();
        }
      },
    );
  }
}
