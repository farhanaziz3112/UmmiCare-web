import 'package:flutter/material.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/healthStatus/chronicCondition/chronicConditionTile.dart';

class chronicConditionList extends StatefulWidget {
  const chronicConditionList({super.key, required this.chronicDetail});
  final List<ChronicConditionModel>? chronicDetail;

  @override
  State<chronicConditionList> createState() => _chronicConditionListState();
}

class _chronicConditionListState extends State<chronicConditionList> {
  @override
  Widget build(BuildContext context) {
    if (widget.chronicDetail!.isEmpty) {
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
        itemCount: widget.chronicDetail?.length,
        itemBuilder: ((context, index) {
          return chronicConditionTile(
            chronicCondition: widget.chronicDetail![index],
          );
        }),
      );
    }
  }
}