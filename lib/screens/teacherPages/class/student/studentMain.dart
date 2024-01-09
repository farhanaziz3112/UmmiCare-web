import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/screens/charts/noOfStudentsStatus.dart';
import 'package:ummicare/screens/teacherPages/class/student/studentNameList/studentList.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class studentMain extends StatefulWidget {
  const studentMain({super.key, required this.academicCalendarId});
  final String academicCalendarId;

  @override
  State<studentMain> createState() => _studentMainState();
}

class _studentMainState extends State<studentMain> {
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
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                text: 'Student',
                                style: TextStyle(color: Colors.grey),
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
                            'Student management page, where you can view student\'s details and registration.',
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Container(
                            height: 1.0,
                            width: double.infinity,
                            color: Colors.grey[300],
                          ),
                        ),
                        const SizedBox(height: 50),
                        StreamBuilder<List<studentModel>>(
                            stream: studentDatabase()
                                .allStudentWithAcademicCalendar(
                                    academicCalendar.academicCalendarId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Row(
                                  children: [
                                    Expanded(
                                        flex: 2,
                                        child: noOfStudentsStatus(
                                            academicCalendarId: academicCalendar
                                                .academicCalendarId)),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 30),
                                        decoration: BoxDecoration(
                                          color: const Color(0xffF29180),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              getNoOfStudentStatus(
                                                      snapshot.data, 'inactive')
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 50),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              'Number of Inactive Students',
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 30),
                                        decoration: BoxDecoration(
                                          color: const Color(0xff8290F0),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Text(
                                              getNoOfStudentStatus(
                                                      snapshot.data, 'active')
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 50),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              'Number of Active Students',
                                              style: TextStyle(fontSize: 20),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            }),
                        const SizedBox(height: 80),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Registration Status',
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
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: ToggleSwitch(
                                  minWidth: 90.0,
                                  cornerRadius: 20.0,
                                  activeBgColors: [
                                    [Colors.green[800]!],
                                    [Colors.red[800]!]
                                  ],
                                  activeFgColor: Colors.white,
                                  inactiveBgColor: Colors.grey,
                                  inactiveFgColor: Colors.white,
                                  initialLabelIndex:
                                      academicCalendar.registrationStatus ==
                                              'open'
                                          ? 0
                                          : 1,
                                  totalSwitches: 2,
                                  labels: const ['open', 'close'],
                                  radiusStyle: true,
                                  onToggle: (index) {
                                    academicCalendarDatabase()
                                        .updateAcademicCalendarData(
                                            academicCalendar.academicCalendarId,
                                            academicCalendar.schoolId,
                                            academicCalendar.classId,
                                            academicCalendar.teacherId,
                                            academicCalendar
                                                .academicCalendarStartDate,
                                            academicCalendar
                                                .academicCalendarEndDate,
                                            academicCalendar.noOfStudent,
                                            index == 0 ? 'open' : 'close');
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
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
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: const Row(
                                  children: <Widget>[
                                    Expanded(flex: 1, child: Icon(Icons.info)),
                                    Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Press the toggle button below to change the class registration status.',
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                              '\'Open\' status will allow student to register into the class.'),
                                          Text(
                                              '\'Close\' will prevent the student from register into the class.'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container())
                          ],
                        ),
                        const SizedBox(height: 80),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Active Students',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
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
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    const Expanded(flex: 1, child: Icon(Icons.info)),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        child: const Text(
                                          'Press the student card below to view student\'s profile.',
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 3, child: Container())
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: const Text(
                                  'First Name',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: const Text(
                                  'Last Name',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: const Text(
                                  'Age',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: const Text(
                                  'Student ID',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: const Text(
                                  'Activation Status',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
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
                                return studentList(students: snapshot.data);
                              } else {
                                return Container();
                              }
                            }),
                        const SizedBox(height: 80),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Inactive Students',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                                fontFamily: 'Comfortaa',
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 20),
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
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: <Widget>[
                                    const Expanded(flex: 1, child: Icon(Icons.info)),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        child: const Text(
                                          'Press the student card below to approve student registration.',
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(flex: 3, child: Container())
                          ],
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: const Text(
                                  'First Name',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: const Text(
                                  'Last Name',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: const Text(
                                  'Age',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: const Text(
                                  'Student ID',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(flex: 1, child: Container()),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: const Text(
                                  'Activation Status',
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        StreamBuilder<List<studentModel>>(
                            stream: studentDatabase()
                                .allStudentWithAcademicCalendarAndStatus(
                                    academicCalendar.academicCalendarId,
                                    'inactive'),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return studentList(students: snapshot.data);
                              } else {
                                return Container();
                              }
                            })
                      ],
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
}
