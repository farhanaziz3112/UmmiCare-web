import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';

class healthConditionMain extends StatefulWidget {
  const healthConditionMain({super.key, required this.healthStatusId});
  final String healthStatusId;

  @override
  State<healthConditionMain> createState() => _healthConditionMainState();
}

class _healthConditionMainState extends State<healthConditionMain> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HealthStatusModel>(
      stream: healthDatabaseService().healthStatusData(widget.healthStatusId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          HealthStatusModel? health = snapshot.data;
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
                      StreamBuilder<patientModel>(
                        stream: PatientDatabaseService()
                            .patientData(health!.patientId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            patientModel? patient = snapshot.data;
                            return RichText(
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
                            );
                          } else {
                            return Container();
                          }
                        }
                      ),
                      const SizedBox(width: 10),
                      const Text('>'),
                      const SizedBox(width: 10),
                      RichText(
                        text: const TextSpan(
                          text: 'Health Condition',
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
                  // StreamBuilder<HealthConditionModel>(
                  //   stream: healthDatabaseService().healthConditionData(health.healthConditionId),
                  //   builder: ((context, snapshot) {
                  //     if(snapshot.hasData){
                  //       HealthConditionModel? condition = snapshot.data;
                  //       return Column(
                  //         children: [
                  //           Container(
                  //             alignment: Alignment.topCenter,
                  //             child: const Text(
                  //               'Latest Health Condition',
                  //               textAlign: TextAlign.start,
                  //               style: TextStyle(
                  //                   color: Colors.black,
                  //                   fontSize: 20.0,
                  //                   fontFamily: 'Comfortaa',
                  //                   fontWeight: FontWeight.bold),
                  //             ),
                  //           ),
                  //           const SizedBox(height: 30),
                  //           Row(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: <Widget>[
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: <Widget>[
                  //                   Container(
                  //                     alignment: Alignment.centerLeft,
                  //                     padding:
                  //                       const EdgeInsets.only(
                  //                           left: 20),
                  //                     child: const Text(
                  //                       'Illness',
                  //                       textAlign: TextAlign.left,
                  //                       style: TextStyle(
                  //                         fontSize: 15,
                  //                         fontWeight:FontWeight.bold,
                  //                         color: Colors.black),
                  //                     ),
                  //                   ),
                  //                   const SizedBox(height: 10),
                  //                   Container(
                  //                     alignment:
                  //                         Alignment.centerLeft,
                  //                     padding:
                  //                         const EdgeInsets.only(
                  //                             left: 20),
                  //                     child: Text(
                  //                       condition!.currentIllness,
                  //                       textAlign: TextAlign.left,
                  //                       style: const TextStyle(
                  //                           fontSize: 15,
                  //                           fontWeight:
                  //                               FontWeight.normal,
                  //                           color: Colors.black),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               const SizedBox(height: 40),
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: <Widget>[
                  //                   Container(
                  //                     alignment: Alignment.centerLeft,
                  //                     padding:
                  //                       const EdgeInsets.only(
                  //                           left: 20),
                  //                     child: const Text(
                  //                       'Symptom',
                  //                       textAlign: TextAlign.left,
                  //                       style: TextStyle(
                  //                         fontSize: 15,
                  //                         fontWeight:FontWeight.bold,
                  //                         color: Colors.black),
                  //                     ),
                  //                   ),
                  //                   const SizedBox(height: 10),
                  //                   Container(
                  //                     alignment:
                  //                         Alignment.centerLeft,
                  //                     padding:
                  //                         const EdgeInsets.only(
                  //                             left: 20),
                  //                     child: Text(
                  //                       condition.currentSymptom,
                  //                       textAlign: TextAlign.left,
                  //                       style: const TextStyle(
                  //                           fontSize: 15,
                  //                           fontWeight:
                  //                               FontWeight.normal,
                  //                           color: Colors.black),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               const SizedBox(height: 40),
                  //               Column(
                  //                 crossAxisAlignment: CrossAxisAlignment.start,
                  //                 children: <Widget>[
                  //                   Container(
                  //                     alignment: Alignment.centerLeft,
                  //                     padding:
                  //                       const EdgeInsets.only(
                  //                           left: 20),
                  //                     child: const Text(
                  //                       'Notes',
                  //                       textAlign: TextAlign.left,
                  //                       style: TextStyle(
                  //                         fontSize: 15,
                  //                         fontWeight:FontWeight.bold,
                  //                         color: Colors.black),
                  //                     ),
                  //                   ),
                  //                   const SizedBox(height: 10),
                  //                   Container(
                  //                     alignment:
                  //                         Alignment.centerLeft,
                  //                     padding:
                  //                         const EdgeInsets.only(
                  //                             left: 20),
                  //                     child: Text(
                  //                       condition.notes,
                  //                       textAlign: TextAlign.left,
                  //                       style: const TextStyle(
                  //                           fontSize: 15,
                  //                           fontWeight:
                  //                               FontWeight.normal,
                  //                           color: Colors.black),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             ],
                  //           )
                  //         ],
                  //       );
                  //     } else {
                  //       return Container();
                  //     }
                  //   }),
                  // ),
                  const SizedBox(height: 80),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'History',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        } else {
          return Container(
            child: Text("ss"),
          );
        }
      },
    );
  }
}