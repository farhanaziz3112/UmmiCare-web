import 'package:flutter/material.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/healthStatus/physicalCondition/physicalConditionTile.dart';
class physicalConditionList extends StatefulWidget {
  const physicalConditionList({super.key, required this.physicalDetail});
  final List<PhysicalConditionModel>? physicalDetail;

  @override
  State<physicalConditionList> createState() => _physicalConditionListState();
}

class _physicalConditionListState extends State<physicalConditionList> {
  @override
  Widget build(BuildContext context) {
    if (widget.physicalDetail!.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: const Center(
          child: Text(
            'The list is empty.',
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.physicalDetail?.length,
        itemBuilder: ((context, index) {
          return physicalConditionTile(
            physicalCondition: widget.physicalDetail![index],
          );
        }),
      );
    }
  }
}