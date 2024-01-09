import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/teacherPages/student/searchedStudentList.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/adminDatabase.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class studentMain extends StatefulWidget {
  const studentMain({super.key});

  @override
  State<studentMain> createState() => _studentMainState();
}

class _studentMainState extends State<studentMain> {
  final _formKey = GlobalKey<FormState>();

  String searchName = '';
  List<childModel> searchedStudents = [];

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);
    return StreamBuilder<teacherModel>(
        stream: teacherDatabase(teacherId: user!.userId).teacherData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            teacherModel? teacher = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Student',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 50.0,
                            fontFamily: 'Comfortaa',
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
                      stream: studentDatabase().allStudents(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<studentModel>? studentList = snapshot.data;
                          return StreamBuilder<List<academicCalendarModel>>(
                              stream: academicCalendarDatabase()
                                  .allAcademicCalendarDataWithTeacherId(
                                      teacher!.teacherId),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<academicCalendarModel>? academicCalendar =
                                      snapshot.data;
                                  List<studentModel>? finalStudentList = [];
                                  for (int i = 0; i < studentList!.length; i++) {
                                    for (int j = 0;
                                        j < academicCalendar!.length;
                                        j++) {
                                      if (studentList[i].academicCalendarId ==
                                          academicCalendar[j]
                                              .academicCalendarId) {
                                        finalStudentList.add(studentList[i]);
                                      }
                                    }
                                  }
                                  return StreamBuilder<List<childModel>>(
                                      stream: adminDatabase().allChildData,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<childModel>? childList = [];
                                          for (int i = 0;
                                              i < snapshot.data!.length;
                                              i++) {
                                            for (int j = 0;
                                                j < finalStudentList.length;
                                                j++) {
                                              if (snapshot.data![i].educationId ==
                                                  finalStudentList[j].studentId) {
                                                childList.add(snapshot.data![i]);
                                              }
                                            }
                                          }
                                          return Form(
                                            key: _formKey,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: TextFormField(
                                                    initialValue: searchName,
                                                    decoration: textInputDecoration
                                                        .copyWith(
                                                            hintText:
                                                                'Student Name'),
                                                    validator: (value) => value ==
                                                            ''
                                                        ? 'Please enter student name'
                                                        : null,
                                                    onChanged: ((value) =>
                                                        setState(() {
                                                          searchName = value;
                                                        })),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.search,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ),
                                                  style: IconButton.styleFrom(
                                                      backgroundColor:
                                                          const Color(
                                                              0xffF29180)),
                                                  onPressed: () async {
                                                    searchedStudents.clear();
                                                    for (int i = 0;
                                                        i < childList.length;
                                                        i++) {
                                                      if (childList[i]
                                                          .childName
                                                          .toLowerCase()
                                                          .contains(searchName
                                                              .toLowerCase())) {
                                                        setState(() {
                                                          searchedStudents
                                                              .add(childList[i]);
                                                        });
                                                      }
                                                    }
                                                  },
                                                ),
                                                Expanded(
                                                    flex: 2, child: Container()),
                                              ],
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
                        } else {
                          return Container();
                        }
                      },
                    ),
                    const SizedBox(height: 50),
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
                              'Name',
                              style: TextStyle(color: Colors.grey, fontSize: 15),
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
                              style: TextStyle(color: Colors.grey, fontSize: 15),
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
                              'Class Year',
                              style: TextStyle(color: Colors.grey, fontSize: 15),
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
                              'Class Name',
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    searchedStudentList(childs: searchedStudents)
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
