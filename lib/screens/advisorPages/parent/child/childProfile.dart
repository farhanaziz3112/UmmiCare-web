import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/screens/charts/childBmi.dart';
import 'package:ummicare/screens/charts/childExaminationProgress.dart';
import 'package:ummicare/screens/charts/studentAttendancePercentage.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/studentAttendanceDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';
import 'package:ummicare/shared/constant.dart';
import 'package:ummicare/shared/function.dart';

class childProfile extends StatefulWidget {
  const childProfile({super.key, required this.childId});
  final String childId;

  @override
  State<childProfile> createState() => _childProfileState();
}

class _childProfileState extends State<childProfile> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 1700) {
      return StreamBuilder<childModel>(
        stream: childDatabase(childId: widget.childId).childData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            childModel? child = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: 'Parent',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/advisor/parent');
                                }),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        StreamBuilder<parentModel>(
                            stream: parentDatabase(parentId: child!.parentId)
                                .parentData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                parentModel? parent = snapshot.data;
                                return RichText(
                                  text: TextSpan(
                                    text: parent!.parentFirstName,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.go(
                                            '/advisor/parent/${parent.parentId}');
                                      },
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: child.childFirstname,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        child.childName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 45.0,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder<parentModel>(
                        stream:
                            parentDatabase(parentId: child.parentId).parentData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            parentModel? parent = snapshot.data;
                            return Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${parent!.parentFullName}\'s Child',
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 1.0,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 300,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(0, 30, 10, 50),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
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
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      '${child.childFirstname}\'s Profile',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ImageNetwork(
                                          image: child.childProfileImg,
                                          height: 150,
                                          width: 150,
                                          borderRadius:
                                              BorderRadius.circular(70)),
                                      const SizedBox(width: 10),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: const Text(
                                                        'Full Name',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        child.childName,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                          minWidth: 50,
                                                          maxWidth: 100),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: const Text(
                                                        'First Name',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        child.childFirstname,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                          minWidth: 50,
                                                          maxWidth: 100),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: const Text(
                                                        'Last Name',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        child.childLastname,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 40),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: const Text(
                                                        'Birthday',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        convertTimeToDateString(
                                                            child
                                                                .childBirthday),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                          minWidth: 50,
                                                          maxWidth: 100),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: const Text(
                                                        'Current Age',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        child.childCurrentAge
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 100,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xfff29180),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.child_care,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Age Category',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 15),
                                child: const VerticalDivider(
                                  color: Colors.white,
                                )),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: double.maxFinite,
                                alignment: Alignment.center,
                                child: Text(
                                  child.childAgeCategory,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                  maxLines: 2,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 100,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Color(0xff71CBCA),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.trending_up,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Child Overall Status',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 15),
                                child: const VerticalDivider(
                                  color: Colors.white,
                                )),
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: double.maxFinite,
                                alignment: Alignment.center,
                                child: Text(
                                  child.overallStatus == 'great'
                                      ? 'Great'
                                      : child.overallStatus == 'normal'
                                          ? 'Normal'
                                          : 'Needs Attention',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                  maxLines: 2,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 150,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        alignment: Alignment.center,
                        constraints: const BoxConstraints.expand(),
                        decoration: const BoxDecoration(
                          color: Color(0xff8290F0),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'Child\'s Module Status',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.health_and_safety,
                                                size: 25,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Health',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                            Icons.keyboard_double_arrow_right),
                                        child.healthId != ''
                                            ? Expanded(
                                                flex: 1,
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.green[800],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Active',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    )),
                                              )
                                            : Expanded(
                                                flex: 1,
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red[800],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Inactive',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    )),
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(10)),
                                    ),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        const Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.school,
                                                size: 25,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Education',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(
                                            Icons.keyboard_double_arrow_right),
                                        child.educationId != ''
                                            ? Expanded(
                                                flex: 1,
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.green[800],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Active',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    )),
                                              )
                                            : Expanded(
                                                flex: 1,
                                                child: Container(
                                                    alignment: Alignment.center,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.red[800],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Inactive',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    )),
                                              )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 80),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${child.childFirstname}\'s Education Module',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 30),
                    child.educationId != ''
                        ? StreamBuilder<studentModel>(
                            stream: studentDatabase()
                                .studentData(child.educationId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                studentModel? student = snapshot.data;
                                return StreamBuilder<academicCalendarModel>(
                                    stream: academicCalendarDatabase()
                                        .academicCalendarData(
                                            student!.academicCalendarId),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        academicCalendarModel?
                                            academicCalendar = snapshot.data;
                                        return StreamBuilder<classModel>(
                                            stream: schoolDatabase().classData(
                                                academicCalendar!.classId),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                classModel? classDetail =
                                                    snapshot.data;
                                                return Column(
                                                  children: <Widget>[
                                                    SizedBox(
                                                      height: 350,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                20, 30, 20, 30),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
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
                                                              alignment:
                                                                  Alignment
                                                                      .topCenter,
                                                              child: const Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .school,
                                                                    size: 35,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Text(
                                                                    'School & Class Details',
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
                                                                            FontWeight.bold),
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
                                                                        'Class Name',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 15),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              10),
                                                                      Text(
                                                                        'Class Year',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 15),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              10),
                                                                      Text(
                                                                        'Class Teacher Name',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 15),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              10),
                                                                      Text(
                                                                        'School',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 15),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              10),
                                                                      Text(
                                                                        'Calendar Start Date',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 15),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              10),
                                                                      Text(
                                                                        'Calendar End Date',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 15),
                                                                      ),
                                                                      SizedBox(
                                                                          height:
                                                                              10),
                                                                      Text(
                                                                        'Registration Status',
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            fontSize: 15),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 20),
                                                                Expanded(
                                                                  flex: 2,
                                                                  child: Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: <Widget>[
                                                                      Text(
                                                                        ': ${classDetail!.className}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      Text(
                                                                        ': ${classDetail.classYear}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      StreamBuilder<
                                                                              teacherModel>(
                                                                          stream: teacherDatabase(teacherId: academicCalendar.teacherId)
                                                                              .teacherData,
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            if (snapshot.hasData) {
                                                                              return Text(
                                                                                ': ${snapshot.data!.teacherFullName}',
                                                                                style: const TextStyle(fontSize: 15),
                                                                              );
                                                                            } else {
                                                                              return Container();
                                                                            }
                                                                          }),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      StreamBuilder<
                                                                              schoolModel>(
                                                                          stream: schoolDatabase().schoolData(academicCalendar
                                                                              .schoolId),
                                                                          builder:
                                                                              (context, snapshot) {
                                                                            if (snapshot.hasData) {
                                                                              return Text(
                                                                                ': ${snapshot.data!.schoolName}',
                                                                                style: const TextStyle(fontSize: 15),
                                                                              );
                                                                            } else {
                                                                              return Container();
                                                                            }
                                                                          }),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      Text(
                                                                        ': ${convertTimeToDateString(academicCalendar.academicCalendarStartDate)}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      Text(
                                                                        ': ${convertTimeToDateString(academicCalendar.academicCalendarEndDate)}',
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                15),
                                                                      ),
                                                                      const SizedBox(
                                                                          height:
                                                                              10),
                                                                      student.activationStatus ==
                                                                              'active'
                                                                          ? SizedBox(
                                                                              height: 30,
                                                                              width: 150,
                                                                              child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.green[800],
                                                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                  ),
                                                                                  padding: const EdgeInsets.all(5),
                                                                                  child: const Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: <Widget>[
                                                                                      Icon(
                                                                                        Icons.check,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Text(
                                                                                        'Active',
                                                                                        style: TextStyle(color: Colors.white, fontSize: 15),
                                                                                      )
                                                                                    ],
                                                                                  )),
                                                                            )
                                                                          : SizedBox(
                                                                              height: 30,
                                                                              width: 150,
                                                                              child: Container(
                                                                                  alignment: Alignment.center,
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 5),
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.red[800],
                                                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                  ),
                                                                                  padding: const EdgeInsets.all(5),
                                                                                  child: const Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: <Widget>[
                                                                                      Icon(
                                                                                        Icons.close,
                                                                                        color: Colors.white,
                                                                                      ),
                                                                                      SizedBox(
                                                                                        width: 10,
                                                                                      ),
                                                                                      Text(
                                                                                        'Inactive',
                                                                                        style: TextStyle(color: Colors.white, fontSize: 15),
                                                                                      )
                                                                                    ],
                                                                                  )),
                                                                            ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    SizedBox(
                                                      height: 350,
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                20, 30, 20, 30),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                          border: Border.all(),
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
                                                              alignment:
                                                                  Alignment
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
                                                                    'Class Attendance Percentage',
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
                                                                            FontWeight.bold),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            SizedBox(
                                                              height: 200,
                                                              child: Row(
                                                                children: <Widget>[
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: StreamBuilder<
                                                                            studentModel>(
                                                                        stream: studentDatabase().studentData(child
                                                                            .educationId),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            return Container(
                                                                              child: studentAttendancePercentage(
                                                                                studentId: child.educationId,
                                                                                academicCalendarId: snapshot.data!.academicCalendarId,
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            return Container();
                                                                          }
                                                                        }),
                                                                  ),
                                                                  Expanded(
                                                                    flex: 1,
                                                                    child: StreamBuilder<
                                                                            List<
                                                                                studentAttendanceModel>>(
                                                                        stream: studentAttendanceDatabase().allStudentAttendanceWithStudentId(child
                                                                            .educationId),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            List<studentAttendanceModel>?
                                                                                attendanceList =
                                                                                snapshot.data;
                                                                            int present =
                                                                                getNoOfAttendanceStatus(attendanceList!, 'present');
                                                                            int absent =
                                                                                getNoOfAttendanceStatus(attendanceList, 'absent');
                                                                            return Container(
                                                                              alignment: Alignment.center,
                                                                              child: Column(
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: <Widget>[
                                                                                  Text(
                                                                                    'Absent: ${double.parse(((absent / (present + absent)) * 100).toStringAsFixed(2))}%',
                                                                                    style: const TextStyle(
                                                                                      fontSize: 25,
                                                                                    ),
                                                                                  ),
                                                                                  const SizedBox(height: 20),
                                                                                  Text(
                                                                                    'Present: ${double.parse(((present / (present + absent)) * 100).toStringAsFixed(2))}%',
                                                                                    style: const TextStyle(fontSize: 25),
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            );
                                                                          } else {
                                                                            return Container();
                                                                          }
                                                                        }),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 30,
                                                    ),
                                                    StreamBuilder<studentModel>(
                                                        stream: studentDatabase()
                                                            .studentData(child
                                                                .educationId),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            if (snapshot.data!
                                                                    .activationStatus ==
                                                                'inactive') {
                                                              return Container();
                                                            } else {
                                                              return Column(
                                                                children: <Widget>[
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .topCenter,
                                                                    child:
                                                                        const Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Icon(
                                                                          Icons
                                                                              .edit_note,
                                                                          size:
                                                                              35,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Text(
                                                                          'Examination Progress',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: TextStyle(
                                                                              color: Colors.black,
                                                                              fontSize: 20.0,
                                                                              fontFamily: 'Comfortaa',
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 50,
                                                                  ),
                                                                  SizedBox(
                                                                    height: 500,
                                                                    child: StreamBuilder<
                                                                            studentModel>(
                                                                        stream: studentDatabase().studentData(child
                                                                            .educationId),
                                                                        builder:
                                                                            (context,
                                                                                snapshot) {
                                                                          if (snapshot
                                                                              .hasData) {
                                                                            studentModel?
                                                                                student =
                                                                                snapshot.data;
                                                                            return childExaminationProgress(
                                                                                studentId: child.educationId,
                                                                                academicCalendarId: student!.academicCalendarId);
                                                                          } else {
                                                                            return Container();
                                                                          }
                                                                        }),
                                                                  ),
                                                                ],
                                                              );
                                                            }
                                                          } else {
                                                            return Container();
                                                          }
                                                        }),
                                                  ],
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
                            })
                        : SizedBox(
                            height: 300,
                            child: Center(
                              child: noData('Oops! Nothing here...'),
                            ),
                          ),
                    const SizedBox(height: 80),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${child.childFirstname}\'s Health Module',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 30),
                    child.healthId == ''
                        ? SizedBox(
                            height: 300,
                            child: Center(
                              child: noData('Oops! Nothing here...'),
                            ),
                          )
                        : StreamBuilder<HealthModel>(
                            stream: HealthDatabaseService()
                                .healthData(child.healthId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                HealthModel? health = snapshot.data;
                                return StreamBuilder<patientModel>(
                                    stream: PatientDatabaseService()
                                        .patientData(health!.patientId),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        patientModel? patient = snapshot.data;
                                        return Column(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20, 30),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
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
                                                children: <Widget>[
                                                  Container(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .health_and_safety,
                                                          size: 35,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Health Details',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20.0,
                                                              fontFamily:
                                                                  'Comfortaa',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
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
                                                              'Clinic Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                              'BMI Status',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 20),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            StreamBuilder<
                                                                ClinicModel>(
                                                              stream: medicalStaffDatabase()
                                                                  .clinicData(
                                                                      patient!
                                                                          .clinicId),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  return Text(
                                                                    ': ${snapshot.data?.clinicName}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                                  );
                                                                } else {
                                                                  return Container();
                                                                }
                                                              },
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            StreamBuilder<
                                                                List<
                                                                    BmiHealthModel>>(
                                                              stream: HealthDatabaseService()
                                                                  .allBmiHealthData(
                                                                      patient
                                                                          .healthId),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  List<BmiHealthModel>?
                                                                      bmi =
                                                                      snapshot
                                                                          .data;
                                                                  String
                                                                      bmiStatus =
                                                                      ' ';
                                                                  double
                                                                      lastBmiData =
                                                                      bmi![0]
                                                                          .bmiData;
                                                                  if (lastBmiData <
                                                                      16) {
                                                                    bmiStatus =
                                                                        "Severe Thinness";
                                                                  } else if (lastBmiData <
                                                                      17) {
                                                                    bmiStatus =
                                                                        "Moderate Thinness";
                                                                  } else if (lastBmiData <
                                                                      18.5) {
                                                                    bmiStatus =
                                                                        "Mild Thinness";
                                                                  } else if (lastBmiData <
                                                                      25) {
                                                                    bmiStatus =
                                                                        "Normal";
                                                                  } else if (lastBmiData <
                                                                      30) {
                                                                    bmiStatus =
                                                                        "Overweight";
                                                                  } else if (lastBmiData <
                                                                      35) {
                                                                    bmiStatus =
                                                                        "Obese Class I";
                                                                  } else if (lastBmiData <
                                                                      40) {
                                                                    bmiStatus =
                                                                        "Obese Class II";
                                                                  } else if (lastBmiData >=
                                                                      40) {
                                                                    bmiStatus =
                                                                        "Obese Class III";
                                                                  } else {
                                                                    bmiStatus =
                                                                        "No Status";
                                                                  }
                                                                  return Text(
                                                                    ': ${bmiStatus}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                                  );
                                                                } else {
                                                                  return Container();
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
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
                                                children: <Widget>[
                                                  SizedBox(
                                                      height: 200,
                                                      child: childBmi(
                                                          healthId: patient
                                                              .healthId)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            StreamBuilder<HealthStatusModel>(
                                              stream: HealthDatabaseService()
                                                  .healthStatusData(
                                                      patient.healthStatusId),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  HealthStatusModel? status =
                                                      snapshot.data;
                                                  if (status
                                                          ?.healthConditionId !=
                                                      " ") {
                                                    return StreamBuilder<
                                                            HealthConditionModel>(
                                                        stream: HealthDatabaseService()
                                                            .healthConditionData(
                                                                status!
                                                                    .healthConditionId),
                                                        builder: (context,
                                                            snapshot) {
                                                          HealthConditionModel?
                                                              condition =
                                                              snapshot.data;
                                                          return Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    30,
                                                                    30,
                                                                    30,
                                                                    30),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border:
                                                                  Border.all(),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          10)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius: 5,
                                                                  offset: const Offset(
                                                                      0,
                                                                      3), // changes position of shadow
                                                                ),
                                                              ],
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  child:
                                                                      const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .medical_information,
                                                                        size:
                                                                            35,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        'Health Condition',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                20.0,
                                                                            fontFamily:
                                                                                'Comfortaa',
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 30),
                                                                Row(
                                                                  children: <Widget>[
                                                                    const Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            'Temperature',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            'Heart Rate',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            'Symptom',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            'Illness',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            'Notes',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            20),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            ': ${condition!.currentTemperature}',
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            ': ${condition.currentHeartRate}',
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            ': ${condition.currentSymptom}',
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            ': ${condition.currentIllness}',
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            ': ${condition.notes}',
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  } else {
                                                    return Container();
                                                  }
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            StreamBuilder<HealthStatusModel>(
                                              stream: HealthDatabaseService()
                                                  .healthStatusData(
                                                      patient.healthStatusId),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  HealthStatusModel? status =
                                                      snapshot.data;
                                                  if (status
                                                          ?.physicalConditionId !=
                                                      " ") {
                                                    return StreamBuilder<
                                                            PhysicalConditionModel>(
                                                        stream: HealthDatabaseService()
                                                            .physicalConditionData(
                                                                status!
                                                                    .physicalConditionId),
                                                        builder: (context,
                                                            snapshot) {
                                                          PhysicalConditionModel?
                                                              physical =
                                                              snapshot.data;
                                                          return Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    30,
                                                                    30,
                                                                    30,
                                                                    30),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border:
                                                                  Border.all(),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          10)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius: 5,
                                                                  offset: const Offset(
                                                                      0,
                                                                      3), // changes position of shadow
                                                                ),
                                                              ],
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  child:
                                                                      const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .personal_injury,
                                                                        size:
                                                                            35,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        'Physical Condition',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                20.0,
                                                                            fontFamily:
                                                                                'Comfortaa',
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 30),
                                                                Row(
                                                                  children: <Widget>[
                                                                    const Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            'Injury',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            'Details',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            20),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            ': ${physical?.currentInjury}',
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            ': ${physical?.details}',
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  } else {
                                                    return Container();
                                                  }
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            StreamBuilder<HealthStatusModel>(
                                              stream: HealthDatabaseService()
                                                  .healthStatusData(
                                                      patient.healthStatusId),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  HealthStatusModel? status =
                                                      snapshot.data;
                                                  if (status
                                                          ?.chronicConditionId !=
                                                      " ") {
                                                    return StreamBuilder<
                                                            ChronicConditionModel>(
                                                        stream: HealthDatabaseService()
                                                            .chronicConditionData(
                                                                status!
                                                                    .chronicConditionId),
                                                        builder: (context,
                                                            snapshot) {
                                                          ChronicConditionModel?
                                                              chronic =
                                                              snapshot.data;
                                                          return Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    30,
                                                                    30,
                                                                    30,
                                                                    30),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border:
                                                                  Border.all(),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          10)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius:
                                                                      1,
                                                                  blurRadius: 5,
                                                                  offset: const Offset(
                                                                      0,
                                                                      3), // changes position of shadow
                                                                ),
                                                              ],
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  child:
                                                                      const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .emergency,
                                                                        size:
                                                                            35,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        'Chronic Condition',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                20.0,
                                                                            fontFamily:
                                                                                'Comfortaa',
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height: 30),
                                                                Row(
                                                                  children: <Widget>[
                                                                    const Expanded(
                                                                      flex: 1,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            'Allergies',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            'Details',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            20),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            ': ${chronic!.childAllergies}',
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            ': ${chronic.childChronic}',
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          );
                                                        });
                                                  } else {
                                                    return Container();
                                                  }
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            )
                                          ],
                                        );
                                      } else {
                                        return Container();
                                      }
                                    });
                              } else {
                                return Container();
                              }
                            },
                          ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      );
    } else {
      return StreamBuilder<childModel>(
        stream: childDatabase(childId: widget.childId).childData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            childModel? child = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: 'Parent',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/advisor/parent');
                                }),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        StreamBuilder<parentModel>(
                            stream: parentDatabase(parentId: child!.parentId)
                                .parentData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                parentModel? parent = snapshot.data;
                                return RichText(
                                  text: TextSpan(
                                    text: parent!.parentFirstName,
                                    style: const TextStyle(
                                        color: Colors.grey,
                                        decoration: TextDecoration.underline),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.go(
                                            '/advisor/parent/${parent.parentId}');
                                      },
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: child.childFirstname,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        child.childName,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 45.0,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder<parentModel>(
                        stream:
                            parentDatabase(parentId: child.parentId).parentData,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            parentModel? parent = snapshot.data;
                            return Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${parent!.parentFullName}\'s Child',
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        height: 1.0,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 300,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(0, 30, 10, 50),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(),
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
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      '${child.childFirstname}\'s Profile',
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ImageNetwork(
                                          image: child.childProfileImg,
                                          height: 150,
                                          width: 150,
                                          borderRadius:
                                              BorderRadius.circular(70)),
                                      const SizedBox(width: 10),
                                      Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: const Text(
                                                        'Full Name',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        child.childName,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                          minWidth: 50,
                                                          maxWidth: 100),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: const Text(
                                                        'First Name',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        child.childFirstname,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                          minWidth: 50,
                                                          maxWidth: 100),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: const Text(
                                                        'Last Name',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        child.childLastname,
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 40),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: const Text(
                                                        'Birthday',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        convertTimeToDateString(
                                                            child
                                                                .childBirthday),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                ConstrainedBox(
                                                  constraints:
                                                      const BoxConstraints(
                                                          minWidth: 50,
                                                          maxWidth: 100),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: const Text(
                                                        'Current Age',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Text(
                                                        child.childCurrentAge
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          alignment: Alignment.center,
                                          constraints:
                                              const BoxConstraints.expand(),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color(0xfff29180),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              const Expanded(
                                                flex: 2,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.child_care,
                                                      size: 50,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Age Category',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 0,
                                                      horizontal: 15),
                                                  child: const VerticalDivider(
                                                    color: Colors.white,
                                                  )),
                                              Expanded(
                                                flex: 2,
                                                child: Container(
                                                  height: double.maxFinite,
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    child.childAgeCategory,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white),
                                                    maxLines: 2,
                                                    softWrap: true,
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 20),
                                          alignment: Alignment.center,
                                          constraints:
                                              const BoxConstraints.expand(),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color(0xff71CBCA),
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              const Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.trending_up,
                                                      size: 50,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      'Child Overall Status',
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 0,
                                                      horizontal: 15),
                                                  child: const VerticalDivider(
                                                    color: Colors.white,
                                                  )),
                                              Expanded(
                                                flex: 1,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        child.overallStatus ==
                                                                'great'
                                                            ? 'Great'
                                                            : child.overallStatus ==
                                                                    'normal'
                                                                ? 'Normal'
                                                                : 'Needs\nAttention',
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            color:
                                                                Colors.white),
                                                        softWrap: true,
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                List<String>
                                                                    status = [
                                                                  'great',
                                                                  'normal',
                                                                  'needs attention'
                                                                ];
                                                                String
                                                                    currentStatus =
                                                                    child
                                                                        .overallStatus;
                                                                return StatefulBuilder(builder:
                                                                    (stfContext,
                                                                        stfSetState) {
                                                                  return AlertDialog(
                                                                    scrollable:
                                                                        true,
                                                                    title:
                                                                        const Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              10.0),
                                                                      child: Text(
                                                                          'Change Overall Status'),
                                                                    ),
                                                                    content:
                                                                        DropdownButtonFormField<
                                                                            String>(
                                                                      value:
                                                                          currentStatus,
                                                                      items: status.map<
                                                                          DropdownMenuItem<
                                                                              String>>((String
                                                                          value) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              value,
                                                                          child:
                                                                              Text(value),
                                                                        );
                                                                      }).toList(),
                                                                      onChanged:
                                                                          (String?
                                                                              value) {
                                                                        stfSetState(
                                                                            () {
                                                                          currentStatus =
                                                                              value!;
                                                                        });
                                                                      },
                                                                    ),
                                                                    actions: [
                                                                      ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              const Color(0xffF29180),
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            "Cancel",
                                                                            style:
                                                                                TextStyle(color: Colors.white)),
                                                                      ),
                                                                      ElevatedButton(
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              const Color(0xff8290F0),
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          childDatabase(childId: child.childId).updateChildData(
                                                                              child.childId,
                                                                              child.parentId,
                                                                              child.childCreatedDate,
                                                                              child.childName,
                                                                              child.childFirstname,
                                                                              child.childLastname,
                                                                              child.childBirthday,
                                                                              child.childCurrentAge,
                                                                              child.childAgeCategory,
                                                                              child.childProfileImg,
                                                                              child.educationId,
                                                                              child.healthId,
                                                                              currentStatus);
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            "Confirm",
                                                                            style:
                                                                                TextStyle(color: Colors.white)),
                                                                      ),
                                                                    ],
                                                                  );
                                                                });
                                                              });
                                                        },
                                                        icon: Icon(
                                                          Icons.edit,
                                                          color:
                                                              Colors.grey[100],
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    alignment: Alignment.center,
                                    constraints: const BoxConstraints.expand(),
                                    decoration: const BoxDecoration(
                                      color: Color(0xff8290F0),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        const Text(
                                          'Child\'s Module Status',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    const Expanded(
                                                      flex: 1,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .health_and_safety,
                                                            size: 25,
                                                            color: Colors.black,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            'Health',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Icon(Icons
                                                        .keyboard_double_arrow_right),
                                                    child.healthId != ''
                                                        ? Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .green[
                                                                      800],
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child:
                                                                    const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <Widget>[
                                                                    Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      'Active',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    )
                                                                  ],
                                                                )),
                                                          )
                                                        : Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .red[800],
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child:
                                                                    const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <Widget>[
                                                                    Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      'Inactive',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    )
                                                                  ],
                                                                )),
                                                          )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color: Colors.white,
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    const Expanded(
                                                      flex: 1,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.school,
                                                            size: 25,
                                                            color: Colors.black,
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Text(
                                                            'Education',
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color: Colors
                                                                    .black),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const Icon(Icons
                                                        .keyboard_double_arrow_right),
                                                    child.educationId != ''
                                                        ? Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                          .green[
                                                                      800],
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child:
                                                                    const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <Widget>[
                                                                    Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      'Active',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    )
                                                                  ],
                                                                )),
                                                          )
                                                        : Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .red[800],
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10)),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child:
                                                                    const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <Widget>[
                                                                    Icon(
                                                                      Icons
                                                                          .check,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Text(
                                                                      'Inactive',
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.white),
                                                                    )
                                                                  ],
                                                                )),
                                                          )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${child.childFirstname}\'s Education Module',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 30),
                    child.educationId != ''
                        ? SizedBox(
                            height: 350,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: StreamBuilder<studentModel>(
                                      stream: studentDatabase()
                                          .studentData(child.educationId),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          studentModel? student = snapshot.data;
                                          return StreamBuilder<
                                                  academicCalendarModel>(
                                              stream: academicCalendarDatabase()
                                                  .academicCalendarData(student!
                                                      .academicCalendarId),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData) {
                                                  academicCalendarModel?
                                                      academicCalendar =
                                                      snapshot.data;
                                                  return StreamBuilder<
                                                          classModel>(
                                                      stream: schoolDatabase()
                                                          .classData(
                                                              academicCalendar!
                                                                  .classId),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          classModel?
                                                              classDetail =
                                                              snapshot.data;
                                                          return Container(
                                                            alignment: Alignment
                                                                .center,
                                                            padding:
                                                                const EdgeInsets
                                                                    .fromLTRB(
                                                                    20,
                                                                    30,
                                                                    20,
                                                                    30),
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              border:
                                                                  Border.all(),
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          10)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.5),
                                                                  spreadRadius:
                                                                      1,
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
                                                                  alignment:
                                                                      Alignment
                                                                          .topCenter,
                                                                  child:
                                                                      const Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .school,
                                                                        size:
                                                                            35,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        'School & Class Details',
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black,
                                                                            fontSize:
                                                                                20.0,
                                                                            fontFamily:
                                                                                'Comfortaa',
                                                                            fontWeight:
                                                                                FontWeight.bold),
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
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            'Class Name',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            'Class Year',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            'Class Teacher Name',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            'School',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            'Calendar Start Date',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            'Calendar End Date',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                          SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            'Registration Status',
                                                                            style:
                                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            20),
                                                                    Expanded(
                                                                      flex: 2,
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            ': ${classDetail!.className}',
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            ': ${classDetail.classYear}',
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          StreamBuilder<teacherModel>(
                                                                              stream: teacherDatabase(teacherId: academicCalendar.teacherId).teacherData,
                                                                              builder: (context, snapshot) {
                                                                                if (snapshot.hasData) {
                                                                                  return Text(
                                                                                    ': ${snapshot.data!.teacherFullName}',
                                                                                    style: const TextStyle(fontSize: 15),
                                                                                  );
                                                                                } else {
                                                                                  return Container();
                                                                                }
                                                                              }),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          StreamBuilder<schoolModel>(
                                                                              stream: schoolDatabase().schoolData(academicCalendar.schoolId),
                                                                              builder: (context, snapshot) {
                                                                                if (snapshot.hasData) {
                                                                                  return Text(
                                                                                    ': ${snapshot.data!.schoolName}',
                                                                                    style: const TextStyle(fontSize: 15),
                                                                                  );
                                                                                } else {
                                                                                  return Container();
                                                                                }
                                                                              }),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            ': ${convertTimeToDateString(academicCalendar.academicCalendarStartDate)}',
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          Text(
                                                                            ': ${convertTimeToDateString(academicCalendar.academicCalendarEndDate)}',
                                                                            style:
                                                                                const TextStyle(fontSize: 15),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          student.activationStatus == 'active'
                                                                              ? SizedBox(
                                                                                  height: 30,
                                                                                  width: 150,
                                                                                  child: Container(
                                                                                      alignment: Alignment.center,
                                                                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.green[800],
                                                                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                      ),
                                                                                      padding: const EdgeInsets.all(5),
                                                                                      child: const Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: <Widget>[
                                                                                          Icon(
                                                                                            Icons.check,
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Text(
                                                                                            'Active',
                                                                                            style: TextStyle(color: Colors.white, fontSize: 15),
                                                                                          )
                                                                                        ],
                                                                                      )),
                                                                                )
                                                                              : SizedBox(
                                                                                  height: 30,
                                                                                  width: 150,
                                                                                  child: Container(
                                                                                      alignment: Alignment.center,
                                                                                      margin: const EdgeInsets.symmetric(horizontal: 5),
                                                                                      decoration: BoxDecoration(
                                                                                        color: Colors.red[800],
                                                                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                                                      ),
                                                                                      padding: const EdgeInsets.all(5),
                                                                                      child: const Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: <Widget>[
                                                                                          Icon(
                                                                                            Icons.close,
                                                                                            color: Colors.white,
                                                                                          ),
                                                                                          SizedBox(
                                                                                            width: 10,
                                                                                          ),
                                                                                          Text(
                                                                                            'Inactive',
                                                                                            style: TextStyle(color: Colors.white, fontSize: 15),
                                                                                          )
                                                                                        ],
                                                                                      )),
                                                                                ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
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
                                      }),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: StreamBuilder<studentModel>(
                                      stream: studentDatabase()
                                          .studentData(child.educationId),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data!.activationStatus ==
                                              'inactive') {
                                            return Container();
                                          } else {
                                            return Container(
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20, 30),
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
                                                children: <Widget>[
                                                  Container(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.fact_check,
                                                          size: 35,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Class Attendance Percentage',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20.0,
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
                                                    height: 20,
                                                  ),
                                                  SizedBox(
                                                    height: 200,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                          flex: 1,
                                                          child: StreamBuilder<
                                                                  studentModel>(
                                                              stream: studentDatabase()
                                                                  .studentData(child
                                                                      .educationId),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  return Container(
                                                                    child:
                                                                        studentAttendancePercentage(
                                                                      studentId:
                                                                          child
                                                                              .educationId,
                                                                      academicCalendarId: snapshot
                                                                          .data!
                                                                          .academicCalendarId,
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Container();
                                                                }
                                                              }),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: StreamBuilder<
                                                                  List<
                                                                      studentAttendanceModel>>(
                                                              stream: studentAttendanceDatabase()
                                                                  .allStudentAttendanceWithStudentId(
                                                                      child
                                                                          .educationId),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  List<studentAttendanceModel>?
                                                                      attendanceList =
                                                                      snapshot
                                                                          .data;
                                                                  int present =
                                                                      getNoOfAttendanceStatus(
                                                                          attendanceList!,
                                                                          'present');
                                                                  int absent =
                                                                      getNoOfAttendanceStatus(
                                                                          attendanceList,
                                                                          'absent');
                                                                  return Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: <Widget>[
                                                                        Text(
                                                                          'Absent: ${double.parse(((absent / (present + absent)) * 100).toStringAsFixed(2))}%',
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                25,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                        Text(
                                                                          'Present: ${double.parse(((present / (present + absent)) * 100).toStringAsFixed(2))}%',
                                                                          style:
                                                                              const TextStyle(fontSize: 25),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  );
                                                                } else {
                                                                  return Container();
                                                                }
                                                              }),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                        } else {
                                          return Container();
                                        }
                                      }),
                                )
                              ],
                            ),
                          )
                        : SizedBox(
                            height: 300,
                            child: Center(
                              child: noData('Oops! Nothing here...'),
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    child.educationId != ''
                        ? StreamBuilder<studentModel>(
                            stream: studentDatabase()
                                .studentData(child.educationId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.activationStatus ==
                                    'inactive') {
                                  return Container();
                                } else {
                                  return Column(
                                    children: <Widget>[
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
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                      SizedBox(
                                        height: 500,
                                        child: StreamBuilder<studentModel>(
                                            stream: studentDatabase()
                                                .studentData(child.educationId),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                studentModel? student =
                                                    snapshot.data;
                                                return childExaminationProgress(
                                                    studentId:
                                                        child.educationId,
                                                    academicCalendarId: student!
                                                        .academicCalendarId);
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      ),
                                    ],
                                  );
                                }
                              } else {
                                return Container();
                              }
                            })
                        : Container(),
                    const SizedBox(height: 80),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${child.childFirstname}\'s Health Module',
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 30),
                    child.healthId == ''
                        ? SizedBox(
                            height: 300,
                            child: Center(
                              child: noData('Oops! Nothing here...'),
                            ),
                          )
                        : StreamBuilder<HealthModel>(
                            stream: HealthDatabaseService()
                                .healthData(child.healthId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                HealthModel? health = snapshot.data;
                                return StreamBuilder<patientModel>(
                                    stream: PatientDatabaseService()
                                        .patientData(health!.patientId),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        patientModel? patient = snapshot.data;
                                        return Column(
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.center,
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 30, 20, 30),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
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
                                                children: <Widget>[
                                                  Container(
                                                    alignment:
                                                        Alignment.topCenter,
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .health_and_safety,
                                                          size: 35,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'Health Details',
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 20.0,
                                                              fontFamily:
                                                                  'Comfortaa',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
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
                                                              'Clinic Name',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            ),
                                                            SizedBox(
                                                                height: 10),
                                                            Text(
                                                              'BMI Status',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 15),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(width: 20),
                                                      Expanded(
                                                        flex: 2,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            StreamBuilder<
                                                                ClinicModel>(
                                                              stream: medicalStaffDatabase()
                                                                  .clinicData(
                                                                      patient!
                                                                          .clinicId),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  return Text(
                                                                    ': ${snapshot.data?.clinicName}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                                  );
                                                                } else {
                                                                  return Container();
                                                                }
                                                              },
                                                            ),
                                                            const SizedBox(
                                                                height: 10),
                                                            StreamBuilder<
                                                                List<
                                                                    BmiHealthModel>>(
                                                              stream: HealthDatabaseService()
                                                                  .allBmiHealthData(
                                                                      patient
                                                                          .healthId),
                                                              builder: (context,
                                                                  snapshot) {
                                                                if (snapshot
                                                                    .hasData) {
                                                                  List<BmiHealthModel>?
                                                                      bmi =
                                                                      snapshot
                                                                          .data;
                                                                  String
                                                                      bmiStatus =
                                                                      ' ';
                                                                  double
                                                                      lastBmiData =
                                                                      bmi![0]
                                                                          .bmiData;
                                                                  if (lastBmiData <
                                                                      16) {
                                                                    bmiStatus =
                                                                        "Severe Thinness";
                                                                  } else if (lastBmiData <
                                                                      17) {
                                                                    bmiStatus =
                                                                        "Moderate Thinness";
                                                                  } else if (lastBmiData <
                                                                      18.5) {
                                                                    bmiStatus =
                                                                        "Mild Thinness";
                                                                  } else if (lastBmiData <
                                                                      25) {
                                                                    bmiStatus =
                                                                        "Normal";
                                                                  } else if (lastBmiData <
                                                                      30) {
                                                                    bmiStatus =
                                                                        "Overweight";
                                                                  } else if (lastBmiData <
                                                                      35) {
                                                                    bmiStatus =
                                                                        "Obese Class I";
                                                                  } else if (lastBmiData <
                                                                      40) {
                                                                    bmiStatus =
                                                                        "Obese Class II";
                                                                  } else if (lastBmiData >=
                                                                      40) {
                                                                    bmiStatus =
                                                                        "Obese Class III";
                                                                  } else {
                                                                    bmiStatus =
                                                                        "No Status";
                                                                  }
                                                                  return Text(
                                                                    ': ${bmiStatus}',
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                                  );
                                                                } else {
                                                                  return Container();
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border.all(),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(10)),
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
                                                children: <Widget>[
                                                  SizedBox(
                                                      height: 200,
                                                      child: childBmi(
                                                          healthId: patient
                                                              .healthId)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            SizedBox(
                                              height: 350,
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: StreamBuilder<
                                                        HealthStatusModel>(
                                                      stream: HealthDatabaseService()
                                                          .healthStatusData(patient
                                                              .healthStatusId),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          HealthStatusModel?
                                                              status =
                                                              snapshot.data;
                                                          if (status
                                                                  ?.healthConditionId !=
                                                              " ") {
                                                            return StreamBuilder<
                                                                    HealthConditionModel>(
                                                                stream: HealthDatabaseService()
                                                                    .healthConditionData(
                                                                        status!
                                                                            .healthConditionId),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  HealthConditionModel?
                                                                      condition =
                                                                      snapshot
                                                                          .data;
                                                                  return Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            30,
                                                                            30,
                                                                            30,
                                                                            30),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border
                                                                          .all(),
                                                                      borderRadius: const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10)),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.5),
                                                                          spreadRadius:
                                                                              1,
                                                                          blurRadius:
                                                                              5,
                                                                          offset: const Offset(
                                                                              0,
                                                                              3), // changes position of shadow
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.topCenter,
                                                                          child:
                                                                              const Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.medical_information,
                                                                                size: 35,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                'Health Condition',
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                30),
                                                                        Row(
                                                                          children: <Widget>[
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: <Widget>[
                                                                                  Text(
                                                                                    'Temperature',
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                  ),
                                                                                  SizedBox(height: 10),
                                                                                  Text(
                                                                                    'Heart Rate',
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                  ),
                                                                                  SizedBox(height: 10),
                                                                                  Text(
                                                                                    'Symptom',
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                  ),
                                                                                  SizedBox(height: 10),
                                                                                  Text(
                                                                                    'Illness',
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                  ),
                                                                                  SizedBox(height: 10),
                                                                                  Text(
                                                                                    'Notes',
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            const SizedBox(width: 20),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: <Widget>[
                                                                                  Text(
                                                                                    ': ${condition!.currentTemperature}',
                                                                                    style: const TextStyle(fontSize: 15),
                                                                                  ),
                                                                                  const SizedBox(height: 10),
                                                                                  Text(
                                                                                    ': ${condition.currentHeartRate}',
                                                                                    style: const TextStyle(fontSize: 15),
                                                                                  ),
                                                                                  const SizedBox(height: 10),
                                                                                  Text(
                                                                                    ': ${condition.currentSymptom}',
                                                                                    style: const TextStyle(fontSize: 15),
                                                                                  ),
                                                                                  const SizedBox(height: 10),
                                                                                  Text(
                                                                                    ': ${condition.currentIllness}',
                                                                                    style: const TextStyle(fontSize: 15),
                                                                                  ),
                                                                                  const SizedBox(height: 10),
                                                                                  Text(
                                                                                    ': ${condition.notes}',
                                                                                    style: const TextStyle(fontSize: 15),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  );
                                                                });
                                                          } else {
                                                            return Container();
                                                          }
                                                        } else {
                                                          return Container();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: StreamBuilder<
                                                        HealthStatusModel>(
                                                      stream: HealthDatabaseService()
                                                          .healthStatusData(patient
                                                              .healthStatusId),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          HealthStatusModel?
                                                              status =
                                                              snapshot.data;
                                                          if (status
                                                                  ?.physicalConditionId !=
                                                              " ") {
                                                            return StreamBuilder<
                                                                    PhysicalConditionModel>(
                                                                stream: HealthDatabaseService()
                                                                    .physicalConditionData(
                                                                        status!
                                                                            .physicalConditionId),
                                                                builder: (context,
                                                                    snapshot) {
                                                                  PhysicalConditionModel?
                                                                      physical =
                                                                      snapshot
                                                                          .data;
                                                                  return Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    padding:
                                                                        const EdgeInsets
                                                                            .fromLTRB(
                                                                            30,
                                                                            30,
                                                                            30,
                                                                            30),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border
                                                                          .all(),
                                                                      borderRadius: const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              10)),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.5),
                                                                          spreadRadius:
                                                                              1,
                                                                          blurRadius:
                                                                              5,
                                                                          offset: const Offset(
                                                                              0,
                                                                              3), // changes position of shadow
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Container(
                                                                          alignment:
                                                                              Alignment.topCenter,
                                                                          child:
                                                                              const Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Icon(
                                                                                Icons.personal_injury,
                                                                                size: 35,
                                                                              ),
                                                                              SizedBox(
                                                                                width: 10,
                                                                              ),
                                                                              Text(
                                                                                'Physical Condition',
                                                                                textAlign: TextAlign.start,
                                                                                style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                30),
                                                                        Row(
                                                                          children: <Widget>[
                                                                            const Expanded(
                                                                              flex: 1,
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: <Widget>[
                                                                                  Text(
                                                                                    'Injury',
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                  ),
                                                                                  SizedBox(height: 10),
                                                                                  Text(
                                                                                    'Details',
                                                                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            const SizedBox(width: 20),
                                                                            Expanded(
                                                                              flex: 2,
                                                                              child: Column(
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: <Widget>[
                                                                                  Text(
                                                                                    ': ${physical?.currentInjury}',
                                                                                    style: const TextStyle(fontSize: 15),
                                                                                  ),
                                                                                  const SizedBox(height: 10),
                                                                                  Text(
                                                                                    ': ${physical?.details}',
                                                                                    style: const TextStyle(fontSize: 15),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  );
                                                                });
                                                          } else {
                                                            return Container();
                                                          }
                                                        } else {
                                                          return Container();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: StreamBuilder<
                                                          HealthStatusModel>(
                                                        stream: HealthDatabaseService()
                                                            .healthStatusData(
                                                                patient
                                                                    .healthStatusId),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            HealthStatusModel?
                                                                status =
                                                                snapshot.data;
                                                            if (status
                                                                    ?.chronicConditionId !=
                                                                " ") {
                                                              return StreamBuilder<
                                                                      ChronicConditionModel>(
                                                                  stream: HealthDatabaseService()
                                                                      .chronicConditionData(
                                                                          status!
                                                                              .chronicConditionId),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    ChronicConditionModel?
                                                                        chronic =
                                                                        snapshot
                                                                            .data;
                                                                    return Container(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      padding: const EdgeInsets
                                                                          .fromLTRB(
                                                                          30,
                                                                          30,
                                                                          30,
                                                                          30),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border:
                                                                            Border.all(),
                                                                        borderRadius: const BorderRadius
                                                                            .all(
                                                                            Radius.circular(10)),
                                                                        boxShadow: [
                                                                          BoxShadow(
                                                                            color:
                                                                                Colors.grey.withOpacity(0.5),
                                                                            spreadRadius:
                                                                                1,
                                                                            blurRadius:
                                                                                5,
                                                                            offset:
                                                                                const Offset(0, 3), // changes position of shadow
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            alignment:
                                                                                Alignment.topCenter,
                                                                            child:
                                                                                const Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Icon(
                                                                                  Icons.emergency,
                                                                                  size: 35,
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 10,
                                                                                ),
                                                                                Text(
                                                                                  'Chronic Condition',
                                                                                  textAlign: TextAlign.start,
                                                                                  style: TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'Comfortaa', fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 30),
                                                                          Row(
                                                                            children: <Widget>[
                                                                              const Expanded(
                                                                                flex: 1,
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    Text(
                                                                                      'Allergies',
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                    ),
                                                                                    SizedBox(height: 10),
                                                                                    Text(
                                                                                      'Details',
                                                                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              const SizedBox(width: 20),
                                                                              Expanded(
                                                                                flex: 2,
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: <Widget>[
                                                                                    Text(
                                                                                      ': ${chronic!.childAllergies}',
                                                                                      style: const TextStyle(fontSize: 15),
                                                                                    ),
                                                                                    const SizedBox(height: 10),
                                                                                    Text(
                                                                                      ': ${chronic.childChronic}',
                                                                                      style: const TextStyle(fontSize: 15),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          )
                                                                        ],
                                                                      ),
                                                                    );
                                                                  });
                                                            } else {
                                                              return Container();
                                                            }
                                                          } else {
                                                            return Container();
                                                          }
                                                        },
                                                      ))
                                                ],
                                              ),
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
                            },
                          ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      );
    }
  }
}
