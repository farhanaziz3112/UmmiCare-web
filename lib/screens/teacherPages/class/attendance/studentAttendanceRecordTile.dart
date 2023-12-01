import 'package:flutter/material.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';

class studentAttendanceRecordTile extends StatefulWidget {
  const studentAttendanceRecordTile({super.key, required this.record});
  final studentAttendanceModel record;

  @override
  State<studentAttendanceRecordTile> createState() =>
      _studentAttendanceRecordTileState();
}

class _studentAttendanceRecordTileState
    extends State<studentAttendanceRecordTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<studentModel>(
        stream: studentDatabase().studentData(widget.record.studentId),
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
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text('Description'),
                                  ),
                                  content: Container(
                                      padding: const EdgeInsets.all(10.0),
                                      child: widget.record.description == ''
                                          ? const Text(
                                              'No description recorded.')
                                          : Text(widget.record.description)),
                                );
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xffF29180),
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
                                    child!.childName,
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        widget.record.attendanceStatus ==
                                                'present'
                                            ? const CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.check_circle,
                                                  color: Colors.green,
                                                  size: 30,
                                                ),
                                              )
                                            : const CircleAvatar(
                                                radius: 15,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                  size: 30,
                                                ),
                                              ),
                                      ],
                                    )),
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
