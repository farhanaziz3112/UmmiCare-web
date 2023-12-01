import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/screens/teacherPages/class/attendance/studentAttendanceList.dart';
import 'package:ummicare/screens/teacherPages/class/attendance/studentAttendanceRecordList.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentAttendanceDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class studentAttendance extends StatefulWidget {
  const studentAttendance({super.key, required this.academicCalendarId});
  final String academicCalendarId;

  @override
  State<studentAttendance> createState() => _studentAttendanceState();
}

class _studentAttendanceState extends State<studentAttendance> {
  DateTime _recordDate = DateTime.now().subtract(const Duration(days: 1));

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
                      return Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                    text: 'Class',
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.underline),
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
                                        decoration: TextDecoration.underline),
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
                                text: const TextSpan(
                                  text: 'Student Attendance',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${classDetail.classYear} : ${classDetail.className} \'s Attendance',
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
                              'Record, view and manage class attendance.',
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Container(
                              height: 1.0,
                              width: double.infinity,
                              color: Colors.grey[300],
                            ),
                          ),
                          const SizedBox(height: 50),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Today Attendance : ${DateTime.now().day.toString()} ${monthToString(DateTime.now().month)} ${DateTime.now().year.toString()}',
                              style: const TextStyle(
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
                                    'Full Name',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
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
                                    'Student ID',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
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
                                      'Attendance Status',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.normal,
                                          fontSize: 15),
                                    )),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          StreamBuilder<List<studentModel>>(
                            stream: studentDatabase()
                                .allStudentWithAcademicCalendarAndStatus(
                                    academicCalendar.academicCalendarId,
                                    'active'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return studentAttendanceList(
                                    students: snapshot.data);
                              } else {
                                return const Loading();
                              }
                            },
                          ),
                          const SizedBox(height: 50),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Attendance Record',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 30.0,
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Column(
                                              children: [
                                                const Text(
                                                  'Day',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  _recordDate.day.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20.0),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                            const Text(
                                              ' / ',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              children: [
                                                const Text(
                                                  'Month',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  _recordDate.month.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20.0),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                            const Text(
                                              ' / ',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(width: 10),
                                            Column(
                                              children: [
                                                const Text(
                                                  'Year',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  _recordDate.year.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20.0),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 10),
                                            IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.grey[800],
                                              ),
                                              onPressed: () {
                                                showDatePicker(
                                                  context: context,
                                                  initialDate: _recordDate,
                                                  firstDate: convertTimeToDate(
                                                      academicCalendar
                                                          .academicCalendarStartDate),
                                                  lastDate: DateTime.now()
                                                      .subtract(const Duration(
                                                          days: 1)),
                                                ).then((date) {
                                                  setState(() {
                                                    _recordDate = date!;
                                                  });
                                                });
                                              },
                                            ),
                                            const SizedBox(width: 20),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xff8290F0),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Text(
                                                              'Attendance Record : ${_recordDate.day} ${monthToString(_recordDate.month)} ${_recordDate.year}'),
                                                        ),
                                                        content: SizedBox(
                                                          width: 800,
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              5,
                                                                          vertical:
                                                                              5),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border
                                                                            .all(),
                                                                        borderRadius:
                                                                            const BorderRadius
                                                                                .all(
                                                                                Radius.circular(
                                                                                    10)),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color: Colors
                                                                                .grey
                                                                                .withOpacity(
                                                                                    0.5),
                                                                            spreadRadius:
                                                                                1,
                                                                            blurRadius:
                                                                                5,
                                                                            offset: const Offset(
                                                                                0,
                                                                                3), // changes position of shadow
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child: Row(
                                                                        children: <Widget>[
                                                                          const Expanded(
                                                                              flex: 1,
                                                                              child: Icon(
                                                                                  Icons.info)),
                                                                          Expanded(
                                                                            flex: 4,
                                                                            child:
                                                                                Container(
                                                                              child:
                                                                                  const Text(
                                                                                'Press the student card below to view attendance description.',
                                                                                textAlign:
                                                                                    TextAlign.start,
                                                                                style: TextStyle(
                                                                                  fontSize: 15
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(flex: 1,child: Container(),)
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 30),
                                                              Row(
                                                                children: <Widget>[
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      constraints: const BoxConstraints(
                                                                          minWidth:
                                                                              100,
                                                                          maxWidth:
                                                                              200),
                                                                      child:
                                                                          const Text(
                                                                        'Full Name',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontSize: 15),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Container(),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child:
                                                                        Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      constraints: const BoxConstraints(
                                                                          minWidth:
                                                                              100,
                                                                          maxWidth:
                                                                              200),
                                                                      child:
                                                                          const Text(
                                                                        'Student ID',
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey,
                                                                            fontWeight: FontWeight.normal,
                                                                            fontSize: 15),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child:
                                                                        Container(),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 2,
                                                                    child: Container(
                                                                        alignment: Alignment.center,
                                                                        constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                                                                        child: const Text(
                                                                          'Attendance Status',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 15),
                                                                        )),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                  height: 10),
                                                              StreamBuilder<
                                                                  List<
                                                                      studentAttendanceModel>>(
                                                                stream: studentAttendanceDatabase().allStudentAttendanceWithAcademicCalendarIdAndSpecificDate(
                                                                    academicCalendar
                                                                        .academicCalendarId,
                                                                    _recordDate
                                                                        .day
                                                                        .toString(),
                                                                    _recordDate
                                                                        .month
                                                                        .toString(),
                                                                    _recordDate
                                                                        .year
                                                                        .toString()),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  if (snapshot
                                                                      .hasData) {
                                                                    return studentAttendanceRecordList(
                                                                        records:
                                                                            snapshot.data);
                                                                  } else {
                                                                    return const Loading();
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              },
                                              child: const Text(
                                                'View Record',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              )
                            ],
                          )
                        ],
                      );
                    } else {
                      return Container();
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
}
