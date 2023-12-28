import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientGrid.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';

class patientMain extends StatefulWidget {
  const patientMain({super.key});

  @override
  State<patientMain> createState() => _patientMainState();
}

class _patientMainState extends State<patientMain> {
  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder<medicalStaffModel>(
      stream: medicalStaffDatabase(medicalStaffId: user!.userId).medicalStaffData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          medicalStaffModel? med = snapshot.data;
          return SingleChildScrollView(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Patient',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 50.0,
                          fontFamily: 'Comfortaa',
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
                  const SizedBox(height: 30),
                  Container(
                      constraints:
                          const BoxConstraints(maxHeight: 1000, minHeight: 500),
                      child: Expanded(
                          child: patientGrid(
                        clinicId: med!.clinicId,
                      )))
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