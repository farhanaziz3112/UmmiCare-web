import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/scheduleModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/models/subjectModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/examDatabase.dart';
import 'package:ummicare/services/scheduleDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class addNewExam extends StatefulWidget {
  const addNewExam({super.key, required this.academicCalendarId});
  final String academicCalendarId;

  @override
  State<addNewExam> createState() => _addNewExamState();
}

class _addNewExamState extends State<addNewExam> {
  final _formKey = GlobalKey<FormState>();

  String examTitle = '';
  DateTime examStartDate = DateTime.now();
  DateTime examEndDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  String examStatus = '';

  List<academicCalendarScheduleModel> subjects = [];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 1500) {
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
                    stream:
                        schoolDatabase().classData(academicCalendar!.classId),
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
                                  text: TextSpan(
                                      text: 'Examination',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          decoration: TextDecoration.underline),
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
                                  text: const TextSpan(
                                    text: 'Add New Exam',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 40),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Add New Exam',
                                style: TextStyle(
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
                                'Add and Schedule New Exam',
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
                            const SizedBox(height: 30),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 2,
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: const Text(
                                              'Exam Title',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          TextFormField(
                                            initialValue: examTitle,
                                            decoration:
                                                textInputDecoration.copyWith(
                                                    hintText: 'Exam Title'),
                                            validator: (value) => value == ''
                                                ? 'Please enter exam title'
                                                : null,
                                            onChanged: (value) => setState(
                                                () => examTitle = value),
                                          ),
                                          const SizedBox(
                                            height: 40.0,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: const Text(
                                              'Exam Starting Date',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0.0,
                                                horizontal: 20.0),
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
                                                      examStartDate.day
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                                const Text(
                                                  ' / ',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                Column(
                                                  children: [
                                                    const Text(
                                                      'Month',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      examStartDate.month
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                                const Text(
                                                  ' / ',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                Column(
                                                  children: [
                                                    const Text(
                                                      'Year',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      examStartDate.year
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xff8290F0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          examStartDate,
                                                      firstDate: convertTimeToDate(
                                                          academicCalendar
                                                              .academicCalendarStartDate),
                                                      lastDate: convertTimeToDate(
                                                          academicCalendar
                                                              .academicCalendarEndDate),
                                                    ).then((date) {
                                                      setState(() {
                                                        examStartDate = date!;
                                                      });
                                                    });
                                                  },
                                                  child: const Text(
                                                    'Set Exam Start Date',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40.0,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: const Text(
                                              'Exam End Date',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0.0,
                                                horizontal: 20.0),
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
                                                      examEndDate.day
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                                const Text(
                                                  ' / ',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                Column(
                                                  children: [
                                                    const Text(
                                                      'Month',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      examEndDate.month
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                                const Text(
                                                  ' / ',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                Column(
                                                  children: [
                                                    const Text(
                                                      'Year',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      examEndDate.year
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xff8290F0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    showDatePicker(
                                                      context: context,
                                                      initialDate: examEndDate,
                                                      firstDate: convertTimeToDate(
                                                          academicCalendar
                                                              .academicCalendarStartDate),
                                                      lastDate: convertTimeToDate(
                                                          academicCalendar
                                                              .academicCalendarEndDate),
                                                    ).then((date) {
                                                      setState(() {
                                                        examEndDate = date!;
                                                      });
                                                    });
                                                    //showTimePicker(context: context, initialTime: TimeOfDay.now());
                                                  },
                                                  child: const Text(
                                                    'Set Exam End Date',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 50.0,
                                          ),
                                          StreamBuilder<List<studentModel>>(
                                              stream: studentDatabase()
                                                  .allStudentWithAcademicCalendarAndStatus(
                                                      academicCalendar
                                                          .academicCalendarId,
                                                      'active'),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  List<studentModel>? students =
                                                      snapshot.data;
                                                  return StreamBuilder<
                                                          List<subjectModel>>(
                                                      stream: academicCalendarDatabase()
                                                          .allSubjectData(
                                                              academicCalendar
                                                                  .academicCalendarId),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          List<subjectModel>?
                                                              subjectList =
                                                              snapshot.data;
                                                          return ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              fixedSize:
                                                                  const Size(
                                                                      150, 30),
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffF29180),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                            ),
                                                            child: const Text(
                                                              'Submit',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              if (_formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                setState(() {
                                                                  if (DateTime.now()
                                                                          .isAfter(
                                                                              examStartDate) &&
                                                                      DateTime.now()
                                                                          .isBefore(
                                                                              examEndDate)) {
                                                                    examStatus =
                                                                        'ongoing';
                                                                  } else if (DateTime
                                                                          .now()
                                                                      .isAfter(
                                                                          examEndDate)) {
                                                                    examStatus =
                                                                        'ended';
                                                                  } else {
                                                                    examStatus =
                                                                        'inactive';
                                                                  }
                                                                });

                                                                final document =
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Exam')
                                                                        .doc();
                                                                examDatabase().updateExamData(
                                                                    document.id,
                                                                    academicCalendar
                                                                        .academicCalendarId,
                                                                    examTitle,
                                                                    examStartDate
                                                                        .millisecondsSinceEpoch
                                                                        .toString(),
                                                                    examEndDate
                                                                        .millisecondsSinceEpoch
                                                                        .toString(),
                                                                    examStatus);

                                                                for (int i = 0;
                                                                    i <
                                                                        subjectList!
                                                                            .length;
                                                                    i++) {
                                                                  scheduleDatabase().createAcademicCalendarScheduleData(
                                                                      '${subjectList[i].subjectName} (${examTitle})',
                                                                      examStartDate
                                                                          .millisecondsSinceEpoch
                                                                          .toString(),
                                                                      examStartDate
                                                                          .millisecondsSinceEpoch
                                                                          .toString(),
                                                                      examEndDate
                                                                          .millisecondsSinceEpoch
                                                                          .toString(),
                                                                      academicCalendar
                                                                          .academicCalendarId,
                                                                      document
                                                                          .id,
                                                                      'exam');
                                                                  for (int j =
                                                                          0;
                                                                      j <
                                                                          students!
                                                                              .length;
                                                                      j++) {
                                                                    // final examResultDocument = FirebaseFirestore
                                                                    //     .instance
                                                                    //     .collection(
                                                                    //         'Exam Result')
                                                                    //     .doc();
                                                                    // examDatabase().updateExamResultData(
                                                                    //     examResultDocument
                                                                    //         .id,
                                                                    //     document
                                                                    //         .id,
                                                                    //     academicCalendar
                                                                    //         .academicCalendarId,
                                                                    //     students[
                                                                    //             j]
                                                                    //         .studentId,
                                                                    //     '');
                                                                    examDatabase().createSubjectResultData(
                                                                        subjectList[i]
                                                                            .subjectId,
                                                                        document
                                                                            .id,
                                                                        '',
                                                                        students[j]
                                                                            .studentId,
                                                                        academicCalendar
                                                                            .academicCalendarId,
                                                                        '',
                                                                        '',
                                                                        '');
                                                                  }
                                                                }

                                                                context.go(
                                                                    '/teacher/class/${academicCalendar.academicCalendarId}/exam/${document.id}/schedule');
                                                              }
                                                            },
                                                          );
                                                        } else {
                                                          return const Loading();
                                                        }
                                                      });
                                                } else {
                                                  return const Loading();
                                                }
                                              }),
                                        ],
                                      ),
                                    )),
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    )
                              ],
                            )
                          ],
                        );
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
    } else {
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
                    stream:
                        schoolDatabase().classData(academicCalendar!.classId),
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
                                  text: TextSpan(
                                      text: 'Examination',
                                      style: const TextStyle(
                                          color: Colors.grey,
                                          decoration: TextDecoration.underline),
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
                                  text: const TextSpan(
                                    text: 'Add New Exam',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 40),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'Add New Exam',
                                style: TextStyle(
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
                                'Add and Schedule New Exam',
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
                            const SizedBox(height: 30),
                            Row(
                              children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: const Text(
                                              'Exam Title',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          TextFormField(
                                            initialValue: examTitle,
                                            decoration:
                                                textInputDecoration.copyWith(
                                                    hintText: 'Exam Title'),
                                            validator: (value) => value == ''
                                                ? 'Please enter exam title'
                                                : null,
                                            onChanged: (value) => setState(
                                                () => examTitle = value),
                                          ),
                                          const SizedBox(
                                            height: 40.0,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: const Text(
                                              'Exam Starting Date',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0.0,
                                                horizontal: 20.0),
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
                                                      examStartDate.day
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                                const Text(
                                                  ' / ',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                Column(
                                                  children: [
                                                    const Text(
                                                      'Month',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      examStartDate.month
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                                const Text(
                                                  ' / ',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                Column(
                                                  children: [
                                                    const Text(
                                                      'Year',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      examStartDate.year
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xff8290F0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          examStartDate,
                                                      firstDate: convertTimeToDate(
                                                          academicCalendar
                                                              .academicCalendarStartDate),
                                                      lastDate: convertTimeToDate(
                                                          academicCalendar
                                                              .academicCalendarEndDate),
                                                    ).then((date) {
                                                      setState(() {
                                                        examStartDate = date!;
                                                      });
                                                    });
                                                  },
                                                  child: const Text(
                                                    'Set Exam Start Date',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 40.0,
                                          ),
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: const Text(
                                              'Exam End Date',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 15.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20.0,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 0.0,
                                                horizontal: 20.0),
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
                                                      examEndDate.day
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                                const Text(
                                                  ' / ',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                Column(
                                                  children: [
                                                    const Text(
                                                      'Month',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      examEndDate.month
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                                const Text(
                                                  ' / ',
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                Column(
                                                  children: [
                                                    const Text(
                                                      'Year',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      examEndDate.year
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 20.0),
                                                    ),
                                                  ],
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xff8290F0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    showDatePicker(
                                                      context: context,
                                                      initialDate: examEndDate,
                                                      firstDate: convertTimeToDate(
                                                          academicCalendar
                                                              .academicCalendarStartDate),
                                                      lastDate: convertTimeToDate(
                                                          academicCalendar
                                                              .academicCalendarEndDate),
                                                    ).then((date) {
                                                      setState(() {
                                                        examEndDate = date!;
                                                      });
                                                    });
                                                    //showTimePicker(context: context, initialTime: TimeOfDay.now());
                                                  },
                                                  child: const Text(
                                                    'Set Exam End Date',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 50.0,
                                          ),
                                          StreamBuilder<List<studentModel>>(
                                              stream: studentDatabase()
                                                  .allStudentWithAcademicCalendarAndStatus(
                                                      academicCalendar
                                                          .academicCalendarId,
                                                      'active'),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  List<studentModel>? students =
                                                      snapshot.data;
                                                  return StreamBuilder<
                                                          List<subjectModel>>(
                                                      stream: academicCalendarDatabase()
                                                          .allSubjectData(
                                                              academicCalendar
                                                                  .academicCalendarId),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          List<subjectModel>?
                                                              subjectList =
                                                              snapshot.data;
                                                          return ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              fixedSize:
                                                                  const Size(
                                                                      150, 30),
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xffF29180),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                            ),
                                                            child: const Text(
                                                              'Submit',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              if (_formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                                setState(() {
                                                                  if (DateTime.now()
                                                                          .isAfter(
                                                                              examStartDate) &&
                                                                      DateTime.now()
                                                                          .isBefore(
                                                                              examEndDate)) {
                                                                    examStatus =
                                                                        'ongoing';
                                                                  } else if (DateTime
                                                                          .now()
                                                                      .isAfter(
                                                                          examEndDate)) {
                                                                    examStatus =
                                                                        'ended';
                                                                  } else {
                                                                    examStatus =
                                                                        'inactive';
                                                                  }
                                                                });

                                                                final document =
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'Exam')
                                                                        .doc();
                                                                examDatabase().updateExamData(
                                                                    document.id,
                                                                    academicCalendar
                                                                        .academicCalendarId,
                                                                    examTitle,
                                                                    examStartDate
                                                                        .millisecondsSinceEpoch
                                                                        .toString(),
                                                                    examEndDate
                                                                        .millisecondsSinceEpoch
                                                                        .toString(),
                                                                    examStatus);

                                                                for (int i = 0;
                                                                    i <
                                                                        subjectList!
                                                                            .length;
                                                                    i++) {
                                                                  scheduleDatabase().createAcademicCalendarScheduleData(
                                                                      '${subjectList[i].subjectName} (${examTitle})',
                                                                      examStartDate
                                                                          .millisecondsSinceEpoch
                                                                          .toString(),
                                                                      examStartDate
                                                                          .millisecondsSinceEpoch
                                                                          .toString(),
                                                                      examEndDate
                                                                          .millisecondsSinceEpoch
                                                                          .toString(),
                                                                      academicCalendar
                                                                          .academicCalendarId,
                                                                      document
                                                                          .id,
                                                                      'exam');
                                                                  for (int j =
                                                                          0;
                                                                      j <
                                                                          students!
                                                                              .length;
                                                                      j++) {
                                                                    // final examResultDocument = FirebaseFirestore
                                                                    //     .instance
                                                                    //     .collection(
                                                                    //         'Exam Result')
                                                                    //     .doc();
                                                                    // examDatabase().updateExamResultData(
                                                                    //     examResultDocument
                                                                    //         .id,
                                                                    //     document
                                                                    //         .id,
                                                                    //     academicCalendar
                                                                    //         .academicCalendarId,
                                                                    //     students[
                                                                    //             j]
                                                                    //         .studentId,
                                                                    //     '');
                                                                    examDatabase().createSubjectResultData(
                                                                        subjectList[i]
                                                                            .subjectId,
                                                                        document
                                                                            .id,
                                                                        '',
                                                                        students[j]
                                                                            .studentId,
                                                                        academicCalendar
                                                                            .academicCalendarId,
                                                                        '',
                                                                        '',
                                                                        '');
                                                                  }
                                                                }

                                                                context.go(
                                                                    '/teacher/class/${academicCalendar.academicCalendarId}/exam/${document.id}/schedule');
                                                              }
                                                            },
                                                          );
                                                        } else {
                                                          return const Loading();
                                                        }
                                                      });
                                                } else {
                                                  return const Loading();
                                                }
                                              }),
                                        ],
                                      ),
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                )
                              ],
                            )
                          ],
                        );
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
  }
}
