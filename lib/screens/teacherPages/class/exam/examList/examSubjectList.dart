import 'package:flutter/material.dart';
import 'package:ummicare/models/subjectModel.dart';
import 'package:ummicare/screens/teacherPages/class/exam/examList/examSubjectTile.dart';

class examSubjectList extends StatefulWidget {
  const examSubjectList({super.key, required this.academicCalendarId, required this.subjects, required this.examId});
  final String academicCalendarId;
  final String examId;
  final List<subjectModel>? subjects;

  @override
  State<examSubjectList> createState() => _examSubjectListState();
}

class _examSubjectListState extends State<examSubjectList> {
   @override
  Widget build(BuildContext context) {
    if (widget.subjects!.isEmpty) {
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
        itemCount: widget.subjects!.length,
        itemBuilder: ((context, index) {
          return examSubjectTile(
              academicCalendarId: widget.academicCalendarId,
              subjectId: widget.subjects![index].subjectId,
              examId: widget.examId,);
        }),
      );
    }
  }
}