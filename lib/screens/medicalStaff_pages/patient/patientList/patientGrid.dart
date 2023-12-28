import 'package:flutter/material.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/patientTile.dart';
import 'package:ummicare/services/patientDatabase.dart';

class patientGrid extends StatefulWidget {
  const patientGrid({super.key, required this.clinicId});
  final String clinicId;

  @override
  State<patientGrid> createState() => _patientGridState();
}

class _patientGridState extends State<patientGrid> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<patientModel>>(
      stream: PatientDatabaseService().allPatientData(widget.clinicId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<patientModel>? patient = snapshot.data;
          return GridView.builder(
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, childAspectRatio: (0.7)),
            itemCount: patient!.length,
            itemBuilder: ((context, index) {
              return patientTile(
                patientDetail: patient[index],
                patientColorIndex: (index % 3),
              );
            }),
          );
        } else {
          return Container(
            padding: const EdgeInsets.only(top: 50),
            child: const Center(
              child: Text(
                'The list is empty.',
              ),
            ),
          );
        }
      }),
    );
  }
}
