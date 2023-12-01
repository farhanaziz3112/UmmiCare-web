import 'package:flutter/material.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';
import 'package:ummicare/screens/teacherPages/class/attendance/studentAttendanceRecordTile.dart';

class studentAttendanceRecordList extends StatefulWidget {
  const studentAttendanceRecordList({super.key, required this.records});
  final List<studentAttendanceModel>? records;

  @override
  State<studentAttendanceRecordList> createState() =>
      _studentAttendanceRecordListState();
}

class _studentAttendanceRecordListState
    extends State<studentAttendanceRecordList> {
  @override
  Widget build(BuildContext context) {
    if (widget.records!.isEmpty) {
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
        itemCount: widget.records!.length,
        itemBuilder: ((context, index) {
          return studentAttendanceRecordTile(record: widget.records![index]);
        }),
      );
    }
  }
}
