import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';

class viewChronicCondition extends StatefulWidget {
  const viewChronicCondition({super.key, required this.patientId, required this.chronicConditionId});
  final String patientId;
  final String chronicConditionId;

  @override
  State<viewChronicCondition> createState() => _viewChronicConditionState();
}

class _viewChronicConditionState extends State<viewChronicCondition> {

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
                            text: 'Chronic Condition',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}/chroniccondition');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: widget.chronicConditionId,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Chronic Condition',
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
                    StreamBuilder<ChronicConditionModel>(
                      stream: HealthDatabaseService().chronicConditionData(widget.chronicConditionId),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          ChronicConditionModel? chronic = snapshot.data;
                          return SizedBox(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
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
                                          alignment: Alignment
                                              .topCenter,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
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
                                        const SizedBox(height: 30),
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
                                                    'Allergies',
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
                                                    'Details',
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
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: <Widget>[
                                                  Text(
                                                    ': ${chronic!.childAllergies}',
                                                    style: const TextStyle(
                                                        fontSize:
                                                            15),
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          10),
                                                  Text(
                                                    ': ${chronic.childChronic}',
                                                    style: const TextStyle(
                                                        fontSize:
                                                            15),
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
                                context.go('/medicalstaff/patient/${patient.patientId}/chroniccondition/${widget.chronicConditionId}/editchroniccondition');
                              },
                              label: const Text(
                                'Edit Chronic Condition',
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
                                      FirebaseFirestore.instance.collection("Chronic Condition").doc(widget.chronicConditionId);

                                await documentReference.delete();
                                
                                await HealthDatabaseService().updateHealthStatusData(
                                  status!.healthStatusId,
                                  status!.healthConditionId,
                                  status!.physicalConditionId,
                                  status?.chronicConditionId == widget.chronicConditionId
                                    ? ' '
                                    : status!.chronicConditionId,
                                  status!.patientId,
                                );

                                context.go('/medicalstaff/patient/${patient.patientId}/chroniccondition');
                              },
                              label: const Text(
                                'Delete Chronic Condition',
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
                            text: 'Chronic Condition',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}/chroniccondition');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: widget.chronicConditionId,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Chronic Condition',
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
                    StreamBuilder<ChronicConditionModel>(
                      stream: HealthDatabaseService().chronicConditionData(widget.chronicConditionId),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          ChronicConditionModel? chronic = snapshot.data;
                          return SizedBox(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
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
                                          alignment: Alignment
                                              .topCenter,
                                          child: const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .center,
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
                                        const SizedBox(height: 30),
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
                                                    'Allergies',
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
                                                    'Details',
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
                                              flex: 2,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                children: <Widget>[
                                                  Text(
                                                    ': ${chronic!.childAllergies}',
                                                    style: const TextStyle(
                                                        fontSize:
                                                            15),
                                                  ),
                                                  const SizedBox(
                                                      height:
                                                          10),
                                                  Text(
                                                    ': ${chronic.childChronic}',
                                                    style: const TextStyle(
                                                        fontSize:
                                                            15),
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
                                context.go('/medicalstaff/patient/${patient.patientId}/chroniccondition/${widget.chronicConditionId}/editchroniccondition');
                              },
                              label: const Text(
                                'Edit Chronic Condition',
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
                                      FirebaseFirestore.instance.collection("Chronic Condition").doc(widget.chronicConditionId);

                                await documentReference.delete();
                                
                                await HealthDatabaseService().updateHealthStatusData(
                                  status!.healthStatusId,
                                  status!.healthConditionId,
                                  status!.physicalConditionId,
                                  status?.chronicConditionId == widget.chronicConditionId
                                    ? ' '
                                    : status!.chronicConditionId,
                                  status!.patientId,
                                );

                                context.go('/medicalstaff/patient/${patient.patientId}/chroniccondition');
                              },
                              label: const Text(
                                'Delete Chronic Condition',
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
