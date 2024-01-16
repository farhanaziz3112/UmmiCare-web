import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/screens/adminPages/medicalStaff/clinic/clinicTile.dart';

class clinicList extends StatefulWidget {
  const clinicList({super.key,});

  @override
  State<clinicList> createState() => _clinicListState();
}

class _clinicListState extends State<clinicList> {
  @override
  Widget build(BuildContext context) {
    final clinicList = Provider.of<List<ClinicModel>>(context);

    if (clinicList.isEmpty) {
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
        itemCount: clinicList.length,
        itemBuilder: ((context, index) {
          return clinicTile(
            clinicDetails: clinicList[index]
          );
        }),
      );
    }
  }
}
