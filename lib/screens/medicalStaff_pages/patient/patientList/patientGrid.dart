import 'package:flutter/material.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/patientTile.dart';

class patientGrid extends StatefulWidget {
  const patientGrid({super.key, required this.patientList});
  final List<patientModel> patientList;

  @override
  State<patientGrid> createState() => _patientGridState();
}

class _patientGridState extends State<patientGrid> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (widget.patientList.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: const Center(
          child: Text(
            'The list is empty.',
          ),
        ),
      );
    } else {
      return GridView.builder(
        gridDelegate:
             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1500 <= screenSize.width && screenSize.width < 1700 ? 4 : 1300 <= screenSize.width && screenSize.width < 1500 ? 3 : screenSize.width < 1300 ? 3 : 4, childAspectRatio: (0.7)),
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
