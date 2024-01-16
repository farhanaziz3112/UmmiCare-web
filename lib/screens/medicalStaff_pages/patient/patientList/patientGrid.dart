import 'package:flutter/material.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/patientTile.dart';
import 'package:ummicare/shared/constant.dart';

class patientGrid extends StatefulWidget {
  const patientGrid({super.key, required this.patientList});
  final List<patientModel> patientList;

  @override
  State<patientGrid> createState() => _patientGridState();
}

class _patientGridState extends State<patientGrid> {
  @override
  Widget build(BuildContext context) {

    if (widget.patientList.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
            child: noData('Oops! There is no children at the moment...')),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.patientList.length,
        itemBuilder: ((context, index) {
          return patientTile(
            patientDetail: widget.patientList[index],
            patientColorIndex: (index % 3),
          );
        }),
      );
    }
  }
}
