import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/subjectModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/examDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/shared/loading.dart';

class examSubject extends StatefulWidget {
  const examSubject(
      {super.key,
      required this.academicCalendarId,
      required this.subjectId,
      required this.examId});
  final String academicCalendarId;
  final String subjectId;
  final String examId;

  @override
  State<examSubject> createState() => _examSubjectState();
}

class _examSubjectState extends State<examSubject> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<academicCalendarModel>(
      stream: academicCalendarDatabase()
          .academicCalendarData(widget.academicCalendarId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          academicCalendarModel? academicCalendar = snapshot.data;
          return StreamBuilder<subjectModel>(
            stream: academicCalendarDatabase().subjectData(
                academicCalendar!.academicCalendarId, widget.subjectId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                subjectModel? subject = snapshot.data;
                return StreamBuilder<examModel>(
                  stream: examDatabase().examData(widget.examId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      examModel? exam = snapshot.data;
                      return StreamBuilder<classModel>(
                        stream: schoolDatabase()
                            .classData(academicCalendar.classId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            classModel? classDetail = snapshot.data;
                            return Container(
                              alignment: Alignment.topLeft,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        RichText(
                                          text: TextSpan(
                                              text: 'Class',
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  decoration:
                                                      TextDecoration.underline),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  context.go('/teacher/class');
                                                }),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text('>'),
                                        const SizedBox(width: 10),
                                        RichText(
                                          text: TextSpan(
                                              text:
                                                  '${classDetail!.classYear} : ${classDetail.className}',
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  decoration:
                                                      TextDecoration.underline),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  context.go(
                                                      '/teacher/class/${academicCalendar.academicCalendarId}');
                                                }),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text('>'),
                                        const SizedBox(width: 10),
                                        RichText(
                                          text: TextSpan(
                                              text: 'Examination',
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  decoration:
                                                      TextDecoration.underline),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  context.go(
                                                      '/teacher/class/${academicCalendar.academicCalendarId}/exam');
                                                }),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text('>'),
                                        const SizedBox(width: 10),
                                        RichText(
                                          text: TextSpan(
                                              text: exam!.examTitle,
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  decoration:
                                                      TextDecoration.underline),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  context.go(
                                                      '/teacher/class/${academicCalendar.academicCalendarId}/exam/${exam.examId}');
                                                }),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text('>'),
                                        const SizedBox(width: 10),
                                        RichText(
                                          text: TextSpan(
                                            text: subject!.subjectName,
                                            style:
                                                const TextStyle(color: Colors.grey),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${subject.subjectName}\'s Examination',
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 35.0,
                                            fontFamily: 'Comfortaa',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: const Text(
                                        'Add and Manage Students Grading and Marks',
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    const SizedBox(height: 30),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Container(
                                        height: 1.0,
                                        width: double.infinity,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                    const SizedBox(height: 50),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const Loading();
                          }
                        },
                      );
                    } else {
                      return const Loading();
                    }
                  },
                );
              } else {
                return const Loading();
              }
            },
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
