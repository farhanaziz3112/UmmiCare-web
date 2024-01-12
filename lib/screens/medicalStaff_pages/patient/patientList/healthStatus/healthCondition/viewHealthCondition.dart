import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';

class viewHealthCondition extends StatefulWidget {
  const viewHealthCondition({super.key, required this.patientId, required this.healthConditionId});
  final String patientId;
  final String healthConditionId;

  @override
  State<viewHealthCondition> createState() => _viewHealthConditionState();
}

class _viewHealthConditionState extends State<viewHealthCondition> {

  HealthStatusModel? status;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 1300) {
      return StreamBuilder<patientModel>(
        stream: PatientDatabaseService().patientData(widget.patientId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            patientModel? patient = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: 'Patient',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/medicalstaff/patient');
                                }),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: patient!.patientName,
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: 'Health Condition',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}/healthcondition');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: widget.healthConditionId,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Health Condition',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 45.0,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
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
                    StreamBuilder<HealthConditionModel>(
                      stream: HealthDatabaseService().healthConditionData(widget.healthConditionId),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          HealthConditionModel? condition = snapshot.data;
                          return SizedBox(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 30, 30, 30),
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
                                      children: [
                                        Container(
                                          alignment: Alignment.topCenter,
                                          child: const Text(
                                            'Health Condition',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontFamily: 'Comfortaa',
                                                fontWeight:
                                                    FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: const Text(
                                                    'Temperature',
                                                    textAlign:
                                                        TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                        color:
                                                            Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: Text(
                                                    condition!
                                                        .currentTemperature,
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: const Text(
                                                    'Illness',
                                                    textAlign:
                                                        TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                        color:
                                                            Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: Text(
                                                    condition
                                                        .currentIllness,
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
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: const Text(
                                                    'Symptom',
                                                    textAlign:
                                                        TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                        color:
                                                            Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: Text(
                                                    condition
                                                        .currentSymptom,
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
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: const Text(
                                                    'Notes',
                                                    textAlign:
                                                        TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                        color:
                                                            Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: Text(
                                                    condition.notes,
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
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                    ),
                    const SizedBox(height: 30),
                    StreamBuilder<HealthStatusModel>(
                      stream: HealthDatabaseService().healthStatusData(patient.healthStatusId),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          status = snapshot.data;
                          return Container();
                        }else{
                          return Container();
                        }
                      }
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.edit,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xff71CBCA),
                                fixedSize: const Size(250, 50),
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                              ),
                              onPressed: () {
                                context.go('/medicalstaff/patient/${patient.patientId}/healthcondition/${widget.healthConditionId}/edithealthcondition');
                              },
                              label: const Text(
                                'Edit Health Condition',
                                style:
                                    TextStyle(fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.delete,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xff8290F0),
                                fixedSize: const Size(250, 50),
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                              ),
                              onPressed: () async {
                                DocumentReference documentReference =
                                      FirebaseFirestore.instance.collection("Health Condition").doc(widget.healthConditionId);

                                await documentReference.delete();
                                
                                await HealthDatabaseService().updateHealthStatusData(
                                  status!.healthStatusId,
                                  status?.healthConditionId == widget.healthConditionId
                                    ? ''
                                    : status!.healthConditionId,
                                  status!.physicalConditionId,
                                  status!.chronicConditionId,
                                  status!.patientId,
                                );

                                context.go('/medicalstaff/patient/${patient.patientId}/healthcondition');
                              },
                              label: const Text(
                                'Delete Health Condition',
                                style:
                                    TextStyle(fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
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
      return StreamBuilder<patientModel>(
        stream: PatientDatabaseService().patientData(widget.patientId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            patientModel? patient = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: 'Patient',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/medicalstaff/patient');
                                }),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: patient!.patientName,
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: 'Health Condition',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}/healthcondition');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: widget.healthConditionId,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Health Condition',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 45.0,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
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
                    StreamBuilder<HealthConditionModel>(
                      stream: HealthDatabaseService().healthConditionData(widget.healthConditionId),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          HealthConditionModel? condition = snapshot.data;
                          return SizedBox(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 30, 30, 30),
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
                                      children: [
                                        Container(
                                          alignment: Alignment.topCenter,
                                          child: const Text(
                                            'Health Condition',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontFamily: 'Comfortaa',
                                                fontWeight:
                                                    FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: const Text(
                                                    'Temperature',
                                                    textAlign:
                                                        TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                        color:
                                                            Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: Text(
                                                    condition!
                                                        .currentTemperature,
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
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: const Text(
                                                    'Heart Rate',
                                                    textAlign:
                                                        TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                        color:
                                                            Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: Text(
                                                    condition
                                                        .currentHeartRate,
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
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: const Text(
                                                    'Illness',
                                                    textAlign:
                                                        TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                        color:
                                                            Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: Text(
                                                    condition
                                                        .currentIllness,
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
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: const Text(
                                                    'Symptom',
                                                    textAlign:
                                                        TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                        color:
                                                            Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: Text(
                                                    condition
                                                        .currentSymptom,
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
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: const Text(
                                                    'Notes',
                                                    textAlign:
                                                        TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold,
                                                        color:
                                                            Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  alignment: Alignment
                                                      .centerLeft,
                                                  padding:
                                                      const EdgeInsets
                                                          .only(left: 20),
                                                  child: Text(
                                                    condition.notes,
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
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                    ),
                    const SizedBox(height: 30),
                    StreamBuilder<HealthStatusModel>(
                      stream: HealthDatabaseService().healthStatusData(patient.healthStatusId),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          status = snapshot.data;
                          return Container();
                        }else{
                          return Container();
                        }
                      }
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.edit,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xff71CBCA),
                                fixedSize: const Size(250, 50),
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                              ),
                              onPressed: () {
                                context.go('/medicalstaff/patient/${patient.patientId}/healthcondition/${widget.healthConditionId}/edithealthcondition');
                              },
                              label: const Text(
                                'Edit Health Condition',
                                style:
                                    TextStyle(fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.delete,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xff8290F0),
                                fixedSize: const Size(250, 50),
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                              ),
                              onPressed: () async {
                                DocumentReference documentReference =
                                      FirebaseFirestore.instance.collection("Health Condition").doc(widget.healthConditionId);

                                await documentReference.delete();

                                await HealthDatabaseService().updateHealthStatusData(
                                  status!.healthStatusId,
                                  status?.healthConditionId == widget.healthConditionId
                                    ? ''
                                    : status!.healthConditionId,
                                  status!.physicalConditionId,
                                  status!.chronicConditionId,
                                  status!.patientId,
                                );
                                
                                context.go('/medicalstaff/patient/${patient.patientId}/healthcondition');
                              },
                              label: const Text(
                                'Delete Health Condition',
                                style:
                                    TextStyle(fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
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
