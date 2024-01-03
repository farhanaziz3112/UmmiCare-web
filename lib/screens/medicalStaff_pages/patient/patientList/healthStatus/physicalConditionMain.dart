import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';

class physicalConditionMain extends StatefulWidget {
  const physicalConditionMain({super.key, required this.healthStatusId});
  final String healthStatusId;

  @override
  State<physicalConditionMain> createState() => _physicalConditionMainState();
}

class _physicalConditionMainState extends State<physicalConditionMain> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HealthStatusModel>(
      stream: healthDatabaseService().healthStatusData(widget.healthStatusId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          HealthStatusModel? physical = snapshot.data;
          return SingleChildScrollView(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
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
                            .patientData(physical!.patientId),
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
                                        '/advisor/parent/${patient.patientId}');
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
                          text: 'Physical Condition',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Physical Condition',
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