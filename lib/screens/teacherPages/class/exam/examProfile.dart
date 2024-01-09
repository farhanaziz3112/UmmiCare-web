import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/models/scheduleModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/subjectModel.dart';
import 'package:ummicare/screens/teacherPages/class/exam/examList/examSubjectList.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/examDatabase.dart';
import 'package:ummicare/services/scheduleDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/shared/calendar.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class examProfile extends StatefulWidget {
  const examProfile(
      {super.key, required this.examId, required this.academicCalendarId});
  final String academicCalendarId;
  final String examId;

  @override
  State<examProfile> createState() => _examProfileState();
}

class _examProfileState extends State<examProfile> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return StreamBuilder<academicCalendarModel>(
      stream: academicCalendarDatabase()
          .academicCalendarData(widget.academicCalendarId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          academicCalendarModel? academicCalendar = snapshot.data;
          return Container(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: StreamBuilder<examModel>(
                stream: examDatabase().examData(widget.examId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    examModel? exam = snapshot.data;
                    return StreamBuilder<classModel>(
                      stream:
                          schoolDatabase().classData(academicCalendar!.classId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          classModel? classDetail = snapshot.data;
                          return StreamBuilder<List<subjectModel>>(
                              stream: academicCalendarDatabase().allSubjectData(
                                  academicCalendar.academicCalendarId),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<subjectModel>? subjects = snapshot.data;
                                  return Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(
                                                text: 'Class',
                                                style: const TextStyle(
                                                    color: Colors.grey,
                                                    decoration: TextDecoration
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
                                                    decoration: TextDecoration
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
                                                    decoration: TextDecoration
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
                                              text: exam!.examTitle,
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 40),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          exam.examTitle,
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
                                          'View and manage examination schedule and marks.',
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
                                        height: 300,
                                        width: double.maxFinite,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 40,
                                                        vertical: 30),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 1,
                                                      blurRadius: 5,
                                                      offset: const Offset(0,
                                                          3), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.topCenter,
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.edit_note,
                                                            size: 35,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            'Exam Details',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 20.0,
                                                                fontFamily:
                                                                    'Comfortaa',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 20),
                                                    Row(
                                                      children: <Widget>[
                                                        const Expanded(
                                                          flex: 1,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                'Exam Title',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                'Exam ID',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                'Exam Start Date',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                'Exam End Date',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                              SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                'Exam Status',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 20),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                ': ${exam.examTitle}',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                ': ${exam.examId}',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                ': ${convertTimeToDateWithStringMonth(exam.examStartDate)}',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              Text(
                                                                ': ${convertTimeToDateWithStringMonth(exam.examEndDate)}',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              exam.examStatus ==
                                                                      'inactive'
                                                                  ? Row(
                                                                      children: [
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Row(
                                                                            children: [
                                                                              Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                child: const Text(': '),
                                                                              ),
                                                                              Container(
                                                                                  alignment: Alignment.center,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.yellow[800],
                                                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                  ),
                                                                                  padding: const EdgeInsets.all(7),
                                                                                  child: const Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: <Widget>[
                                                                                      Icon(
                                                                                        Icons.schedule,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Text(
                                                                                        'Inactive',
                                                                                        style: TextStyle(color: Colors.white),
                                                                                      )
                                                                                    ],
                                                                                  )),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          flex:
                                                                              1,
                                                                          child:
                                                                              Container(),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  : exam.examStatus ==
                                                                          'ongoing'
                                                                      ? Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: const Text(': '),
                                                                                  ),
                                                                                  Container(
                                                                                      alignment: Alignment.center,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.green[800],
                                                                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                      ),
                                                                                      padding: const EdgeInsets.all(7),
                                                                                      child: const Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: <Widget>[
                                                                                          Icon(
                                                                                            Icons.schedule,
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Text(
                                                                                            'Ongoing',
                                                                                            style: TextStyle(color: Colors.white),
                                                                                          )
                                                                                        ],
                                                                                      )),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(),
                                                                            ),
                                                                          ],
                                                                        )
                                                                      : Row(
                                                                          children: [
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Row(
                                                                                children: [
                                                                                  Container(
                                                                                    alignment: Alignment.centerLeft,
                                                                                    child: const Text(': '),
                                                                                  ),
                                                                                  Container(
                                                                                      alignment: Alignment.center,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.red[800],
                                                                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                      ),
                                                                                      padding: const EdgeInsets.all(7),
                                                                                      child: const Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: <Widget>[
                                                                                          Icon(
                                                                                            Icons.schedule,
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Text(
                                                                                            'Ended',
                                                                                            style: TextStyle(color: Colors.white),
                                                                                          )
                                                                                        ],
                                                                                      )),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            Expanded(
                                                                              flex: 1,
                                                                              child: Container(),
                                                                            ),
                                                                          ],
                                                                        )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            screenSize.width < 1300
                                                ? Container()
                                                : Expanded(
                                                    flex: 1,
                                                    child: Container(),
                                                  )
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 80),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: const Text(
                                          'Subject List Grading',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30.0,
                                              fontFamily: 'Comfortaa',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              alignment: Alignment.center,
                                              constraints: const BoxConstraints(
                                                  minWidth: 100, maxWidth: 200),
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
                                              constraints: const BoxConstraints(
                                                  minWidth: 100, maxWidth: 200),
                                              child: const Text(
                                                'Subject ID',
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
                                              constraints: const BoxConstraints(
                                                  minWidth: 100, maxWidth: 200),
                                              child: const Text(
                                                'Grading',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 15),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 30),
                                      examSubjectList(
                                        academicCalendarId:
                                            academicCalendar.academicCalendarId,
                                        subjects: subjects,
                                        examId: exam.examId,
                                      ),
                                      const SizedBox(height: 80),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: const Text(
                                          'Exam Schedule',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 30.0,
                                              fontFamily: 'Comfortaa',
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      Container(
                                        alignment: Alignment.topLeft,
                                        child: ElevatedButton.icon(
                                          icon: const Icon(
                                            Icons.edit,
                                            size: 24.0,
                                            color: Colors.white,
                                          ),
                                          style: OutlinedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xffF29180),
                                            fixedSize: const Size(250, 50),
                                            alignment: Alignment.center,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                side: BorderSide.none),
                                          ),
                                          onPressed: () {
                                            context.go(
                                                '/teacher/class/${academicCalendar.academicCalendarId}/exam/${exam.examId}/schedule');
                                          },
                                          label: const Text(
                                            'Edit Schedule',
                                            style: TextStyle(
                                                fontSize: 15.0,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 30),
                                      StreamBuilder<
                                              List<
                                                  academicCalendarScheduleModel>>(
                                          stream: scheduleDatabase()
                                              .scheduleDataWithAcademicCalendarIdExamId(
                                                  academicCalendar
                                                      .academicCalendarId,
                                                  exam.examId,
                                                  'exam'),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return SizedBox(
                                                height: 500,
                                                child: SfCalendar(
                                                  minDate: convertTimeToDate(
                                                          exam.examStartDate)
                                                      .subtract(const Duration(
                                                          days: 1)),
                                                  maxDate: convertTimeToDate(
                                                          exam.examEndDate)
                                                      .add(const Duration(
                                                          days: 1)),
                                                  view: CalendarView.week,
                                                  dataSource:
                                                      academicCalendarScheduler(
                                                          _getDataSource(
                                                              snapshot.data)),
                                                  timeSlotViewSettings:
                                                      const TimeSlotViewSettings(
                                                          startHour: 6,
                                                          endHour: 18,
                                                          timeIntervalHeight:
                                                              50),
                                                  monthViewSettings:
                                                      const MonthViewSettings(
                                                          appointmentDisplayMode:
                                                              MonthAppointmentDisplayMode
                                                                  .appointment),
                                                ),
                                              );
                                            } else {
                                              return Loading();
                                            }
                                          }),
                                      const SizedBox(height: 200),
                                    ],
                                  );
                                } else {
                                  return Loading();
                                }
                              });
                        } else {
                          return const Loading();
                        }
                      },
                    );
                  } else {
                    return const Loading();
                  }
                },
              ),
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
