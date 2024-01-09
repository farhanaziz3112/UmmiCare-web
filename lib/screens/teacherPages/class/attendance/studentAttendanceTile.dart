import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/studentAttendanceDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class studentAttendanceTile extends StatefulWidget {
  const studentAttendanceTile({super.key, required this.student});
  final studentModel student;

  @override
  State<studentAttendanceTile> createState() => _studentAttendanceTileState();
}

class _studentAttendanceTileState extends State<studentAttendanceTile> {
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
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
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
                            StreamBuilder<List<studentAttendanceModel>>(
                                stream: studentAttendanceDatabase()
                                    .allStudentAttendanceWithStudentIdAndSpecificDate(
                                        student.studentId,
                                        DateTime.now().day.toString(),
                                        DateTime.now().month.toString(),
                                        DateTime.now().year.toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<studentAttendanceModel>? attendance =
                                        snapshot.data;
                                    if (attendance!.isEmpty) {
                                      return Expanded(
                                        flex: 2,
                                        child: Container(
                                          alignment: Alignment.center,
                                          constraints: const BoxConstraints(
                                              minWidth: 100, maxWidth: 200),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                onPressed: () {
                                                  studentAttendanceDatabase()
                                                      .createStudentAttendanceData(
                                                          student.studentId,
                                                          student
                                                              .academicCalendarId,
                                                          DateTime.now()
                                                              .day
                                                              .toString(),
                                                          DateTime.now()
                                                              .month
                                                              .toString(),
                                                          DateTime.now()
                                                              .year
                                                              .toString(),
                                                          DateTime.now()
                                                              .millisecondsSinceEpoch
                                                              .toString(),
                                                          'present',
                                                          '');
                                                },
                                                icon: const Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                ),
                                                label: const Text("Present",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                              const SizedBox(width: 10),
                                              ElevatedButton.icon(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                onPressed: () {
                                                  final _formKey =
                                                      GlobalKey<FormState>();
                                                  String reason = '';
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Form(
                                                          key: _formKey,
                                                          child: AlertDialog(
                                                            scrollable: true,
                                                            title:
                                                                const Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(
                                                                          10.0),
                                                              child: Text(
                                                                  'Absent Reason'),
                                                            ),
                                                            content: SizedBox(
                                                              width: 600,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Text(
                                                                        'Please insert reason on the student absent. You are allow to leave it blank.'),
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    TextFormField(
                                                                      maxLines:
                                                                          5,
                                                                      minLines:
                                                                          1,
                                                                      initialValue:
                                                                          reason,
                                                                      decoration:
                                                                          textInputDecoration,
                                                                      onChanged:
                                                                          (value) =>
                                                                              setState(() => reason = value),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            actions: [
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xffF29180),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                child: const Text(
                                                                    "Cancel",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xff8290F0),
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                ),
                                                                onPressed: () {
                                                                  studentAttendanceDatabase().createStudentAttendanceData(
                                                                      student
                                                                          .studentId,
                                                                      student
                                                                          .academicCalendarId,
                                                                      DateTime.now()
                                                                          .day
                                                                          .toString(),
                                                                      DateTime.now()
                                                                          .month
                                                                          .toString(),
                                                                      DateTime.now()
                                                                          .year
                                                                          .toString(),
                                                                      DateTime.now()
                                                                          .millisecondsSinceEpoch
                                                                          .toString(),
                                                                      'absent',
                                                                      reason);
                                                                  Navigator.of(
                                                                      context)
                                                                    ..pop();
                                                                },
                                                                child: const Text(
                                                                    "Confirm",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      });
                                                },
                                                icon: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                ),
                                                label: const Text("Absent",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return Expanded(
                                        flex: 2,
                                        child: Container(
                                            alignment: Alignment.center,
                                            constraints: const BoxConstraints(
                                                minWidth: 100, maxWidth: 200),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                attendance.first
                                                            .attendanceStatus ==
                                                        'present'
                                                    ? const CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green,
                                                          size: 30,
                                                        ),
                                                      )
                                                    : const CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Icon(
                                                          Icons.cancel,
                                                          color: Colors.red,
                                                          size: 30,
                                                        ),
                                                      ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.edit,
                                                    color: Colors.grey[200],
                                                  ),
                                                  onPressed: () {
                                                    final _formKey =
                                                        GlobalKey<FormState>();
                                                    String reason = attendance.first.description;
                                                    String status = attendance.first.attendanceStatus;
                                                    showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return Form(
                                                            key: _formKey,
                                                            child: AlertDialog(
                                                              scrollable: true,
                                                              title:
                                                                  const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10.0),
                                                                child: Text(
                                                                    'Edit Attendance'),
                                                              ),
                                                              content: SizedBox(
                                                                width: 600,
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          10),
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.center,
                                                                        child:
                                                                            ToggleSwitch(
                                                                          minWidth:
                                                                              90.0,
                                                                          cornerRadius:
                                                                              20.0,
                                                                          activeBgColors: [
                                                                            [
                                                                              Colors.green[800]!
                                                                            ],
                                                                            [
                                                                              Colors.red[800]!
                                                                            ]
                                                                          ],
                                                                          activeFgColor:
                                                                              Colors.white,
                                                                          inactiveBgColor:
                                                                              Colors.grey,
                                                                          inactiveFgColor:
                                                                              Colors.white,
                                                                          initialLabelIndex: status == 'present'
                                                                              ? 0
                                                                              : 1,
                                                                          totalSwitches:
                                                                              2,
                                                                          labels: const [
                                                                            'present',
                                                                            'absent'
                                                                          ],
                                                                          radiusStyle:
                                                                              true,
                                                                          onToggle:
                                                                              (index) {
                                                                            index == 0 ? status = 'present' : status = 'absent';
                                                                          },
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              20),
                                                                      const Text(
                                                                          'If the student is absent, please insert the reason below. You are allow to leave it blank.'),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      TextFormField(
                                                                        maxLines:
                                                                            5,
                                                                        minLines:
                                                                            1,
                                                                        initialValue:
                                                                            reason,
                                                                        decoration:
                                                                            textInputDecoration,
                                                                        onChanged:
                                                                            (value) =>
                                                                                setState(() => reason = value),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              actions: [
                                                                ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        const Color(
                                                                            0xffF29180),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: const Text(
                                                                      "Cancel",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                ),
                                                                ElevatedButton(
                                                                  style: ElevatedButton
                                                                      .styleFrom(
                                                                    backgroundColor:
                                                                        const Color(
                                                                            0xff8290F0),
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    studentAttendanceDatabase().updateStudentAttendanceData(
                                                                        attendance.first.studentAttendanceId,
                                                                        student
                                                                            .studentId,
                                                                        student
                                                                            .academicCalendarId,
                                                                        DateTime.now()
                                                                            .day
                                                                            .toString(),
                                                                        DateTime.now()
                                                                            .month
                                                                            .toString(),
                                                                        DateTime.now()
                                                                            .year
                                                                            .toString(),
                                                                        DateTime.now()
                                                                            .millisecondsSinceEpoch
                                                                            .toString(),
                                                                        status,
                                                                        reason);
                                                                    Navigator.of(
                                                                        context)
                                                                      .pop();
                                                                  },
                                                                  child: const Text(
                                                                      "Confirm",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white)),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  },
                                                )
                                              ],
                                            )),
                                      );
                                    }
                                  } else {
                                    return Container();
                                  }
                                }),
                          ],
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
