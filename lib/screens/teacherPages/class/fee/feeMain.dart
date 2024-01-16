import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/feeModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/screens/teacherPages/class/fee/feeGrid.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/feeDatabase.dart';
import 'package:ummicare/services/notificationDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class feeMain extends StatefulWidget {
  const feeMain({super.key, required this.academicCalendarId});
  final String academicCalendarId;

  @override
  State<feeMain> createState() => _feeMainState();
}

class _feeMainState extends State<feeMain> {
  @override
  Widget build(BuildContext context) {
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
                                  text: 'Fee Management',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '${classDetail.classYear} : ${classDetail.className} \'s Fee Management',
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
                              'Record, view and manage class fee.',
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
                                fixedSize: const Size(200, 50),
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      final _formKey = GlobalKey<FormState>();

                                      String feeTitle = '';
                                      String feeAmount = '';
                                      String feeDescription = '';
                                      DateTime feeDeadline = DateTime.now();
                                      return StreamBuilder<List<studentModel>>(
                                          stream: studentDatabase()
                                              .allStudentWithAcademicCalendarAndStatus(
                                                  academicCalendar
                                                      .academicCalendarId,
                                                  'active'),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              List<studentModel>? studentList =
                                                  snapshot.data;
                                              return StreamBuilder<
                                                      List<childModel>>(
                                                  stream:
                                                      childDatabase(childId: '')
                                                          .allChild,
                                                  builder: (context, snapshot) {
                                                    if (snapshot.hasData) {
                                                      List<childModel>? childs =
                                                          snapshot.data;
                                                      return StreamBuilder<
                                                              List<
                                                                  parentModel>>(
                                                          stream: parentDatabase(
                                                                  parentId: '')
                                                              .allParentData,
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              List<parentModel>?
                                                                  parents =
                                                                  snapshot.data;
                                                              List<parentModel>
                                                                  finalListParent =
                                                                  [];
                                                              List<childModel>
                                                                  finalListChild =
                                                                  [];
                                                              for (int i = 0;
                                                                  i <
                                                                      studentList!
                                                                          .length;
                                                                  i++) {
                                                                for (int j = 0;
                                                                    j <
                                                                        childs!
                                                                            .length;
                                                                    j++) {
                                                                  if (childs[j]
                                                                          .childId ==
                                                                      studentList[
                                                                              i]
                                                                          .childId) {
                                                                    for (int k =
                                                                            0;
                                                                        k < parents!.length;
                                                                        k++) {
                                                                      if (parents[k]
                                                                              .parentId ==
                                                                          childs[j]
                                                                              .parentId) {
                                                                        finalListParent
                                                                            .add(parents[k]);
                                                                        finalListChild
                                                                            .add(childs[j]);
                                                                      }
                                                                    }
                                                                  }
                                                                }
                                                              }
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
                                                                        child: Text(
                                                                            'Add New Fee'),
                                                                      ),
                                                                      content:
                                                                          SizedBox(
                                                                        width:
                                                                            500,
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              10.0),
                                                                          child:
                                                                              Column(
                                                                            children: <Widget>[
                                                                              Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                padding: const EdgeInsets.only(left: 20.0),
                                                                                child: const Text(
                                                                                  'Fee Title',
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 15.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 5.0,
                                                                              ),
                                                                              TextFormField(
                                                                                initialValue: feeTitle,
                                                                                decoration: textInputDecoration.copyWith(hintText: 'Title'),
                                                                                validator: (value) => value == '' ? 'Please enter fee title' : null,
                                                                                onChanged: (value) => setState(() => feeTitle = value),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 20.0,
                                                                              ),
                                                                              Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                padding: const EdgeInsets.only(left: 20.0),
                                                                                child: const Text(
                                                                                  'Fee Amount',
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 15.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 5.0,
                                                                              ),
                                                                              TextFormField(
                                                                                initialValue: feeAmount,
                                                                                decoration: textInputDecoration.copyWith(hintText: 'RM'),
                                                                                inputFormatters: <TextInputFormatter>[
                                                                                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                                                                                  // CurrencyInputFormatter(
                                                                                  //   leadingSymbol: 'RM',
                                                                                  //   useSymbolPadding: true
                                                                                  // )
                                                                                ],
                                                                                validator: (value) => value == '' ? 'Please enter fee amount' : null,
                                                                                onChanged: (value) => setState(() => feeAmount = value),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 20.0,
                                                                              ),
                                                                              Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                padding: const EdgeInsets.only(left: 20.0),
                                                                                child: const Text(
                                                                                  'Fee Description',
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 15.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 5.0,
                                                                              ),
                                                                              TextFormField(
                                                                                initialValue: feeDescription,
                                                                                decoration: textInputDecoration.copyWith(hintText: 'Description'),
                                                                                maxLines: 5,
                                                                                minLines: 1,
                                                                                maxLength: 200,
                                                                                validator: (value) => value == '' ? 'Please enter fee description' : null,
                                                                                onChanged: (value) => setState(() => feeDescription = value),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 20.0,
                                                                              ),
                                                                              Container(
                                                                                alignment: Alignment.centerLeft,
                                                                                padding: const EdgeInsets.only(left: 20.0),
                                                                                child: const Text(
                                                                                  'Fee Deadline',
                                                                                  textAlign: TextAlign.left,
                                                                                  style: TextStyle(
                                                                                    fontSize: 15.0,
                                                                                    fontWeight: FontWeight.bold,
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              const SizedBox(
                                                                                height: 20.0,
                                                                              ),
                                                                              Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  children: <Widget>[
                                                                                    Column(
                                                                                      children: [
                                                                                        const Text(
                                                                                          'Day',
                                                                                          style: TextStyle(color: Colors.grey),
                                                                                        ),
                                                                                        const SizedBox(height: 5),
                                                                                        Text(
                                                                                          feeDeadline.day.toString(),
                                                                                          style: const TextStyle(fontSize: 20.0),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    const SizedBox(width: 10),
                                                                                    const Text(
                                                                                      ' / ',
                                                                                      style: TextStyle(fontSize: 20),
                                                                                    ),
                                                                                    const SizedBox(width: 10),
                                                                                    Column(
                                                                                      children: [
                                                                                        const Text(
                                                                                          'Month',
                                                                                          style: TextStyle(color: Colors.grey),
                                                                                        ),
                                                                                        const SizedBox(height: 5),
                                                                                        Text(
                                                                                          feeDeadline.month.toString(),
                                                                                          style: const TextStyle(fontSize: 20.0),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    const SizedBox(width: 10),
                                                                                    const Text(
                                                                                      ' / ',
                                                                                      style: TextStyle(fontSize: 20),
                                                                                    ),
                                                                                    const SizedBox(width: 10),
                                                                                    Column(
                                                                                      children: [
                                                                                        const Text(
                                                                                          'Year',
                                                                                          style: TextStyle(color: Colors.grey),
                                                                                        ),
                                                                                        const SizedBox(height: 5),
                                                                                        Text(
                                                                                          feeDeadline.year.toString(),
                                                                                          style: const TextStyle(fontSize: 20.0),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    const SizedBox(width: 20),
                                                                                    IconButton(
                                                                                      icon: Icon(
                                                                                        Icons.edit,
                                                                                        color: Colors.grey[800],
                                                                                      ),
                                                                                      onPressed: () {
                                                                                        showDatePicker(
                                                                                          context: context,
                                                                                          initialDate: feeDeadline,
                                                                                          firstDate: convertTimeToDate(academicCalendar.academicCalendarStartDate).add(const Duration(days: 1)),
                                                                                          lastDate: convertTimeToDate(academicCalendar.academicCalendarEndDate),
                                                                                        ).then((date) {
                                                                                          stfSetState(() {
                                                                                            feeDeadline = date!;
                                                                                          });
                                                                                        });
                                                                                      },
                                                                                    ),
                                                                                    const SizedBox(width: 20),
                                                                                  ],
                                                                                ),
                                                                              ]),
                                                                              const SizedBox(
                                                                                height: 20.0,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      actions: [
                                                                        ElevatedButton(
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                const Color(0xffF29180),
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child: const Text(
                                                                              "Cancel",
                                                                              style: TextStyle(color: Colors.white)),
                                                                        ),
                                                                        ElevatedButton(
                                                                          style:
                                                                              ElevatedButton.styleFrom(
                                                                            backgroundColor:
                                                                                const Color(0xff8290F0),
                                                                            shape:
                                                                                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            final document =
                                                                                FirebaseFirestore.instance.collection('Fee').doc();
                                                                            if (_formKey.currentState!.validate()) {
                                                                              feeDatabase().updateFeeData(document.id, academicCalendar.academicCalendarId, feeTitle, feeAmount, feeDescription, feeDeadline.millisecondsSinceEpoch.toString());
                                                                            }
                                                                            for (var i = 0;
                                                                                i < studentList.length;
                                                                                i++) {
                                                                              print(studentList[i].studentId);
                                                                              feeDatabase().createFeePaymentData(document.id, studentList[i].studentId, academicCalendar.academicCalendarId, '0.00', 'unpaid', DateTime.now().millisecondsSinceEpoch.toString(), '');
                                                                            }
                                                                            for (int i = 0;
                                                                                i < finalListParent.length;
                                                                                i++) {
                                                                              notificationDatabase().createNotificationData(finalListParent[i].parentId, finalListChild[i].childId, 'education', 'New Fee Added (${classDetail.className} ${classDetail.classYear}): $feeTitle', 'New fee: ${feeTitle} of RM${feeAmount} has been added to ${finalListChild[i].childFirstname}\' class.', 'unseen', DateTime.now().millisecondsSinceEpoch.toString());
                                                                            }
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child: const Text(
                                                                              "Confirm",
                                                                              style: TextStyle(color: Colors.white)),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
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
                                              return Loading();
                                            }
                                          });
                                    });
                              },
                              label: const Text(
                                'Add New Fee',
                                style: TextStyle(
                                    fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 50),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: StreamBuilder<List<feeModel>>(
                                  stream: feeDatabase()
                                      .allFeeDataWithAcademicCalendarId(
                                          academicCalendar.academicCalendarId),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return feeGrid(feeList: snapshot.data);
                                    } else {
                                      return const Loading();
                                    }
                                  },
                                ),
                              ),
                              Expanded(child: Container())
                            ],
                          )
                        ],
                      );
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
