import 'package:flutter/material.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/screens/teacherPages/class/classTile.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class classGrid extends StatefulWidget {
  const classGrid({super.key, required this.teacherId});
  final String teacherId;

  @override
  State<classGrid> createState() => _classListState();
}

class _classListState extends State<classGrid> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return StreamBuilder<List<academicCalendarModel>>(
      stream: academicCalendarDatabase()
          .allAcademicCalendarDataWithTeacherId(widget.teacherId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<academicCalendarModel>? academicCalendarList = snapshot.data;
          if (academicCalendarList!.isEmpty) {
            return Container(
              padding: const EdgeInsets.only(top: 50),
              child: const Center(
                child: Text(
                  'There is no class at the moment. You can register new class by pressing button above.',
                ),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: academicCalendarList.length,
              itemBuilder: ((context, index) {
                return classTile(
                  academicCalendarDetail: academicCalendarList[index],
                  colorIndex: (index % 3),
                );
              }),
            );
          }
        } else {
          return Container(
            padding: const EdgeInsets.only(top: 50),
            child: Center(child: noData('There is no class at the moment...')),
          );
        }
      }),
    );
  }
}
