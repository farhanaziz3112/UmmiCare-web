import 'package:flutter/material.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/screens/teacherPages/class/attendance/studentAttendanceTile.dart';

class studentAttendanceList extends StatefulWidget {
  const studentAttendanceList({super.key, required this.students});
  final List<studentModel>? students;

  @override
  State<studentAttendanceList> createState() => _studentAttendanceListState();
}

class _studentAttendanceListState extends State<studentAttendanceList> {
  @override
  Widget build(BuildContext context) {
    if (widget.students!.isEmpty) {
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
        itemCount: widget.students!.length,
        itemBuilder: ((context, index) {
          return studentAttendanceTile(student: widget.students![index]);
        }),
      );
    }
  }
}
