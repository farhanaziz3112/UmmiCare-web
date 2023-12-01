import 'package:flutter/material.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/screens/teacherPages/class/student/studentNameList/studentTile.dart';

class studentList extends StatefulWidget {
  const studentList({super.key, required this.students});
  final List<studentModel>? students;

  @override
  State<studentList> createState() => _studentListState();
}

class _studentListState extends State<studentList> {
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
          return studentTile(
            student: widget.students![index]
          );
        }),
      );
    }
  }
}