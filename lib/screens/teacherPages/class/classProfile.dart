import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class classProfile extends StatefulWidget {
  const classProfile({super.key, required this.academicCalendarId});
  final String academicCalendarId;

  @override
  State<classProfile> createState() => _classProfileState();
}

class _classProfileState extends State<classProfile> {
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
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${classDetail.classYear} : ${classDetail.className}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 45.0,
                                  fontFamily: 'Comfortaa',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Class profile with all the details like schedule, fee and students detail.',
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
                          SizedBox(
                            height: 300,
                            width: double.maxFinite,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 30),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.topCenter,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.school,
                                                size: 35,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Class Details',
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20.0,
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    'Class Name',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'Class Year',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'Class Teacher Name',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'School',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'Calendar Start Date',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    'Calendar End Date',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    ': ${classDetail.className}',
                                                    style: const TextStyle(
                                                        fontSize: 15),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    ': ${classDetail.classYear}',
                                                    style: const TextStyle(
                                                        fontSize: 15),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  StreamBuilder<teacherModel>(
                                                      stream: teacherDatabase(
                                                              teacherId:
                                                                  academicCalendar
                                                                      .teacherId)
                                                          .teacherData,
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            ': ${snapshot.data!.teacherFullName}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        15),
                                                          );
                                                        } else {
                                                          return Container();
                                                        }
                                                      }),
                                                  const SizedBox(height: 10),
                                                  StreamBuilder<schoolModel>(
                                                      stream: schoolDatabase()
                                                          .schoolData(
                                                              academicCalendar
                                                                  .schoolId),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          return Text(
                                                            ': ${snapshot.data!.schoolName}',
                                                            style: const TextStyle(
                                                                fontSize: 15),
                                                          );
                                                        } else {
                                                          return Container();
                                                        }
                                                      }),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    ': ${convertTimeToDateString(academicCalendar.academicCalendarStartDate)}',
                                                    style: const TextStyle(
                                                        fontSize: 15),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    ': ${convertTimeToDateString(academicCalendar.academicCalendarEndDate)}',
                                                    style: const TextStyle(
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            context.go('/teacher/class/${academicCalendar.academicCalendarId}/student');
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            width: double.maxFinite,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xff71CBCA),
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
                                              children: <Widget>[
                                                const Icon(
                                                  Icons.groups_2,
                                                  size: 60,
                                                ),
                                                const Text(
                                                  'Student Management',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  'Manage students details and registration.',
                                                  style: TextStyle(
                                                      color: Colors.grey[800],
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            context.go('/teacher/class/${academicCalendar.academicCalendarId}/fee');
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            width: double.maxFinite,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xff8290F0),
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
                                              children: <Widget>[
                                                const Icon(
                                                  Icons.payment,
                                                  size: 60,
                                                ),
                                                const Text(
                                                  'Fee Payment Management',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  'Manage students fee payment.',
                                                  style: TextStyle(
                                                      color: Colors.grey[800],
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            context.go('/teacher/class/${academicCalendar.academicCalendarId}/exam');
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            width: double.maxFinite,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xff8290F0),
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
                                              children: <Widget>[
                                                const Icon(
                                                  Icons.edit_note,
                                                  size: 60,
                                                ),
                                                const Text(
                                                  'Examination',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  'Manage examination result.',
                                                  style: TextStyle(
                                                      color: Colors.grey[800],
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            context.go('/teacher/class/${academicCalendar.academicCalendarId}/attendance');
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(10),
                                            width: double.maxFinite,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: const Color(0xfff29180),
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
                                              children: <Widget>[
                                                const Icon(
                                                  Icons.fact_check,
                                                  size: 60,
                                                ),
                                                const Text(
                                                  'Attendance',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20),
                                                ),
                                                Text(
                                                  'Manage students daily attendance.',
                                                  style: TextStyle(
                                                      color: Colors.grey[800],
                                                      fontSize: 15),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
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
