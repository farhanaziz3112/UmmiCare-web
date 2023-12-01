import 'package:flutter/material.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/screens/teacherPages/settings/schoolTile.dart';

class schoolList extends StatefulWidget {
  const schoolList({super.key, required this.schoolDetails});
  final List<schoolModel> schoolDetails;

  @override
  State<schoolList> createState() => _schoolListState();
}

class _schoolListState extends State<schoolList> {
  @override
  Widget build(BuildContext context) {
    if (widget.schoolDetails.isEmpty) {
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
        itemCount: widget.schoolDetails.length,
        itemBuilder: ((context, index) {
          return schoolTile(
            schoolDetail: widget.schoolDetails[index]
          );
        }),
      );
    }
  }
}
