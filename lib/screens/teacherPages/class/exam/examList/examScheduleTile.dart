import 'package:flutter/material.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/models/scheduleModel.dart';
import 'package:ummicare/services/examDatabase.dart';
import 'package:ummicare/services/scheduleDatabase.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class examScheduleTile extends StatefulWidget {
  const examScheduleTile({super.key, required this.examScheduleId});
  final String examScheduleId;

  @override
  State<examScheduleTile> createState() => _examScheduleTileState();
}

class _examScheduleTileState extends State<examScheduleTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<academicCalendarScheduleModel>(
      stream: scheduleDatabase().scheduleData(widget.examScheduleId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          academicCalendarScheduleModel? examSchedule = snapshot.data;
          return StreamBuilder<examModel>(
              stream: examDatabase().examData(examSchedule!.eventId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  examModel? exam = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(1)),
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.center,
                              constraints: const BoxConstraints(
                                  minWidth: 100, maxWidth: 200),
                              child: Text(
                                examSchedule.title,
                                softWrap: false,
                                maxLines: 1,
                                overflow: TextOverflow.fade,
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
                                convertTimeToDateWithStringMonth(
                                    examSchedule.date),
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
                                getTimeFormatWithDateTime(examSchedule.from),
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
                                getTimeFormatWithDateTime(examSchedule.to),
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
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.grey[800],
                                ),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        final _formKey = GlobalKey<FormState>();

                                        DateTime _currentDate =
                                            convertTimeToDate(
                                                examSchedule.date);
                                        TimeOfDay _currentFrom =
                                            convertDateTimeToTimeofDay(
                                                examSchedule.from);
                                        TimeOfDay _currentTo =
                                            convertDateTimeToTimeofDay(
                                                examSchedule.to);

                                        return Form(
                                          key: _formKey,
                                          child: StatefulBuilder(builder:
                                              (stfContext, stfSetState) {
                                            return AlertDialog(
                                              scrollable: true,
                                              title: const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 30,
                                                    vertical: 20),
                                                child: Text(
                                                    'Set Exam Date and Time'),
                                              ),
                                              content: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 30,
                                                        vertical: 20),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: const Text(
                                                        'Exam Date',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Column(
                                                            children: [
                                                              const Text(
                                                                'Day',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              Text(
                                                                _currentDate.day
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20.0),
                                                              ),
                                                            ],
                                                          ),
                                                          const Text(
                                                            ' / ',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          Column(
                                                            children: [
                                                              const Text(
                                                                'Month',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              Text(
                                                                _currentDate
                                                                    .month
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20.0),
                                                              ),
                                                            ],
                                                          ),
                                                          const Text(
                                                            ' / ',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                          Column(
                                                            children: [
                                                              const Text(
                                                                'Year',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey),
                                                              ),
                                                              const SizedBox(
                                                                  height: 5),
                                                              Text(
                                                                _currentDate
                                                                    .year
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        20.0),
                                                              ),
                                                            ],
                                                          ),
                                                          IconButton(
                                                            icon: Icon(
                                                              Icons.edit,
                                                              color: Colors
                                                                  .grey[800],
                                                            ),
                                                            onPressed: () {
                                                              showDatePicker(
                                                                context:
                                                                    context,
                                                                initialDate:
                                                                    _currentDate,
                                                                firstDate:
                                                                    convertTimeToDate(
                                                                        exam!
                                                                            .examStartDate),
                                                                lastDate:
                                                                    convertTimeToDate(
                                                                        exam.examEndDate),
                                                              ).then((date) {
                                                                stfSetState(() {
                                                                  _currentDate =
                                                                      date!;
                                                                });
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 40.0,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: const Text(
                                                        'Start Time',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Text(getTimeFormat(
                                                              convertTimeOfDayToDateTime(
                                                                      _currentFrom,
                                                                      _currentDate)
                                                                  .millisecondsSinceEpoch
                                                                  .toString())),
                                                          IconButton(
                                                            icon: Icon(
                                                              Icons.edit,
                                                              color: Colors
                                                                  .grey[800],
                                                            ),
                                                            onPressed: () {
                                                              showTimePicker(
                                                                context:
                                                                    context,
                                                                initialTime:
                                                                    _currentFrom,
                                                              ).then((date) {
                                                                stfSetState(() {
                                                                  _currentFrom =
                                                                      date!;
                                                                });
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 40.0,
                                                    ),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: const Text(
                                                        'End Time',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: <Widget>[
                                                          Text(getTimeFormat(
                                                              convertTimeOfDayToDateTime(
                                                                      _currentTo,
                                                                      _currentDate)
                                                                  .millisecondsSinceEpoch
                                                                  .toString())),
                                                          IconButton(
                                                            icon: Icon(
                                                              Icons.edit,
                                                              color: Colors
                                                                  .grey[800],
                                                            ),
                                                            onPressed: () {
                                                              showTimePicker(
                                                                context:
                                                                    context,
                                                                initialTime:
                                                                    _currentTo,
                                                              ).then((date) {
                                                                stfSetState(() {
                                                                  _currentTo =
                                                                      date!;
                                                                });
                                                              });
                                                            },
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 40.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xffF29180),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Cancel",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xff8290F0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                  ),
                                                  onPressed: () {
                                                    scheduleDatabase()
                                                        .updateAcademicCalendarScheduleData(
                                                            examSchedule.academicCalendarScheduleId,
                                                            examSchedule.title,
                                                            _currentDate.millisecondsSinceEpoch.toString(),
                                                            convertTimeOfDayToDateTime(_currentFrom, _currentDate).millisecondsSinceEpoch.toString(),
                                                            convertTimeOfDayToDateTime(_currentTo, _currentDate).millisecondsSinceEpoch.toString(),
                                                            examSchedule.academicCalendarId,
                                                            examSchedule.eventId,
                                                            examSchedule.type);
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text("Confirm",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ),
                                              ],
                                            );
                                          }),
                                        );
                                      });
                                },
                              )),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Loading();
                }
              });
        } else {
          return const Loading();
        }
      },
    );
  }
}
