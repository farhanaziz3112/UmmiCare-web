import 'package:flutter/material.dart';
import 'package:ummicare/models/scheduleModel.dart';
import 'package:ummicare/screens/teacherPages/class/exam/examList/examScheduleTile.dart';

class examScheduleList extends StatefulWidget {
  const examScheduleList({super.key, required this.examSchedule});
  final List<academicCalendarScheduleModel>? examSchedule;

  @override
  State<examScheduleList> createState() => _examScheduleListState();
}

class _examScheduleListState extends State<examScheduleList> {
  @override
  Widget build(BuildContext context) {
    if (widget.examSchedule!.isEmpty) {
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
        itemCount: widget.examSchedule!.length,
        itemBuilder: ((context, index) {
          return examScheduleTile(
              examScheduleId: widget.examSchedule![index].academicCalendarScheduleId);
        }),
      );
    }
  }
}
