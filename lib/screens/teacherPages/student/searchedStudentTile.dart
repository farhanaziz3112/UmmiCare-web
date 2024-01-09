import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/screens/charts/noOfStudentsPerClass.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';

class searchedStudentTile extends StatefulWidget {
  const searchedStudentTile({super.key, required this.childId});
  final String childId;

  @override
  State<searchedStudentTile> createState() => _searchedStudentTileState();
}

class _searchedStudentTileState extends State<searchedStudentTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<childModel>(
      stream: childDatabase(childId: widget.childId).childData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          childModel? child = snapshot.data;
          return StreamBuilder<studentModel>(
            stream: studentDatabase().studentData(child!.educationId),
            builder: (context, snapshot) {
              studentModel? student = snapshot.data;
              if (snapshot.hasData) {
                return StreamBuilder<classModel>(
                  stream: schoolDatabase().classData(student!.classId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      classModel? classDetail = snapshot.data;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: InkWell(
                          onTap: () {
                            context.go(
                                '/teacher/class/${student.academicCalendarId}/student/${student.studentId}');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(2)),
                              border: Border.all(
                                  color:
                                      Colors.grey),
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
                                      child.childName,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 15),
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
                                          color: Colors.black,
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
                                      classDetail!.classYear,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black,
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
                                      classDetail.className,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.black,
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
                  },
                );
              } else {
                return Container();
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
