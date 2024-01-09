import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/screens/teacherPages/class/exam/examList.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/examDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/shared/loading.dart';

class examMain extends StatefulWidget {
  const examMain({super.key, required this.academicCalendarId});
  final String academicCalendarId;

  @override
  State<examMain> createState() => _examMainState();
}

class _examMainState extends State<examMain> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
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
                  stream: schoolDatabase().classData(academicCalendar!.classId),
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
                                text: const TextSpan(
                                  text: 'Examination',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${classDetail.classYear} : ${classDetail.className} \'s Examination',
                              style: const TextStyle(
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
                              'Record, view and manage class examination.',
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
                          Container(
                            alignment: Alignment.topLeft,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.payment,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xffF29180),
                                fixedSize: const Size(250, 50),
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                              ),
                              onPressed: () {
                                context.go(
                                    '/teacher/class/${academicCalendar.academicCalendarId}/exam/addnewexam');
                              },
                              label: const Text(
                                'Add New Examination',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  child:  const Text(
                                    'Exam Title',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
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
                                  child:  const Text(
                                    'Start Date',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
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
                                  child:  const Text(
                                    'End Date',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
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
                                  child:  const Text(
                                    'Status',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          StreamBuilder<List<examModel>>(
                              stream: examDatabase()
                                  .allExamDataWithAcademicCalendarId(
                                      academicCalendar.academicCalendarId),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return examList(examModelList: snapshot.data);
                                } else {
                                  return const Loading();
                                }
                              })
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
