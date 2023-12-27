import 'package:flutter/material.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/screens/medicalStaff_Pages/settings/clinicTile.dart';

class clinicList extends StatefulWidget {
  const clinicList({super.key, required this.clinicDetails});
  final List<ClinicModel> clinicDetails;

  @override
  State<clinicList> createState() => _clinicListState();
}

class _clinicListState extends State<clinicList> {
  @override
  Widget build(BuildContext context) {
    if (widget.clinicDetails.isEmpty) {
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
        itemCount: widget.clinicDetails.length,
        itemBuilder: ((context, index) {
          return const clinicTile();
        }),
      );
    }
  }
}
