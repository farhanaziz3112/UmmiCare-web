import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/healthStatus/healthCondition/healthConditionTile.dart';
import 'package:ummicare/services/healthDatabase.dart';

class healthConditionList extends StatefulWidget {
  const healthConditionList({super.key, required this.conditionDetail});
  final List<HealthConditionModel>? conditionDetail;

  @override
  State<healthConditionList> createState() => _healthConditionListState();
}

class _healthConditionListState extends State<healthConditionList> {
  @override
  Widget build(BuildContext context) {
    if (widget.conditionDetail!.isEmpty) {
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
        itemCount: widget.conditionDetail?.length,
        itemBuilder: ((context, index) {
          return healthConditionTile(
            healthCondition: widget.conditionDetail![index],
          );
        }),
      );
    }
  }
}