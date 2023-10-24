import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/screens/adminPages/staffProfilePage/rejectedStaffProfilePage.dart';
import 'package:ummicare/services/staffDatabase.dart';

class rejectedMedicalStaffProfile extends StatefulWidget {
  const rejectedMedicalStaffProfile({super.key, required this.staffId});
  final String staffId;

  @override
  State<rejectedMedicalStaffProfile> createState() => _rejectedMedicalStaffProfileState();
}

class _rejectedMedicalStaffProfileState extends State<rejectedMedicalStaffProfile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<staffUserModel>(
      stream: staffDatabase(staffId: widget.staffId).staffData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          staffUserModel? staff = snapshot.data;
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            text: 'Medical Staff',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/admin/medicalstaff');
                              }),
                      ),
                      const SizedBox(width: 10),
                      const Text('>'),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                            text: 'Rejected Medical Staff',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/admin/medicalstaff/rejected');
                              }),
                      ),
                      const SizedBox(width: 10),
                      const Text('>'),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          text: staff!.staffFullName,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      staff.staffFullName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 45.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      staff.staffEmail,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  Container(
                    child: rejectedStaffProfilePage(staffId: staff.staffId),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      }, 
    );
  }
}