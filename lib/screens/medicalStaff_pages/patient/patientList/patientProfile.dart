import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/screens/charts/childBmi.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';

class patientProfile extends StatefulWidget {
  const patientProfile({super.key, required this.patientId});
  final String patientId;

  @override
  State<patientProfile> createState() => _patientProfileState();
}

class _patientProfileState extends State<patientProfile> {
  List<double> bmiData = [];
  List<int> dateLabels = [];

  @override
  Widget build(BuildContext context) {
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
                          text: patient?.patientName,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      patient!.patientName,
                      style: const TextStyle(
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
                  SizedBox(
                    height: 300,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
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
                              children: <Widget>[
                                SizedBox(
                                height: 200,
                                child: childBmi(healthId: patient.healthId)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 70,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.fromLTRB(40, 30, 10, 50),
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
                                    '${patient.patientName}\'s Profile',
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    ImageNetwork(
                                        image: patient.patientProfileImage,
                                        height: 150,
                                        width: 150,
                                        borderRadius:
                                            BorderRadius.circular(70)),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: const Text(
                                                    'Full Name',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
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
                                                    patient.patientName,
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 40),
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
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
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
                                                    patient.patientCurrentAge
                                                        .toString(),
                                                    textAlign: TextAlign.left,
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        StreamBuilder<List<BmiHealthModel>>(
                                          stream: healthDatabaseService().allBmiHealthData(patient.healthId),
                                          builder: (context, snapshot) {
                                            if(snapshot.hasData){
                                              List<BmiHealthModel>? bmi = snapshot.data;
                                              String bmiStatus = 'ss';
                                              double lastBmiData = bmi![0].bmiData;
                                              if (lastBmiData < 16) {
                                                bmiStatus = "Severe Thinness";
                                              } else if (lastBmiData < 17) {
                                                bmiStatus = "Moderate Thinness";
                                              } else if (lastBmiData < 18.5) {
                                                bmiStatus = "Mild Thinness";
                                              } else if (lastBmiData < 25) {
                                                bmiStatus = "Normal";
                                              } else if (lastBmiData < 30) {
                                                bmiStatus = "Overweight";
                                              } else if (lastBmiData < 35) {
                                                bmiStatus = "Obese Class I";
                                              } else if (lastBmiData < 40) {
                                                bmiStatus = "Obese Class II";
                                              } else if (lastBmiData >= 40) {
                                                bmiStatus = "Obese Class III";
                                              } else {
                                                bmiStatus = "No Status";
                                              }
                                              return Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20),
                                                    child: const Text(
                                                      'Current BMI',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
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
                                                      bmiStatus,
                                                      textAlign: TextAlign.left,
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            } else {
                                              return Container();
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
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
                    child: Text(
                      '${patient.patientName}\'s Health Status',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 20),
                  StreamBuilder<healthModel>(
                    stream: healthDatabaseService().healthData(patient.healthId),
                    builder: ((context, snapshot) {
                      if(snapshot.hasData){
                        healthModel? health = snapshot.data;
                        return SizedBox(
                          height: 100,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  child: Center(
                                    child: ElevatedButton.icon(
                                      icon: const Icon(
                                        Icons.health_and_safety,
                                        size: 50.0,
                                        color: Colors.white,
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: const Color(0xfff29180),
                                        fixedSize: const Size(double.maxFinite, double.maxFinite),
                                        alignment: Alignment.center,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          side: BorderSide.none,
                                        ),
                                      ),
                                      onPressed: () {
                                        var id = patient.patientId;
                                        var healthId = health?.healthStatusId;
                                        context.go('/medicalstaff/patient/${id}/$healthId');
                                      },
                                      label: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              'Health Condition',
                                              style: TextStyle(fontSize: 20.0, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 50),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  child: Center(
                                    child: ElevatedButton.icon(
                                      icon: const Icon(
                                        Icons.personal_injury,
                                        size: 50.0,
                                        color: Colors.white,
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: const Color(0xff71CBCA),
                                        fixedSize: const Size(double.maxFinite, double.maxFinite),
                                        alignment: Alignment.center,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          side: BorderSide.none,
                                        ),
                                      ),
                                      onPressed: () {
                                        var id = patient.patientId;
                                        var healthId = health?.healthStatusId;
                                        context.go('/medicalstaff/patient/${id}/${healthId}');
                                      },
                                      label: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              'Physical Condition',
                                              style: TextStyle(fontSize: 20.0, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 50),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  alignment: Alignment.centerRight,
                                  child: Center(
                                    child: ElevatedButton.icon(
                                      icon: const Icon(
                                        Icons.emergency,
                                        size: 50.0,
                                        color: Colors.white,
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: const Color(0xff8290F0),
                                        fixedSize: const Size(double.maxFinite, double.maxFinite),
                                        alignment: Alignment.center,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          side: BorderSide.none,
                                        ),
                                      ),
                                      onPressed: () {
                                        var id = patient.patientId;
                                        var healthId = health?.healthStatusId;
                                        context.go('/medicalstaff/patient/${id}/${healthId}');
                                      },
                                      label: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            child: Text(
                                              'Chronic Condition',
                                              style: TextStyle(fontSize: 20.0, color: Colors.white),
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
          );
        } else {
          return Container();
        }
      },
    );
  }
}
