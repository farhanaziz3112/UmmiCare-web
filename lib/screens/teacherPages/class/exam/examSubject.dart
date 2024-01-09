import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/models/subjectModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/examDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/shared/function.dart';
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
  List<String> marks = [];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
                              child: StreamBuilder<List<studentModel>>(
                                  stream: studentDatabase()
                                      .allStudentWithAcademicCalendarAndStatus(
                                          widget.academicCalendarId, 'active'),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      List<studentModel>? students =
                                          snapshot.data;
                                      return SingleChildScrollView(
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
                                                      text: exam!.examTitle,
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
                                                  text: TextSpan(
                                                    text: subject!.subjectName,
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
                                                '${subject.subjectName}\'s Examination',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 35.0,
                                                    fontFamily: 'Comfortaa',
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Container(
                                                height: 1.0,
                                                width: double.infinity,
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                            const SizedBox(height: 50),
                                            StreamBuilder<
                                                    List<subjectResultModel>>(
                                                stream: examDatabase()
                                                    .subjectResultDataWithSubjectIdAndExamId(
                                                        subject.subjectId,
                                                        exam.examId),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    List<subjectResultModel>?
                                                        subjectResultList =
                                                        snapshot.data;
                                                    return Container(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child:
                                                          ElevatedButton.icon(
                                                        icon: const Icon(
                                                          Icons.edit,
                                                          size: 24.0,
                                                          color: Colors.white,
                                                        ),
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              const Color(
                                                                  0xffF29180),
                                                          fixedSize: const Size(
                                                              250, 50),
                                                          alignment:
                                                              Alignment.center,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              side: BorderSide
                                                                  .none),
                                                        ),
                                                        onPressed: () {
                                                          bool validate = true;
                                                          for (int i = 0;
                                                              i <
                                                                  students!
                                                                      .length;
                                                              i++) {
                                                            marks.add('');
                                                          }
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                final _formKey =
                                                                    GlobalKey<
                                                                        FormState>();
                                                                return Form(
                                                                  key: _formKey,
                                                                  child:
                                                                      StatefulBuilder(
                                                                    builder:
                                                                        (stfContext,
                                                                            stfSetState) {
                                                                      return AlertDialog(
                                                                        scrollable:
                                                                            true,
                                                                        title:
                                                                            const Padding(
                                                                          padding:
                                                                              EdgeInsets.all(10.0),
                                                                          child:
                                                                              Text('Add and Edit Students Mark'),
                                                                        ),
                                                                        content:
                                                                            Column(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: 500,
                                                                              height: 600,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(10.0),
                                                                                child: ListView.builder(
                                                                                  shrinkWrap: true,
                                                                                  itemCount: students.length,
                                                                                  itemBuilder: ((context, index) {
                                                                                    return StreamBuilder<List<subjectResultModel>>(
                                                                                      stream: examDatabase().subjectResultDataWithStudentIdAndSubjectId(students[index].studentId, widget.subjectId, widget.examId),
                                                                                      builder: (context, snapshot) {
                                                                                        if (snapshot.hasData) {
                                                                                          List<subjectResultModel>? result = snapshot.data;
                                                                                          return Padding(
                                                                                            padding: const EdgeInsets.all(0),
                                                                                            child: Container(
                                                                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                                                                              decoration: BoxDecoration(
                                                                                                color: Colors.white,
                                                                                                borderRadius: const BorderRadius.all(Radius.circular(1)),
                                                                                                border: Border.all(color: Colors.grey),
                                                                                                boxShadow: [
                                                                                                  BoxShadow(
                                                                                                    color: Colors.grey.withOpacity(0.5),
                                                                                                    spreadRadius: 1,
                                                                                                    blurRadius: 1,
                                                                                                    offset: const Offset(0, 0), // changes position of shadow
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                              child: Row(
                                                                                                children: <Widget>[
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Text((index + 1).toString()),
                                                                                                  ),
                                                                                                  StreamBuilder<childModel>(
                                                                                                      stream: childDatabase(childId: students[index].childId).childData,
                                                                                                      builder: (context, snapshot) {
                                                                                                        if (snapshot.hasData) {
                                                                                                          return Expanded(
                                                                                                            flex: 2,
                                                                                                            child: Container(
                                                                                                              alignment: Alignment.center,
                                                                                                              constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                                                                                                              child: Text(
                                                                                                                snapshot.data!.childName,
                                                                                                                softWrap: false,
                                                                                                                maxLines: 1,
                                                                                                                overflow: TextOverflow.fade,
                                                                                                                textAlign: TextAlign.center,
                                                                                                                style: const TextStyle(color: Colors.black, fontSize: 15),
                                                                                                              ),
                                                                                                            ),
                                                                                                          );
                                                                                                        } else {
                                                                                                          return const Loading();
                                                                                                        }
                                                                                                      }),
                                                                                                  Expanded(
                                                                                                    flex: 1,
                                                                                                    child: Container(),
                                                                                                  ),
                                                                                                  Expanded(
                                                                                                    flex: 2,
                                                                                                    child: Row(
                                                                                                      children: [
                                                                                                        Expanded(
                                                                                                          flex: 1,
                                                                                                          child: Container(),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 3,
                                                                                                          child: Container(
                                                                                                            alignment: Alignment.center,
                                                                                                            constraints: const BoxConstraints(minWidth: 20, maxWidth: 30, minHeight: 10, maxHeight: 40),
                                                                                                            child: TextFormField(
                                                                                                              inputFormatters: <TextInputFormatter>[
                                                                                                                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                                                                                              ],
                                                                                                              textAlign: TextAlign.center,
                                                                                                              decoration: const InputDecoration(
                                                                                                                fillColor: Colors.white,
                                                                                                                filled: true,
                                                                                                                contentPadding: EdgeInsets.all(5.0),
                                                                                                                enabledBorder: OutlineInputBorder(
                                                                                                                  borderSide: BorderSide(width: 1, color: Colors.grey),
                                                                                                                  borderRadius: BorderRadius.all(
                                                                                                                    Radius.circular(10.0),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                focusedBorder: OutlineInputBorder(
                                                                                                                  borderSide: BorderSide(width: 1, color: Colors.black),
                                                                                                                  borderRadius: BorderRadius.all(
                                                                                                                    Radius.circular(5.0),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                errorBorder: OutlineInputBorder(
                                                                                                                  borderSide: BorderSide(color: Colors.red),
                                                                                                                  borderRadius: BorderRadius.all(
                                                                                                                    Radius.circular(10.0),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                focusedErrorBorder: OutlineInputBorder(
                                                                                                                  borderSide: BorderSide(color: Colors.red),
                                                                                                                  borderRadius: BorderRadius.all(
                                                                                                                    Radius.circular(5.0),
                                                                                                                  ),
                                                                                                                ),
                                                                                                                errorStyle: TextStyle(fontSize: 1, color: Colors.red, fontWeight: FontWeight.w100),
                                                                                                              ),
                                                                                                              initialValue: result!.first.subjectMark,
                                                                                                              validator: (value) => value == '' ? '' : null,
                                                                                                              onChanged: (value) => stfSetState(() {
                                                                                                                marks[index] = value.toString();
                                                                                                              }),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                        Expanded(
                                                                                                          flex: 1,
                                                                                                          child: Container(),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        } else {
                                                                                          return const Loading();
                                                                                        }
                                                                                      },
                                                                                    );
                                                                                  }),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            validate == true
                                                                                ? Container()
                                                                                : const Text(
                                                                                    'Please fill in all text fields.',
                                                                                    style: TextStyle(color: Colors.red),
                                                                                  )
                                                                          ],
                                                                        ),
                                                                        actions: [
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: const Color(0xffF29180),
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                const Text("Cancel", style: TextStyle(color: Colors.white)),
                                                                          ),
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: const Color(0xff8290F0),
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              if (_formKey.currentState!.validate()) {
                                                                                for (int i = 0; i < students.length; i++) {
                                                                                  for (int j = 0; j < subjectResultList!.length; j++) {
                                                                                    if (subjectResultList[j].studentId == students[i].studentId) {
                                                                                      if (marks[i] == '') {
                                                                                        examDatabase().updateSubjectResultData(subjectResultList[j].subjectResultId, subjectResultList[j].subjectId, subjectResultList[j].examId, '', subjectResultList[j].studentId, subjectResultList[j].academicCalendarId, subjectResultList[j].subjectMark, subjectResultList[j].subjectGrade, subjectResultList[j].subjectGradeStatus);
                                                                                      } else {
                                                                                        examDatabase().updateSubjectResultData(subjectResultList[j].subjectResultId, subjectResultList[j].subjectId, subjectResultList[j].examId, '', subjectResultList[j].studentId, subjectResultList[j].academicCalendarId, marks[i], getGrade(marks[i]), getGradeStatus(getGrade(marks[i])));
                                                                                      }
                                                                                    }
                                                                                  }
                                                                                }
                                                                                stfSetState(() {
                                                                                  marks.clear();
                                                                                });
                                                                                Navigator.of(context).pop();
                                                                              } else {
                                                                                stfSetState(() {
                                                                                  validate = false;
                                                                                });
                                                                              }
                                                                            },
                                                                            child:
                                                                                const Text("Submit", style: TextStyle(color: Colors.white)),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                );
                                                              });
                                                        },
                                                        label: const Text(
                                                          'Add and Edit Marks',
                                                          style: TextStyle(
                                                              fontSize: 15.0,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return const Loading();
                                                  }
                                                }),
                                            const SizedBox(height: 50),
                                            Row(
                                              children: <Widget>[
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
                                                      'Student Name',
                                                      textAlign:
                                                          TextAlign.center,
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
                                                      'Grade',
                                                      textAlign:
                                                          TextAlign.center,
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
                                                      'Mark',
                                                      textAlign:
                                                          TextAlign.center,
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
                                                      'Grade Status',
                                                      textAlign:
                                                          TextAlign.center,
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
                                            ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: students!.length,
                                              itemBuilder: ((context, index) {
                                                return StreamBuilder<
                                                    List<subjectResultModel>>(
                                                  stream: examDatabase()
                                                      .subjectResultDataWithStudentIdAndSubjectId(
                                                          students[index]
                                                              .studentId,
                                                          widget.subjectId,
                                                          widget.examId),
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      List<subjectResultModel>?
                                                          result =
                                                          snapshot.data;
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        child: Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 15),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            1)),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .grey),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.5),
                                                                spreadRadius: 1,
                                                                blurRadius: 1,
                                                                offset: const Offset(
                                                                    0,
                                                                    0), // changes position of shadow
                                                              ),
                                                            ],
                                                          ),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child: Text(
                                                                    (index + 1)
                                                                        .toString()),
                                                              ),
                                                              StreamBuilder<
                                                                      childModel>(
                                                                  stream: childDatabase(
                                                                          childId: students[index]
                                                                              .childId)
                                                                      .childData,
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    if (snapshot
                                                                        .hasData) {
                                                                      return Expanded(
                                                                        flex: 2,
                                                                        child:
                                                                            Container(
                                                                          alignment:
                                                                              Alignment.center,
                                                                          constraints: const BoxConstraints(
                                                                              minWidth: 100,
                                                                              maxWidth: 200),
                                                                          child:
                                                                              Text(
                                                                            snapshot.data!.childName,
                                                                            softWrap:
                                                                                false,
                                                                            maxLines:
                                                                                1,
                                                                            overflow:
                                                                                TextOverflow.fade,
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style:
                                                                                const TextStyle(color: Colors.black, fontSize: 15),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return const Loading();
                                                                    }
                                                                  }),
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
                                                                  child: result!
                                                                              .first
                                                                              .subjectGrade ==
                                                                          ''
                                                                      ? const Text(
                                                                          'No data',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 15),
                                                                        )
                                                                      : Text(
                                                                          result
                                                                              .first
                                                                              .subjectGrade,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: const TextStyle(
                                                                              color: Colors.black,
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
                                                                  child: result
                                                                              .first
                                                                              .subjectMark ==
                                                                          ''
                                                                      ? const Text(
                                                                          'No data',
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 15),
                                                                        )
                                                                      : Text(
                                                                          result
                                                                              .first
                                                                              .subjectMark,
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: const TextStyle(
                                                                              color: Colors.black,
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
                                                              result.first.subjectGradeStatus ==
                                                                      ''
                                                                  ? Expanded(
                                                                      flex: 2,
                                                                      child: Container(
                                                                          alignment: Alignment.center,
                                                                          constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                                                                          child: const Text(
                                                                            'No data',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                                color: Colors.grey,
                                                                                fontWeight: FontWeight.normal,
                                                                                fontSize: 15),
                                                                          )),
                                                                    )
                                                                  : result.first
                                                                              .subjectGradeStatus ==
                                                                          'pass'
                                                                      ? Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Row(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                flex: 1,
                                                                                child: Container(),
                                                                              ),
                                                                              Expanded(
                                                                                flex: 2,
                                                                                child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.green[500],
                                                                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(5),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: <Widget>[
                                                                                        screenSize.width < 1500 ? Container() :
                                                                                        const Icon(
                                                                                          Icons.check,
                                                                                          color: Colors.white,
                                                                                        ),
                                                                                        screenSize.width < 1500 ? Container() : const SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        const Text(
                                                                                          'Pass',
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        )
                                                                                      ],
                                                                                    )),
                                                                              ),
                                                                              Expanded(
                                                                                flex: 1,
                                                                                child: Container(),
                                                                              )
                                                                            ],
                                                                          ))
                                                                      : Expanded(
                                                                          flex:
                                                                              2,
                                                                          child:
                                                                              Row(
                                                                            children: <Widget>[
                                                                              Expanded(
                                                                                flex: 1,
                                                                                child: Container(),
                                                                              ),
                                                                              Expanded(
                                                                                flex: 2,
                                                                                child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.red[500],
                                                                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                    ),
                                                                                    padding: const EdgeInsets.all(5),
                                                                                    child:  Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: <Widget>[
                                                                                        screenSize.width < 1500 ? Container() : const Icon(
                                                                                          Icons.close,
                                                                                          color: Colors.white,
                                                                                        ),
                                                                                        screenSize.width < 1500 ? Container() : const SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        const Text(
                                                                                          'Fail',
                                                                                          style: TextStyle(color: Colors.white),
                                                                                        )
                                                                                      ],
                                                                                    )),
                                                                              ),
                                                                              Expanded(
                                                                                flex: 1,
                                                                                child: Container(),
                                                                              )
                                                                            ],
                                                                          ))
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    } else {
                                                      return const Loading();
                                                    }
                                                  },
                                                );
                                              }),
                                            )
                                          ],
                                        ),
                                      );
                                    } else {
                                      return const Loading();
                                    }
                                  }),
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
