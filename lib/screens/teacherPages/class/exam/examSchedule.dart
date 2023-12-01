import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/models/scheduleModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/screens/teacherPages/class/exam/examList/examScheduleList.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/examDatabase.dart';
import 'package:ummicare/services/scheduleDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/shared/calendar.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class examSchedule extends StatefulWidget {
  const examSchedule(
      {super.key, required this.academicCalendarId, required this.examId});
  final String academicCalendarId;
  final String examId;

  @override
  State<examSchedule> createState() => _examScheduleState();
}

class _examScheduleState extends State<examSchedule> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<academicCalendarModel>(
      stream: academicCalendarDatabase()
          .academicCalendarData(widget.academicCalendarId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          academicCalendarModel? academicCalendar = snapshot.data;
          return Container(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: StreamBuilder<classModel>(
                  stream: schoolDatabase().classData(academicCalendar!.classId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      classModel? classDetail = snapshot.data;
                      return StreamBuilder<examModel>(
                          stream: examDatabase().examData(widget.examId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              examModel? exam = snapshot.data;
                              return StreamBuilder<
                                      List<academicCalendarScheduleModel>>(
                                  stream: scheduleDatabase()
                                      .scheduleDataWithAcademicCalendarIdExamId(
                                          academicCalendar.academicCalendarId,
                                          exam!.examId,
                                          'exam'),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<academicCalendarScheduleModel>?
                                          examSchedule = snapshot.data;
                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              RichText(
                                                text: TextSpan(
                                                    text: 'Class',
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            context.go(
                                                                '/teacher/class');
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
                                                            TextDecoration
                                                                .underline),
                                                    recognizer:
                                                        TapGestureRecognizer()
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
                                                            TextDecoration
                                                                .underline),
                                                    recognizer:
                                                        TapGestureRecognizer()
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
                                                    text: exam.examTitle,
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .underline),
                                                    recognizer:
                                                        TapGestureRecognizer()
                                                          ..onTap = () {
                                                            context.go(
                                                                '/teacher/class/${academicCalendar.academicCalendarId}/exam/${exam.examId}');
                                                          }),
                                              ),
                                              const SizedBox(width: 10),
                                              const Text('>'),
                                              const SizedBox(width: 10),
                                              RichText(
                                                text: const TextSpan(
                                                  text: 'Exam Schedule',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 40),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Exam Schedule : ${exam.examTitle}',
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
                                              'Add and Manage Exam Schedule',
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
                                          SizedBox(
                                            height: 500,
                                            child: SfCalendar(
                                              minDate: convertTimeToDate(
                                                      exam.examStartDate)
                                                  .subtract(const Duration(days: 1)),
                                              maxDate: convertTimeToDate(
                                                      exam.examEndDate)
                                                  .add(const Duration(days: 1)),
                                              view: CalendarView.week,
                                              dataSource:
                                                  academicCalendarScheduler(
                                                      _getDataSource(
                                                          examSchedule)),
                                              timeSlotViewSettings:
                                                  const TimeSlotViewSettings(
                                                      startHour: 6,
                                                      endHour: 18,
                                                      timeIntervalHeight: 50),
                                              monthViewSettings: const MonthViewSettings(
                                                  appointmentDisplayMode:
                                                      MonthAppointmentDisplayMode
                                                          .appointment),
                                            ),
                                          ),
                                          const SizedBox(height: 50),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  constraints:
                                                      const BoxConstraints(
                                                          minWidth: 100,
                                                          maxWidth: 200),
                                                  child: const Text(
                                                    'Subject Name',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  constraints:
                                                      const BoxConstraints(
                                                          minWidth: 100,
                                                          maxWidth: 200),
                                                  child: const Text(
                                                    'Date',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  constraints:
                                                      const BoxConstraints(
                                                          minWidth: 100,
                                                          maxWidth: 200),
                                                  child: const Text(
                                                    'Start Time',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  constraints:
                                                      const BoxConstraints(
                                                          minWidth: 100,
                                                          maxWidth: 200),
                                                  child: const Text(
                                                    'End Time',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          examScheduleList(
                                              examSchedule: examSchedule)
                                        ],
                                      );
                                    } else {
                                      return const Loading();
                                    }
                                  });
                            } else {
                              return const Loading();
                            }
                          });
                    } else {
                      return const Loading();
                    }
                  }),
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }

  List<Meeting> _getDataSource(List<academicCalendarScheduleModel>? examList) {
    final List<Color> _colorList = [
      Colors.orange,
      Colors.blueAccent,
      Colors.blueGrey,
      Colors.red,
      Colors.brown,
      Colors.green,
      Colors.orangeAccent,
      Colors.purple,
      Colors.teal,
      Colors.lightBlue
    ];
    final List<Meeting> meetings = <Meeting>[];
    for (int i = 0; i < examList!.length; i++) {
      meetings.add(Meeting(
          examList[i].title,
          convertTimeToDate(examList[i].from),
          convertTimeToDate(examList[i].to),
          i > 9 ? _colorList[i - 10] : _colorList[i],
          false));
    }
    return meetings;
  }
}
