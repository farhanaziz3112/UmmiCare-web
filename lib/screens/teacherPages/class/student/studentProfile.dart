import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/screens/charts/childExaminationProgress.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentAttendanceDatabase.dart';
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
  DateTime _recordDate = DateTime.now().subtract(const Duration(days: 1));
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 1300) {
      return StreamBuilder<studentModel>(
        stream: studentDatabase().studentData(widget.studentId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            studentModel? student = snapshot.data;
            return StreamBuilder<academicCalendarModel>(
                stream: academicCalendarDatabase()
                    .academicCalendarData(student!.academicCalendarId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    academicCalendarModel? academicCalendar = snapshot.data;
                    return Container(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        child: StreamBuilder<classModel>(
                            stream: schoolDatabase().classData(student.classId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                classModel? classDetail = snapshot.data;
                                return StreamBuilder<childModel>(
                                    stream:
                                        childDatabase(childId: student.childId)
                                            .childData,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        childModel? child = snapshot.data;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                RichText(
                                                  text: TextSpan(
                                                      text: 'Class',
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              context.go(
                                                                  '/teacher/class');
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
                                                              TextDecoration
                                                                  .underline),
                                                      recognizer:
                                                          TapGestureRecognizer()
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
                                                              TextDecoration
                                                                  .underline),
                                                      recognizer:
                                                          TapGestureRecognizer()
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
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Container(
                                                height: 1.0,
                                                width: double.infinity,
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                            const SizedBox(height: 50),
                                            SizedBox(
                                              height: 350,
                                              width: double.maxFinite,
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 40,
                                                          vertical: 30),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    10)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 5,
                                                            offset: const Offset(
                                                                0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment
                                                                .topCenter,
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
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      'First Name',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      'Last Name',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      'Age',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      'Birthday',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      'Parent',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
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
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      ': ${child.childFirstname}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      ': ${child.childLastname}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      ': ${child.childCurrentAge}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      ': ${convertTimeToDateString(child.childBirthday)}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    StreamBuilder<
                                                                            parentModel>(
                                                                        stream: parentDatabase(parentId: child.parentId)
                                                                            .parentData,
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            return Text(
                                                                              ': ${snapshot.data!.parentFullName} (${snapshot.data!.parentPhoneNumber})',
                                                                              style: const TextStyle(fontSize: 15),
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
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                            SizedBox(
                                              height: 350,
                                              width: double.maxFinite,
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 40,
                                                          vertical: 30),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    10)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 5,
                                                            offset: const Offset(
                                                                0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child: const Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .fact_check,
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
                                                          Expanded(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: const Text(
                                                                'Choose month and year below:',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: <Widget>[
                                                                  Column(
                                                                    children: [
                                                                      const Text(
                                                                        'Month',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              5),
                                                                      Text(
                                                                        _recordDate
                                                                            .month
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                20.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  const Text(
                                                                    ' / ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  Column(
                                                                    children: [
                                                                      const Text(
                                                                        'Year',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              5),
                                                                      Text(
                                                                        _recordDate
                                                                            .year
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                20.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  IconButton(
                                                                    icon: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color: Colors
                                                                              .grey[
                                                                          800],
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      showMonthPicker(
                                                                        context:
                                                                            context,
                                                                        initialDate:
                                                                            _recordDate,
                                                                        firstDate:
                                                                            convertTimeToDate(academicCalendar!.academicCalendarStartDate),
                                                                        lastDate:
                                                                            DateTime.now().subtract(const Duration(days: 1)),
                                                                      ).then(
                                                                          (date) {
                                                                        setState(
                                                                            () {
                                                                          _recordDate =
                                                                              date!;
                                                                        });
                                                                      });
                                                                    },
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          20),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          const Color(
                                                                              0xff8290F0),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return StreamBuilder<List<studentAttendanceModel>>(
                                                                                stream: studentAttendanceDatabase().allStudentAttendanceWithStudentIdAcademicCalendarIdAndSpecificMonth(student.studentId, academicCalendar!.academicCalendarId, _recordDate.month.toString(), _recordDate.year.toString()),
                                                                                builder: (context, snapshot) {
                                                                                  if (snapshot.hasData) {
                                                                                    List<studentAttendanceModel>? attendanceList = snapshot.data;
                                                                                    return AlertDialog(
                                                                                      title: Padding(
                                                                                        padding: const EdgeInsets.all(10.0),
                                                                                        child: Text('Attendance Record : ${monthToString(_recordDate.month)} ${_recordDate.year}'),
                                                                                      ),
                                                                                      content: SizedBox(
                                                                                        width: 800,
                                                                                        child: Column(
                                                                                          children: [
                                                                                            Row(
                                                                                              children: [
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(
                                                                                                    alignment: Alignment.center,
                                                                                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Colors.white,
                                                                                                      border: Border.all(),
                                                                                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          color: Colors.grey.withOpacity(0.5),
                                                                                                          spreadRadius: 1,
                                                                                                          blurRadius: 5,
                                                                                                          offset: const Offset(0, 3), // changes position of shadow
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    child: Row(
                                                                                                      children: <Widget>[
                                                                                                        const Expanded(flex: 1, child: Icon(Icons.info)),
                                                                                                        Expanded(
                                                                                                          flex: 4,
                                                                                                          child: Container(
                                                                                                            child: const Text(
                                                                                                              'Press the student card below to view attendance description.',
                                                                                                              textAlign: TextAlign.start,
                                                                                                              style: TextStyle(fontSize: 15),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                            const SizedBox(height: 30),
                                                                                            Row(
                                                                                              children: <Widget>[
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(
                                                                                                    alignment: Alignment.center,
                                                                                                    constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                                                                                                    child: const Text(
                                                                                                      'Date',
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: TextStyle(color: Colors.grey, fontSize: 15),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(
                                                                                                      alignment: Alignment.center,
                                                                                                      constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                                                                                                      child: const Text(
                                                                                                        'Attendance Status',
                                                                                                        textAlign: TextAlign.center,
                                                                                                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 15),
                                                                                                      )),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            const SizedBox(height: 10),
                                                                                            ListView.builder(
                                                                                              shrinkWrap: true,
                                                                                              itemCount: attendanceList!.length,
                                                                                              itemBuilder: ((context, index) {
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
                                                                                                              content: Container(padding: const EdgeInsets.all(10.0), child: attendanceList[index].description == '' ? const Text('No description recorded.') : Text(attendanceList[index].description)),
                                                                                                            );
                                                                                                          });
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Colors.white,
                                                                                                        borderRadius: const BorderRadius.all(Radius.circular(2)),
                                                                                                        boxShadow: [
                                                                                                          BoxShadow(
                                                                                                            color: Colors.grey.withOpacity(0.5),
                                                                                                            spreadRadius: 1,
                                                                                                            blurRadius: 5,
                                                                                                            offset: const Offset(0, 3), // changes position of shadow
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      child: Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                                        children: <Widget>[
                                                                                                          Expanded(
                                                                                                            flex: 1,
                                                                                                            child: Container(),
                                                                                                          ),
                                                                                                          Expanded(
                                                                                                            flex: 1,
                                                                                                            child: Container(
                                                                                                              alignment: Alignment.center,
                                                                                                              constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                                                                                                              child: Text(
                                                                                                                '${attendanceList[index].attendanceDateDay}/${attendanceList[index].attendanceDateMonth}/${attendanceList[index].attendanceDateYear}',
                                                                                                                textAlign: TextAlign.center,
                                                                                                                style: const TextStyle(color: Colors.black, fontSize: 15),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Expanded(
                                                                                                            flex: 1,
                                                                                                            child: Container(),
                                                                                                          ),
                                                                                                          Expanded(
                                                                                                            flex: 1,
                                                                                                            child: Container(
                                                                                                                alignment: Alignment.center,
                                                                                                                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                                                                                                                child: Row(
                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                  children: <Widget>[
                                                                                                                    attendanceList[index].attendanceStatus == 'present'
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
                                                                                                          Expanded(
                                                                                                            flex: 1,
                                                                                                            child: Container(),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                                ;
                                                                                              }),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  } else {
                                                                                    return Container();
                                                                                  }
                                                                                });
                                                                          });
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'View Record',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                          Expanded(
                                                            child: Container(),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 50),
                                            Container(
                                              alignment: Alignment.topCenter,
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.edit_note,
                                                    size: 35,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Examination Progress',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20.0,
                                                        fontFamily: 'Comfortaa',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            SizedBox(
                                              height: 400,
                                              child: childExaminationProgress(
                                                  studentId: student.studentId,
                                                  academicCalendarId: student
                                                      .academicCalendarId),
                                            ),
                                            const SizedBox(
                                              height: 100,
                                            ),
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
                    return Container();
                  }
                });
          } else {
            return const Loading();
          }
        },
      );
    } else {
      return StreamBuilder<studentModel>(
        stream: studentDatabase().studentData(widget.studentId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            studentModel? student = snapshot.data;
            return StreamBuilder<academicCalendarModel>(
                stream: academicCalendarDatabase()
                    .academicCalendarData(student!.academicCalendarId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    academicCalendarModel? academicCalendar = snapshot.data;
                    return Container(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        child: StreamBuilder<classModel>(
                            stream: schoolDatabase().classData(student.classId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                classModel? classDetail = snapshot.data;
                                return StreamBuilder<childModel>(
                                    stream:
                                        childDatabase(childId: student.childId)
                                            .childData,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        childModel? child = snapshot.data;
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                RichText(
                                                  text: TextSpan(
                                                      text: 'Class',
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          decoration:
                                                              TextDecoration
                                                                  .underline),
                                                      recognizer:
                                                          TapGestureRecognizer()
                                                            ..onTap = () {
                                                              context.go(
                                                                  '/teacher/class');
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
                                                              TextDecoration
                                                                  .underline),
                                                      recognizer:
                                                          TapGestureRecognizer()
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
                                                              TextDecoration
                                                                  .underline),
                                                      recognizer:
                                                          TapGestureRecognizer()
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
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            const SizedBox(height: 30),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10.0),
                                              child: Container(
                                                height: 1.0,
                                                width: double.infinity,
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                            const SizedBox(height: 50),
                                            SizedBox(
                                              height: 350,
                                              width: double.maxFinite,
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 40,
                                                          vertical: 30),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    10)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 5,
                                                            offset: const Offset(
                                                                0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment
                                                                .topCenter,
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
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      'First Name',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      'Last Name',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      'Age',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      'Birthday',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      'Parent',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
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
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      ': ${child.childFirstname}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      ': ${child.childLastname}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      ': ${child.childCurrentAge}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    Text(
                                                                      ': ${convertTimeToDateString(child.childBirthday)}',
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            10),
                                                                    StreamBuilder<
                                                                            parentModel>(
                                                                        stream: parentDatabase(parentId: child.parentId)
                                                                            .parentData,
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            return Text(
                                                                              ': ${snapshot.data!.parentFullName} (${snapshot.data!.parentPhoneNumber})',
                                                                              style: const TextStyle(fontSize: 15),
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
                                                  const SizedBox(width: 20),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 40,
                                                          vertical: 30),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        border: Border.all(),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                                Radius.circular(
                                                                    10)),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 5,
                                                            offset: const Offset(
                                                                0,
                                                                3), // changes position of shadow
                                                          ),
                                                        ],
                                                      ),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            alignment: Alignment
                                                                .topCenter,
                                                            child: const Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .fact_check,
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
                                                          Expanded(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: const Text(
                                                                'Choose month and year below:',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceEvenly,
                                                                children: <Widget>[
                                                                  Column(
                                                                    children: [
                                                                      const Text(
                                                                        'Month',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              5),
                                                                      Text(
                                                                        _recordDate
                                                                            .month
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                20.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  const Text(
                                                                    ' / ',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  Column(
                                                                    children: [
                                                                      const Text(
                                                                        'Year',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              5),
                                                                      Text(
                                                                        _recordDate
                                                                            .year
                                                                            .toString(),
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                20.0),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  IconButton(
                                                                    icon: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color: Colors
                                                                              .grey[
                                                                          800],
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      showMonthPicker(
                                                                        context:
                                                                            context,
                                                                        initialDate:
                                                                            _recordDate,
                                                                        firstDate:
                                                                            convertTimeToDate(academicCalendar!.academicCalendarStartDate),
                                                                        lastDate:
                                                                            DateTime.now().subtract(const Duration(days: 1)),
                                                                      ).then(
                                                                          (date) {
                                                                        setState(
                                                                            () {
                                                                          _recordDate =
                                                                              date!;
                                                                        });
                                                                      });
                                                                    },
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          20),
                                                                  ElevatedButton(
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          const Color(
                                                                              0xff8290F0),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(5),
                                                                      ),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      showDialog(
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (BuildContext context) {
                                                                            return StreamBuilder<List<studentAttendanceModel>>(
                                                                                stream: studentAttendanceDatabase().allStudentAttendanceWithStudentIdAcademicCalendarIdAndSpecificMonth(student.studentId, academicCalendar!.academicCalendarId, _recordDate.month.toString(), _recordDate.year.toString()),
                                                                                builder: (context, snapshot) {
                                                                                  if (snapshot.hasData) {
                                                                                    List<studentAttendanceModel>? attendanceList = snapshot.data;
                                                                                    return AlertDialog(
                                                                                      title: Padding(
                                                                                        padding: const EdgeInsets.all(10.0),
                                                                                        child: Text('Attendance Record : ${monthToString(_recordDate.month)} ${_recordDate.year}'),
                                                                                      ),
                                                                                      content: SizedBox(
                                                                                        width: 800,
                                                                                        child: Column(
                                                                                          children: [
                                                                                            Row(
                                                                                              children: [
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(
                                                                                                    alignment: Alignment.center,
                                                                                                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                                                                    decoration: BoxDecoration(
                                                                                                      color: Colors.white,
                                                                                                      border: Border.all(),
                                                                                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                                      boxShadow: [
                                                                                                        BoxShadow(
                                                                                                          color: Colors.grey.withOpacity(0.5),
                                                                                                          spreadRadius: 1,
                                                                                                          blurRadius: 5,
                                                                                                          offset: const Offset(0, 3), // changes position of shadow
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                    child: Row(
                                                                                                      children: <Widget>[
                                                                                                        const Expanded(flex: 1, child: Icon(Icons.info)),
                                                                                                        Expanded(
                                                                                                          flex: 4,
                                                                                                          child: Container(
                                                                                                            child: const Text(
                                                                                                              'Press the student card below to view attendance description.',
                                                                                                              textAlign: TextAlign.start,
                                                                                                              style: TextStyle(fontSize: 15),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(),
                                                                                                )
                                                                                              ],
                                                                                            ),
                                                                                            const SizedBox(height: 30),
                                                                                            Row(
                                                                                              children: <Widget>[
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(
                                                                                                    alignment: Alignment.center,
                                                                                                    constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                                                                                                    child: const Text(
                                                                                                      'Date',
                                                                                                      textAlign: TextAlign.center,
                                                                                                      style: TextStyle(color: Colors.grey, fontSize: 15),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(
                                                                                                      alignment: Alignment.center,
                                                                                                      constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                                                                                                      child: const Text(
                                                                                                        'Attendance Status',
                                                                                                        textAlign: TextAlign.center,
                                                                                                        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 15),
                                                                                                      )),
                                                                                                ),
                                                                                                Expanded(
                                                                                                  flex: 1,
                                                                                                  child: Container(),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            const SizedBox(height: 10),
                                                                                            ListView.builder(
                                                                                              shrinkWrap: true,
                                                                                              itemCount: attendanceList!.length,
                                                                                              itemBuilder: ((context, index) {
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
                                                                                                              content: Container(padding: const EdgeInsets.all(10.0), child: attendanceList[index].description == '' ? const Text('No description recorded.') : Text(attendanceList[index].description)),
                                                                                                            );
                                                                                                          });
                                                                                                    },
                                                                                                    child: Container(
                                                                                                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: Colors.white,
                                                                                                        borderRadius: const BorderRadius.all(Radius.circular(2)),
                                                                                                        boxShadow: [
                                                                                                          BoxShadow(
                                                                                                            color: Colors.grey.withOpacity(0.5),
                                                                                                            spreadRadius: 1,
                                                                                                            blurRadius: 5,
                                                                                                            offset: const Offset(0, 3), // changes position of shadow
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                      child: Row(
                                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                                        children: <Widget>[
                                                                                                          Expanded(
                                                                                                            flex: 1,
                                                                                                            child: Container(),
                                                                                                          ),
                                                                                                          Expanded(
                                                                                                            flex: 1,
                                                                                                            child: Container(
                                                                                                              alignment: Alignment.center,
                                                                                                              constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                                                                                                              child: Text(
                                                                                                                '${attendanceList[index].attendanceDateDay}/${attendanceList[index].attendanceDateMonth}/${attendanceList[index].attendanceDateYear}',
                                                                                                                textAlign: TextAlign.center,
                                                                                                                style: const TextStyle(color: Colors.black, fontSize: 15),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                          Expanded(
                                                                                                            flex: 1,
                                                                                                            child: Container(),
                                                                                                          ),
                                                                                                          Expanded(
                                                                                                            flex: 1,
                                                                                                            child: Container(
                                                                                                                alignment: Alignment.center,
                                                                                                                constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
                                                                                                                child: Row(
                                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                                  children: <Widget>[
                                                                                                                    attendanceList[index].attendanceStatus == 'present'
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
                                                                                                          Expanded(
                                                                                                            flex: 1,
                                                                                                            child: Container(),
                                                                                                          ),
                                                                                                        ],
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                );
                                                                                                ;
                                                                                              }),
                                                                                            )
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  } else {
                                                                                    return Container();
                                                                                  }
                                                                                });
                                                                          });
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      'View Record',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              )),
                                                          Expanded(
                                                            child: Container(),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 50),
                                            Container(
                                              alignment: Alignment.topCenter,
                                              child: const Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.edit_note,
                                                    size: 35,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Examination Progress',
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 20.0,
                                                        fontFamily: 'Comfortaa',
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            SizedBox(
                                              height: 400,
                                              child: childExaminationProgress(
                                                  studentId: student.studentId,
                                                  academicCalendarId: student
                                                      .academicCalendarId),
                                            ),
                                            const SizedBox(
                                              height: 100,
                                            ),
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
                    return Container();
                  }
                });
          } else {
            return const Loading();
          }
        },
      );
    }
  }
}
