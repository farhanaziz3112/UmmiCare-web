import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/shared/loading.dart';
import 'package:ummicare/shared/function.dart';

class studentProfile extends StatefulWidget {
  const studentProfile({super.key, required this.studentId});
  final String studentId;

  @override
  State<studentProfile> createState() => _studentProfileState();
}

class _studentProfileState extends State<studentProfile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<studentModel>(
      stream: studentDatabase().studentData(widget.studentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          studentModel? student = snapshot.data;
          return Container(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: StreamBuilder<classModel>(
                  stream: schoolDatabase().classData(student!.classId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      classModel? classDetail = snapshot.data;
                      return StreamBuilder<childModel>(
                          stream:
                              childDatabase(childId: student.childId).childData,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              childModel? child = snapshot.data;
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
                                                    '/teacher/class/${student.academicCalendarId}');
                                              }),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text('>'),
                                      const SizedBox(width: 10),
                                      RichText(
                                        text: TextSpan(
                                            text: 'Student',
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.underline),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                context.go(
                                                    '/teacher/class/${student.academicCalendarId}/student');
                                              }),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text('>'),
                                      const SizedBox(width: 10),
                                      RichText(
                                        text: TextSpan(
                                          text: child!.childFirstname,
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
                                      '${child.childFirstname}\' Profile',
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
                                    child: Text(
                                      child.childName,
                                      style: const TextStyle(
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
                                    height: 700,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: <Widget>[
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40,
                                                      vertical: 30),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
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
                                                      Container(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                              Icons.person,
                                                              size: 35,
                                                            ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              '${child.childFirstname}\'s Details',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      20.0,
                                                                  fontFamily:
                                                                      'Comfortaa',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
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
                                                                  'Full Name',
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
                                                                  'First Name',
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
                                                                  'Last Name',
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
                                                                  'Age',
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
                                                                  'Birthday',
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
                                                                  'Parent',
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
                                                            flex: 3,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <Widget>[
                                                                Text(
                                                                  ': ${child.childName}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                  ': ${child.childFirstname}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                  ': ${child.childLastname}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                  ': ${child.childCurrentAge}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                Text(
                                                                  ': ${convertTimeToDateString(child.childBirthday)}',
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                const SizedBox(
                                                                    height: 10),
                                                                StreamBuilder<
                                                                        parentModel>(
                                                                    stream: parentDatabase(
                                                                            parentId: child
                                                                                .parentId)
                                                                        .parentData,
                                                                    builder:
                                                                        (context,
                                                                            snapshot) {
                                                                      if (snapshot
                                                                          .hasData) {
                                                                        return Text(
                                                                          ': ${snapshot.data!.parentFullName} (${snapshot.data!.parentPhoneNumber})',
                                                                          style:
                                                                              const TextStyle(fontSize: 15),
                                                                        );
                                                                      } else {
                                                                        return Container();
                                                                      }
                                                                    }),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 40,
                                                      vertical: 30),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffF29180),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                10)),
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
                                                      Container(
                                                        alignment:
                                                            Alignment.topCenter,
                                                        child: const Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(
                                                              Icons.fact_check,
                                                              size: 35,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              'Attendance',
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      20.0,
                                                                  fontFamily:
                                                                      'Comfortaa',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      Container(alignment: Alignment.centerLeft,child: Text('Last 5 days:', textAlign: TextAlign.start,))
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
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
                                                        'Examination',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            color: Colors.black,
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
                                              ],
                                            ),
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
                          });
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
