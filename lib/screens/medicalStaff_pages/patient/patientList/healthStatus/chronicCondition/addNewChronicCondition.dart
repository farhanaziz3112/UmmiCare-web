import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/notificationDatabase.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class addNewChronicCondition extends StatefulWidget {
  const addNewChronicCondition({super.key, required this.patientId});
  final String patientId;

  @override
  State<addNewChronicCondition> createState() => _addNewChronicConditionState();
}

class _addNewChronicConditionState extends State<addNewChronicCondition> {
  final _formKey = GlobalKey<FormState>();

  String childAllergies = '';
  String childChronic = '';

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 1300) {
      return StreamBuilder<patientModel>(
        stream: PatientDatabaseService().patientData(widget.patientId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            patientModel? patient = snapshot.data;
            return StreamBuilder<childModel>(
                stream: childDatabase(childId: patient!.childId).childData,
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
                                text: const TextSpan(
                                  text: 'Add Chronic Condition',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Add Chronic Condition',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 45.0,
                                  fontFamily: 'Comfortaa',
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
                          const SizedBox(height: 20),
                          StreamBuilder<HealthStatusModel>(
                            stream: HealthDatabaseService()
                                .healthStatusData(patient.healthStatusId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                HealthStatusModel? status = snapshot.data;
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 30.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Allergies',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        TextFormField(
                                          initialValue: childAllergies,
                                          decoration: textInputDecoration,
                                          validator: (value) => value == ''
                                              ? 'Please enter the temperature'
                                              : null,
                                          onChanged: (value) => setState(
                                              () => childAllergies = value),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Details',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        TextFormField(
                                          initialValue: childChronic,
                                          decoration: textInputDecoration,
                                          validator: (value) => value == ''
                                              ? 'Please enter the heart rate'
                                              : null,
                                          onChanged: (value) => setState(
                                              () => childChronic = value),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                            ),
                                            child: Text(
                                              'Submit',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                final chronicConditionDocument =
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'Chronic Condition')
                                                        .doc();
                                                await HealthDatabaseService()
                                                    .createChronicConditionData(
                                                  chronicConditionDocument.id,
                                                  childAllergies,
                                                  childChronic,
                                                  widget.patientId,
                                                );

                                                await HealthDatabaseService()
                                                    .updateHealthStatusData(
                                                  patient.healthStatusId,
                                                  status!.healthConditionId,
                                                  status.physicalConditionId,
                                                  chronicConditionDocument.id,
                                                  patient.patientId,
                                                );

                                                notificationDatabase()
                                                    .createNotificationData(
                                                        child!.parentId,
                                                        child.childId,
                                                        'health',
                                                        'New Chronic Condition Added',
                                                        'Chronic condition: ${childChronic} has been added to ${child.childFirstname}',
                                                        'unseen',
                                                        DateTime.now()
                                                            .millisecondsSinceEpoch
                                                            .toString());
                                              }
                                              Navigator.pop(context);
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          )
                        ],
                      ),
                    ));
                  } else {
                    return Container();
                  }
                });
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
            return StreamBuilder<childModel>(
                stream: childDatabase(childId: patient!.childId).childData,
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
                                text: const TextSpan(
                                  text: 'Add Chronic Condition',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Add Chronic Condition',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 45.0,
                                  fontFamily: 'Comfortaa',
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
                          const SizedBox(height: 20),
                          StreamBuilder<HealthStatusModel>(
                            stream: HealthDatabaseService()
                                .healthStatusData(patient.healthStatusId),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                HealthStatusModel? status = snapshot.data;
                                return Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 30.0),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Allergies',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        TextFormField(
                                          initialValue: childAllergies,
                                          decoration: textInputDecoration,
                                          validator: (value) => value == ''
                                              ? 'Please enter the temperature'
                                              : null,
                                          onChanged: (value) => setState(
                                              () => childAllergies = value),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.only(left: 20.0),
                                          child: Text(
                                            'Details',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        TextFormField(
                                          initialValue: childChronic,
                                          decoration: textInputDecoration,
                                          validator: (value) => value == ''
                                              ? 'Please enter the heart rate'
                                              : null,
                                          onChanged: (value) => setState(
                                              () => childChronic = value),
                                        ),
                                        SizedBox(
                                          height: 30.0,
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                            ),
                                            child: Text(
                                              'Submit',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                final chronicConditionDocument =
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                            'Chronic Condition')
                                                        .doc();
                                                await HealthDatabaseService()
                                                    .createChronicConditionData(
                                                  chronicConditionDocument.id,
                                                  childAllergies,
                                                  childChronic,
                                                  widget.patientId,
                                                );

                                                await HealthDatabaseService()
                                                    .updateHealthStatusData(
                                                  patient.healthStatusId,
                                                  status!.healthConditionId,
                                                  status.physicalConditionId,
                                                  chronicConditionDocument.id,
                                                  patient.patientId,
                                                );

                                                notificationDatabase()
                                                    .createNotificationData(
                                                        child!.parentId,
                                                        child.childId,
                                                        'health',
                                                        'New Chronic Condition Added',
                                                        'Chronic condition: ${childChronic} has been added to ${child.childFirstname}',
                                                        'unseen',
                                                        DateTime.now()
                                                            .millisecondsSinceEpoch
                                                            .toString());
                                              }
                                              Navigator.pop(context);
                                            })
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          )
                        ],
                      ),
                    ));
                  } else {
                    return Container();
                  }
                });
          } else {
            return Container();
          }
        },
      );
    }
  }
}
