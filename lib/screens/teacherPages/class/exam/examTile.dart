import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/services/examDatabase.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class examTile extends StatefulWidget {
  const examTile({super.key, required this.examId});
  final String examId;

  @override
  State<examTile> createState() => _examTileState();
}

class _examTileState extends State<examTile> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return StreamBuilder<examModel>(
      stream: examDatabase().examData(widget.examId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          examModel? exam = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(exam!.examTitle),
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
                      child: Text(
                          convertTimeToDateWithStringMonth(exam.examStartDate)),
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
                      child: Text(
                          convertTimeToDateWithStringMonth(exam.examEndDate)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                      flex: 2,
                      child: exam.examStatus == 'inactive'
                          ? Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.yellow[800],
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          screenSize.width < 1700
                                              ? Container()
                                              : const Icon(
                                                  Icons.schedule,
                                                  color: Colors.white,
                                                ),
                                          screenSize.width < 1700
                                              ? Container()
                                              : const SizedBox(
                                                  width: 10,
                                                ),
                                          const Text(
                                            'Inactive',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        ],
                                      )),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                              ],
                            )
                          : exam.examStatus == 'ongoing'
                              ? Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.green[800],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child:  Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              screenSize.width < 1700
                                              ? Container()
                                              : const Icon(
                                                  Icons.check,
                                                  color: Colors.white,
                                                ),
                                          screenSize.width < 1700
                                              ? Container()
                                              : const SizedBox(
                                                  width: 10,
                                                ),
                                          const Text(
                                            'Ongoing',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                            ],
                                          )),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                  ],
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: Colors.red[800],
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              screenSize.width < 1700
                                              ? Container()
                                              : const Icon(
                                                  Icons.cancel,
                                                  color: Colors.white,
                                                ),
                                          screenSize.width < 1700
                                              ? Container()
                                              : const SizedBox(
                                                  width: 10,
                                                ),
                                          const Text(
                                            'Ended',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                            ],
                                          )),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(),
                                    ),
                                  ],
                                )),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_sharp),
                        onPressed: () {
                          String currentStatus = exam.examStatus;
                          if (DateTime.now().isAfter(
                                  convertTimeToDate(exam.examStartDate)) &&
                              DateTime.now().isBefore(
                                  convertTimeToDate(exam.examEndDate))) {
                            currentStatus = 'ongoing';
                          } else if (DateTime.now()
                              .isAfter(convertTimeToDate(exam.examEndDate))) {
                            currentStatus = 'ended';
                          } else {
                            currentStatus = 'inactive';
                          }
                          examDatabase().updateExamData(
                              exam.examId,
                              exam.academicCalendarId,
                              exam.examTitle,
                              exam.examStartDate,
                              exam.examEndDate,
                              currentStatus);
                          context.go(
                              '/teacher/class/${exam.academicCalendarId}/exam/${exam.examId}');
                        },
                      ),
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
  }
}
