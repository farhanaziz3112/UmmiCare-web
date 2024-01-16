import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';

class patientTile extends StatefulWidget {
  const patientTile(
      {super.key,
      required this.patientDetail,
      required this.patientColorIndex});
  final patientModel patientDetail;
  final int patientColorIndex;

  @override
  State<patientTile> createState() => _patientTileState();
}

class _patientTileState extends State<patientTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<patientModel>(
      stream:
          PatientDatabaseService().patientData(widget.patientDetail.patientId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.hasError) {
            return Container(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          patientModel? patient = snapshot.data;
          if (widget.patientColorIndex == 0) {
            return InkWell(
              onTap: () {
                context.go('/medicalstaff/patient/${patient.patientId}');
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  decoration: BoxDecoration(
                    color: widget.patientColorIndex == 0
                        ? const Color(0xffF29180)
                        : widget.patientColorIndex == 1
                            ? const Color(0xff71CBCA)
                            : const Color(0xff8290F0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ImageNetwork(
                          image: patient!.patientProfileImage,
                          height: 70,
                          width: 70,
                          borderRadius: BorderRadius.circular(70)),
                      const SizedBox(width: 10),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            patient.patientName,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          Text(
                            '${patient.patientCurrentAge.toString()} years old',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                context.go('/medicalstaff/patient/${patient.patientId}');
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  decoration: BoxDecoration(
                    color: const Color(0xff8290F0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ImageNetwork(
                            image: patient!.patientProfileImage,
                            height: 70,
                            width: 70,
                            borderRadius: BorderRadius.circular(70)),
                        const SizedBox(height: 20),
                        const Text(
                          'Full Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(patient.patientName),
                        const SizedBox(height: 10),
                        const Text(
                          'Current Age',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text((patient.patientCurrentAge).toString()),
                        const SizedBox(height: 10),
                        const Text(
                          'Current BMI Status',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        StreamBuilder<List<BmiHealthModel>>(
                          stream: HealthDatabaseService()
                              .allBmiHealthData(patient.healthId),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<BmiHealthModel>? bmi = snapshot.data;
                              String bmiStatus = '';
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
                              return Text(bmiStatus);
                            } else {
                              return Container();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        } else {
          return Container();
        }
      }),
    );
  }
}
