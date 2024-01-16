import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/notificationDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';

class studentTile extends StatefulWidget {
  const studentTile({super.key, required this.student});
  final studentModel student;

  @override
  State<studentTile> createState() => _studentTileState();
}

class _studentTileState extends State<studentTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<studentModel>(
        stream: studentDatabase().studentData(widget.student.studentId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            studentModel? student = snapshot.data;
            return StreamBuilder<childModel>(
                stream: childDatabase(childId: student!.childId).childData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    childModel? child = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        onTap: () {
                          student.activationStatus == 'active'
                              ? context.go(
                                  '/teacher/class/${student.academicCalendarId}/student/${student.studentId}')
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      scrollable: true,
                                      title: const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(30, 20, 30, 0),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              size: 40,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Student Detail',
                                              style: TextStyle(fontSize: 30),
                                            ),
                                          ],
                                        ),
                                      ),
                                      content: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 10, 30, 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'First Name',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              child.childFirstname,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Last Name',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              child.childLastname,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Current Age',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '${child.childCurrentAge.toString()} years old',
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Student ID',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              student.studentId,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15),
                                            ),
                                            const SizedBox(height: 20),
                                            const Text(
                                              'Activation Status',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              student.activationStatus,
                                              textAlign: TextAlign.start,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 15),
                                            ),
                                            const SizedBox(
                                              height: 30.0,
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'REMINDER: Make sure all the details are right before proceed to register the student!',
                                                textAlign: TextAlign.justify,
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xffF29180),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        StreamBuilder<studentModel>(
                                            stream: studentDatabase()
                                                .studentData(student.studentId),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                studentModel? student =
                                                    snapshot.data;
                                                return StreamBuilder<
                                                        classModel>(
                                                    stream: schoolDatabase()
                                                        .classData(
                                                            student!.classId),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        classModel?
                                                            classDetail =
                                                            snapshot.data;
                                                        return ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                const Color(
                                                                    0xff8290F0),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                          ),
                                                          onPressed: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return AlertDialog(
                                                                    scrollable:
                                                                        true,
                                                                    title:
                                                                        const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              10.0),
                                                                      child: Text(
                                                                          'Registration Confirmation'),
                                                                    ),
                                                                    content:
                                                                        const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              10),
                                                                      child: Text(
                                                                          'Are you sure you want to register this student?'),
                                                                    ),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              const Color(0xffF29180),
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            "Cancel",
                                                                            style:
                                                                                TextStyle(color: Colors.white)),
                                                                      ),
                                                                      ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              const Color(0xff8290F0),
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          studentDatabase().updateStudentData(
                                                                              student.studentId,
                                                                              student.childId,
                                                                              student.schoolId,
                                                                              student.academicCalendarId,
                                                                              student.classId,
                                                                              student.feeId,
                                                                              'active');
                                                                          notificationDatabase().createNotificationData(
                                                                              child.parentId,
                                                                              child.childId,
                                                                              'education',
                                                                              'Registration Verified!',
                                                                              '${child.childFirstname}\'s registration with ${classDetail!.className} ${classDetail.classYear} has been verified by the teacher.',
                                                                              'unseen',
                                                                              DateTime.now().millisecondsSinceEpoch.toString());
                                                                          academicCalendarDatabase().addStudents(
                                                                              student.academicCalendarId,
                                                                              student.studentId);
                                                                          Navigator.of(
                                                                              context)
                                                                            ..pop()
                                                                            ..pop();
                                                                        },
                                                                        child: const Text(
                                                                            "Confirm",
                                                                            style:
                                                                                TextStyle(color: Colors.white)),
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                          },
                                                          child: const Text(
                                                              "Register",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white)),
                                                        );
                                                      } else {
                                                        return Container();
                                                      }
                                                    });
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      ],
                                    );
                                  });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          decoration: BoxDecoration(
                            color: student.activationStatus == 'active'
                                ? const Color(0xff8290F0)
                                : const Color(0xffF29180),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  constraints: const BoxConstraints(
                                      minWidth: 100, maxWidth: 200),
                                  child: Text(
                                    child!.childFirstname,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 15),
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
                                  child: Text(
                                    child.childLastname,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
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
                                  child: Text(
                                    '${child.childCurrentAge.toString()} years old',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
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
                                  child: Text(
                                    student.studentId,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
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
                                  child: Text(
                                    student.activationStatus,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                });
          } else {
            return Container();
          }
        });
  }
}
