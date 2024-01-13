import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/charts/allPatientBmiStatusPercentage.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';
import 'package:ummicare/shared/function.dart';

class medicalStaffDashboard extends StatefulWidget {
  const medicalStaffDashboard({super.key});

  @override
  State<medicalStaffDashboard> createState() => _medicalStaffDashboardState();
}

class _medicalStaffDashboardState extends State<medicalStaffDashboard> {
  AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder<medicalStaffModel>(
      stream: medicalStaffDatabase().medicalStaffData(user!.userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          medicalStaffModel? doc = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome, ${doc!.medicalStaffFullName}!',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 50.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Last login: ${_auth.getUserLastSignedIn()}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
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
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Clinic Statistics',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(),
                            borderRadius: const BorderRadius.all(
                                Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.grey.withOpacity(0.5),
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
                                      'Percentage of Number of Patients per BMI Status',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontFamily: 'Comfortaa',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.center,
                                    children: [
                                      allPatientBmiStatusPercentage(
                                          clinicId: doc.clinicId),
                                      const SizedBox(width: 30),
                                      StreamBuilder<List<patientModel>>(
                                        stream: PatientDatabaseService().allPatientData(doc.clinicId),
                                        builder: (context, snapshot) {
                                          if(snapshot.hasData){
                                            List<patientModel>? patient = snapshot.data;
                                            return StreamBuilder<List<BmiModel>>(
                                              stream: HealthDatabaseService().allBmiData(),
                                              builder: (context, snapshot) {
                                                if(snapshot.hasData){
                                                  List<BmiModel>? bmi = snapshot.data;
                                                  return SizedBox(
                                                    child:Row(
                                                      children: <Widget>[
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start, // Add this line
                                                          crossAxisAlignment: CrossAxisAlignment.start, // Add this line
                                                          children: <Widget>[
                                                            Text(
                                                              'Severe Thinness: ${getNumberOfPatientBasedOnBmiStatus(patient!, bmi!, 'Severe Thinness')}',
                                                              style: const TextStyle(fontSize: 20),
                                                            ),
                                                            const SizedBox(height: 10),
                                                            Text(
                                                              'Moderate Thinness: ${getNumberOfPatientBasedOnBmiStatus(patient, bmi, 'Moderate Thinness')}',
                                                              style: const TextStyle(fontSize: 20),
                                                            ),
                                                            const SizedBox(height: 10),
                                                            Text(
                                                              'Mild Thinness: ${getNumberOfPatientBasedOnBmiStatus(patient, bmi, 'Mild Thinness')}',
                                                              style: const TextStyle(fontSize: 20),
                                                            ),
                                                            const SizedBox(height: 10),
                                                            Text(
                                                              'Normal: ${getNumberOfPatientBasedOnBmiStatus(patient, bmi, 'Normal')}',
                                                              style: const TextStyle(fontSize: 20),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(width: 30),
                                                        Column(
                                                          mainAxisAlignment: MainAxisAlignment.start, // Add this line
                                                          crossAxisAlignment: CrossAxisAlignment.start, // Add this line
                                                          children: <Widget>[
                                                            Text(
                                                              'Overweight: ${getNumberOfPatientBasedOnBmiStatus(patient, bmi, 'Overweight')}',
                                                              style: const TextStyle(fontSize: 20),
                                                            ),
                                                            const SizedBox(height: 10),
                                                            Text(
                                                              'Obese Class I: ${getNumberOfPatientBasedOnBmiStatus(patient, bmi, 'Obese Class I')}',
                                                              style: const TextStyle(fontSize: 20),
                                                            ),
                                                            const SizedBox(height: 10),
                                                            Text(
                                                              'Obese Class II: ${getNumberOfPatientBasedOnBmiStatus(patient, bmi, 'Obese Class II')}',
                                                              style: const TextStyle(fontSize: 20),
                                                            ),
                                                            const SizedBox(height: 10),
                                                            Text(
                                                              'Obese Class III: ${getNumberOfPatientBasedOnBmiStatus(patient, bmi, 'Obese Class III')}',
                                                              style: const TextStyle(fontSize: 20),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    )
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              },
                                            );
                                          }else{
                                            return Container();
                                          }
                                        },
                                      ),
                                      
                                    ],
                                  ),
                            ],
                          )
                          
                        ),
                      ),
                    ],
                  )
              ],
            ),
          );
        } else {
           return Container();
        }
      },
    );
  }
}