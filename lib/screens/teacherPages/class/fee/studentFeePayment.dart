import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/feeModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/screens/teacherPages/class/fee/studentPaymentList.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/feeDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class studentFeePayment extends StatefulWidget {
  const studentFeePayment(
      {super.key, required this.academicCalendarId, required this.feeId});
  final String academicCalendarId;
  final String feeId;

  @override
  State<studentFeePayment> createState() => _studentFeePaymentState();
}

class _studentFeePaymentState extends State<studentFeePayment> {
  int toggleView = 1;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 1700) {
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
                      return StreamBuilder<feeModel>(
                          stream: feeDatabase().feeData(widget.feeId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              feeModel? fee = snapshot.data;
                              return Column(
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
                                                    '/teacher/class/${academicCalendar.academicCalendarId}');
                                              }),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text('>'),
                                      const SizedBox(width: 10),
                                      RichText(
                                        text: TextSpan(
                                            text: 'Fee Management',
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.underline),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                context.go(
                                                    '/teacher/class/${academicCalendar.academicCalendarId}/fee');
                                              }),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text('>'),
                                      const SizedBox(width: 10),
                                      RichText(
                                        text: TextSpan(
                                          text: fee!.feeTitle,
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
                                      'Fee : ${fee.feeTitle}',
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
                                    child: Text(
                                      'View and manage ${fee.feeTitle}\'s fee.',
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
                                  const SizedBox(height: 30),
                                  SizedBox(
                                    height: 400,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            height: double.maxFinite,
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    fee.feeTitle,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                const Text(
                                                  'Fee Amount',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                                Text('RM ${fee.feeAmount}'),
                                                const SizedBox(height: 10),
                                                const Text(
                                                  'Fee Description',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(fee.feeDescription),
                                                const SizedBox(height: 10),
                                                const Text(
                                                  'Fee Deadline',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(convertTimeToDateString(
                                                    fee.feeDeadline)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 80),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'Student\'s Payment Status',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30.0,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              ElevatedButton(
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: toggleView ==
                                                          1
                                                      ? const Color(0xff8290F0)
                                                      : Colors.white,
                                                  fixedSize:
                                                      const Size(230, 50),
                                                  alignment: Alignment.center,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      side: toggleView == 1
                                                          ? BorderSide.none
                                                          : const BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1)),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    toggleView = 1;
                                                  });
                                                },
                                                child: Text(
                                                  'Paid Students',
                                                  style: TextStyle(
                                                      color: toggleView == 1
                                                          ? Colors.white
                                                          : Colors.grey),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: toggleView ==
                                                          2
                                                      ? const Color(0xff8290F0)
                                                      : Colors.white,
                                                  fixedSize:
                                                      const Size(230, 50),
                                                  alignment: Alignment.center,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      side: toggleView == 2
                                                          ? BorderSide.none
                                                          : const BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1)),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    toggleView = 2;
                                                  });
                                                },
                                                child: Text(
                                                  'Pending Students',
                                                  style: TextStyle(
                                                      color: toggleView == 2
                                                          ? Colors.white
                                                          : Colors.grey),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: toggleView ==
                                                          3
                                                      ? const Color(0xff8290F0)
                                                      : Colors.white,
                                                  fixedSize:
                                                      const Size(230, 50),
                                                  alignment: Alignment.center,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      side: toggleView == 3
                                                          ? BorderSide.none
                                                          : const BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1)),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    toggleView = 3;
                                                  });
                                                },
                                                child: Text(
                                                  'Unpaid Students',
                                                  style: TextStyle(
                                                      color: toggleView == 3
                                                          ? Colors.white
                                                          : Colors.grey),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 50),
                                  toggleView == 1
                                      ? Column(
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 100,
                                                            maxWidth: 200),
                                                    child: const Text(
                                                      'Full Name',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.grey,
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
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 100,
                                                            maxWidth: 200),
                                                    child: const Text(
                                                      'Amount Paid (RM)',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.normal,
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
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 100,
                                                            maxWidth: 200),
                                                    child: const Text(
                                                      'Payment Date',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.normal,
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
                                                      alignment:
                                                          Alignment.center,
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: 100,
                                                              maxWidth: 200),
                                                      child: const Text(
                                                        'Fee Payment Status',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 30),
                                            StreamBuilder(
                                                stream: feeDatabase()
                                                    .allFeePaymentDataWithAcademicCalendarIdFeeIdAndPaymentStatus(
                                                        academicCalendar
                                                            .academicCalendarId,
                                                        fee.feeId,
                                                        'paid'),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return studentPaymentList(
                                                        feePaymentList:
                                                            snapshot.data);
                                                  } else {
                                                    return const Loading();
                                                  }
                                                }),
                                          ],
                                        )
                                      : toggleView == 2
                                          ? Column(
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: const Text(
                                                          'Full Name',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
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
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: const Text(
                                                          'Amount Paid (RM)',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
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
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: const Text(
                                                          'Payment Date',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
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
                                                          alignment:
                                                              Alignment.center,
                                                          constraints:
                                                              const BoxConstraints(
                                                                  minWidth: 100,
                                                                  maxWidth:
                                                                      200),
                                                          child: const Text(
                                                            'Fee Payment Status',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 15),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 30),
                                                StreamBuilder(
                                                    stream: feeDatabase()
                                                        .allFeePaymentDataWithAcademicCalendarIdFeeIdAndPaymentStatus(
                                                            fee
                                                                .academicCalendarId,
                                                            fee.feeId,
                                                            'pending'),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return studentPaymentList(
                                                            feePaymentList:
                                                                snapshot.data);
                                                      } else {
                                                        return const Loading();
                                                      }
                                                    }),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: const Text(
                                                          'Full Name',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
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
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: const Text(
                                                          'Student ID',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
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
                                                          alignment:
                                                              Alignment.center,
                                                          constraints:
                                                              const BoxConstraints(
                                                                  minWidth: 100,
                                                                  maxWidth:
                                                                      200),
                                                          child: const Text(
                                                            'Fee Payment Status',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 15),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 30),
                                                StreamBuilder(
                                                    stream: feeDatabase()
                                                        .allFeePaymentDataWithAcademicCalendarIdFeeIdAndPaymentStatus(
                                                            fee
                                                                .academicCalendarId,
                                                            fee.feeId,
                                                            'unpaid'),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return studentPaymentList(
                                                            feePaymentList:
                                                                snapshot.data);
                                                      } else {
                                                        return const Loading();
                                                      }
                                                    }),
                                              ],
                                            ),
                                  const SizedBox(height: 500),
                                ],
                              );
                            } else {
                              return const Loading();
                            }
                          });
                    } else {
                      return const Loading();
                    }
                  },
                ),
              ),
            );
          } else {
            return const Loading();
          }
        },
      );
    } else {
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
                      return StreamBuilder<feeModel>(
                          stream: feeDatabase().feeData(widget.feeId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              feeModel? fee = snapshot.data;
                              return Column(
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
                                                    '/teacher/class/${academicCalendar.academicCalendarId}');
                                              }),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text('>'),
                                      const SizedBox(width: 10),
                                      RichText(
                                        text: TextSpan(
                                            text: 'Fee Management',
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.underline),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                context.go(
                                                    '/teacher/class/${academicCalendar.academicCalendarId}/fee');
                                              }),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text('>'),
                                      const SizedBox(width: 10),
                                      RichText(
                                        text: TextSpan(
                                          text: fee!.feeTitle,
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
                                      'Fee : ${fee.feeTitle}',
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
                                    child: Text(
                                      'View and manage ${fee.feeTitle}\'s fee.',
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
                                  const SizedBox(height: 30),
                                  SizedBox(
                                    height: 400,
                                    width: double.maxFinite,
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            height: double.maxFinite,
                                            padding: const EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              border: Border.all(),
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
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    fee.feeTitle,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                                const SizedBox(height: 20),
                                                const Text(
                                                  'Fee Amount',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                                Text('RM ${fee.feeAmount}'),
                                                const SizedBox(height: 10),
                                                const Text(
                                                  'Fee Description',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(fee.feeDescription),
                                                const SizedBox(height: 10),
                                                const Text(
                                                  'Fee Deadline',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(convertTimeToDateString(
                                                    fee.feeDeadline)),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Container(),
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 80),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: const Text(
                                      'Student\'s Payment Status',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 30.0,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Row(
                                            children: <Widget>[
                                              ElevatedButton(
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: toggleView ==
                                                          1
                                                      ? const Color(0xff8290F0)
                                                      : Colors.white,
                                                  fixedSize:
                                                      const Size(230, 50),
                                                  alignment: Alignment.center,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      side: toggleView == 1
                                                          ? BorderSide.none
                                                          : const BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1)),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    toggleView = 1;
                                                  });
                                                },
                                                child: Text(
                                                  'Paid Students',
                                                  style: TextStyle(
                                                      color: toggleView == 1
                                                          ? Colors.white
                                                          : Colors.grey),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: toggleView ==
                                                          2
                                                      ? const Color(0xff8290F0)
                                                      : Colors.white,
                                                  fixedSize:
                                                      const Size(230, 50),
                                                  alignment: Alignment.center,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      side: toggleView == 2
                                                          ? BorderSide.none
                                                          : const BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1)),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    toggleView = 2;
                                                  });
                                                },
                                                child: Text(
                                                  'Pending Students',
                                                  style: TextStyle(
                                                      color: toggleView == 2
                                                          ? Colors.white
                                                          : Colors.grey),
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              ElevatedButton(
                                                style: OutlinedButton.styleFrom(
                                                  backgroundColor: toggleView ==
                                                          3
                                                      ? const Color(0xff8290F0)
                                                      : Colors.white,
                                                  fixedSize:
                                                      const Size(230, 50),
                                                  alignment: Alignment.center,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      side: toggleView == 3
                                                          ? BorderSide.none
                                                          : const BorderSide(
                                                              color:
                                                                  Colors.black,
                                                              width: 1)),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    toggleView = 3;
                                                  });
                                                },
                                                child: Text(
                                                  'Unpaid Students',
                                                  style: TextStyle(
                                                      color: toggleView == 3
                                                          ? Colors.white
                                                          : Colors.grey),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Container(),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 50),
                                  toggleView == 1
                                      ? Column(
                                          children: [
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 2,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 100,
                                                            maxWidth: 200),
                                                    child: const Text(
                                                      'Full Name',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.grey,
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
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 100,
                                                            maxWidth: 200),
                                                    child: const Text(
                                                      'Amount Paid (RM)',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.normal,
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
                                                    constraints:
                                                        const BoxConstraints(
                                                            minWidth: 100,
                                                            maxWidth: 200),
                                                    child: const Text(
                                                      'Payment Date',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.normal,
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
                                                      alignment:
                                                          Alignment.center,
                                                      constraints:
                                                          const BoxConstraints(
                                                              minWidth: 100,
                                                              maxWidth: 200),
                                                      child: const Text(
                                                        'Fee Payment Status',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontSize: 15),
                                                      )),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 30),
                                            StreamBuilder(
                                                stream: feeDatabase()
                                                    .allFeePaymentDataWithAcademicCalendarIdFeeIdAndPaymentStatus(
                                                        academicCalendar
                                                            .academicCalendarId,
                                                        fee.feeId,
                                                        'paid'),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return studentPaymentList(
                                                        feePaymentList:
                                                            snapshot.data);
                                                  } else {
                                                    return const Loading();
                                                  }
                                                }),
                                          ],
                                        )
                                      : toggleView == 2
                                          ? Column(
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: const Text(
                                                          'Full Name',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
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
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: const Text(
                                                          'Amount Paid (RM)',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
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
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: const Text(
                                                          'Payment Date',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
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
                                                          alignment:
                                                              Alignment.center,
                                                          constraints:
                                                              const BoxConstraints(
                                                                  minWidth: 100,
                                                                  maxWidth:
                                                                      200),
                                                          child: const Text(
                                                            'Fee Payment Status',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 15),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 30),
                                                StreamBuilder(
                                                    stream: feeDatabase()
                                                        .allFeePaymentDataWithAcademicCalendarIdFeeIdAndPaymentStatus(
                                                            fee
                                                                .academicCalendarId,
                                                            fee.feeId,
                                                            'pending'),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return studentPaymentList(
                                                            feePaymentList:
                                                                snapshot.data);
                                                      } else {
                                                        return const Loading();
                                                      }
                                                    }),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 2,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: const Text(
                                                          'Full Name',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
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
                                                        alignment:
                                                            Alignment.center,
                                                        constraints:
                                                            const BoxConstraints(
                                                                minWidth: 100,
                                                                maxWidth: 200),
                                                        child: const Text(
                                                          'Student ID',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
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
                                                          alignment:
                                                              Alignment.center,
                                                          constraints:
                                                              const BoxConstraints(
                                                                  minWidth: 100,
                                                                  maxWidth:
                                                                      200),
                                                          child: const Text(
                                                            'Fee Payment Status',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.grey,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontSize: 15),
                                                          )),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 30),
                                                StreamBuilder(
                                                    stream: feeDatabase()
                                                        .allFeePaymentDataWithAcademicCalendarIdFeeIdAndPaymentStatus(
                                                            fee
                                                                .academicCalendarId,
                                                            fee.feeId,
                                                            'unpaid'),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return studentPaymentList(
                                                            feePaymentList:
                                                                snapshot.data);
                                                      } else {
                                                        return const Loading();
                                                      }
                                                    }),
                                              ],
                                            ),
                                  const SizedBox(height: 500),
                                ],
                              );
                            } else {
                              return const Loading();
                            }
                          });
                    } else {
                      return const Loading();
                    }
                  },
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
}
