import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class editHealthCondition extends StatefulWidget {
  const editHealthCondition({super.key, required this.patientId, required this.healthConditionId});
  final String patientId;
  final String healthConditionId;

  @override
  State<editHealthCondition> createState() => _editHealthConditionState();
}

class _editHealthConditionState extends State<editHealthCondition> {
  final _formKey = GlobalKey<FormState>();

  String currentTemperature = '';
  String currentHeartRate= '';
  String currentSymptom = '';
  String currentIllness = '';
  String notes = '';

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 1300){
      return StreamBuilder<patientModel>(
        stream: PatientDatabaseService().patientData(widget.patientId),
        builder:(context, snapshot) {
          if(snapshot.hasData){
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
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}/healthcondition/${widget.healthConditionId}');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: const TextSpan(
                            text: 'Edit Health Condition',
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
                    const SizedBox(height: 20),
                    StreamBuilder<HealthConditionModel>(
                      stream: healthDatabaseService().healthConditionData(widget.healthConditionId),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          HealthConditionModel? condition = snapshot.data;
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Temperature',
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
                                    initialValue: currentTemperature == ''
                                    ? condition?.currentTemperature 
                                    : currentTemperature,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the temperature' : null,
                                    onChanged: (value) =>
                                        setState(() => currentTemperature = value),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Heart Rate',
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
                                    initialValue: currentHeartRate == ''
                                    ? condition?.currentHeartRate
                                    : currentHeartRate,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the heart rate' : null,
                                    onChanged: (value) =>
                                        setState(() => currentHeartRate = value),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Symptom',
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
                                    initialValue: currentSymptom == ''
                                    ? condition?.currentSymptom
                                    : currentSymptom,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the symptom' : null,
                                    onChanged: (value) =>
                                        setState(() => currentSymptom = value),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Illness',
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
                                    initialValue: currentIllness == ''
                                    ? condition?.currentIllness
                                    : currentIllness,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the illness' : null,
                                    onChanged: (value) =>
                                        setState(() => currentIllness = value),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Notes',
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
                                    initialValue: notes == ''
                                    ? condition?.notes
                                    : notes,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the Notes' : null,
                                    onChanged: (value) =>
                                        setState(() => notes = value),
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
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await healthDatabaseService()
                                          .updateHealthConditionData(
                                            condition!.healthConditionId,
                                            currentTemperature == ''
                                              ? condition.currentTemperature
                                              : currentTemperature,
                                            currentHeartRate == ''
                                              ? condition.currentHeartRate
                                              : currentHeartRate,
                                            currentSymptom == ''
                                              ? condition.currentSymptom
                                              : currentSymptom,
                                            currentIllness == ''
                                              ? condition.currentIllness
                                              : currentIllness,
                                            notes == ''
                                              ? condition.notes
                                              : notes,
                                            widget.patientId,
                                          );
                                      }
                                      Navigator.pop(context);
                                  }
                                  )
                                ],
                              ),
                            ),
                          );
                        }else{
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              )
            );
          }else{
            return Container();
          }
        },
      );
    }else{
      return StreamBuilder<patientModel>(
        stream: PatientDatabaseService().patientData(widget.patientId),
        builder:(context, snapshot) {
          if(snapshot.hasData){
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
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}/healthcondition/${widget.healthConditionId}');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: const TextSpan(
                            text: 'Edit Health Condition',
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
                    const SizedBox(height: 20),
                    StreamBuilder<HealthConditionModel>(
                      stream: healthDatabaseService().healthConditionData(widget.healthConditionId),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          HealthConditionModel? condition = snapshot.data;
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Temperature',
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
                                    initialValue: currentTemperature == ''
                                    ? condition?.currentTemperature 
                                    : currentTemperature,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the temperature' : null,
                                    onChanged: (value) =>
                                        setState(() => currentTemperature = value),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Heart Rate',
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
                                    initialValue: currentHeartRate == ''
                                    ? condition?.currentHeartRate
                                    : currentHeartRate,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the heart rate' : null,
                                    onChanged: (value) =>
                                        setState(() => currentHeartRate = value),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Symptom',
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
                                    initialValue: currentSymptom == ''
                                    ? condition?.currentSymptom
                                    : currentSymptom,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the symptom' : null,
                                    onChanged: (value) =>
                                        setState(() => currentSymptom = value),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Illness',
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
                                    initialValue: currentIllness == ''
                                    ? condition?.currentIllness
                                    : currentIllness,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the illness' : null,
                                    onChanged: (value) =>
                                        setState(() => currentIllness = value),
                                  ),
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.only(left: 20.0),
                                    child: Text(
                                      'Notes',
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
                                    initialValue: notes == ''
                                    ? condition?.notes
                                    : notes,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the Notes' : null,
                                    onChanged: (value) =>
                                        setState(() => notes = value),
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
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await healthDatabaseService()
                                          .updateHealthConditionData(
                                            condition!.healthConditionId,
                                            currentTemperature == ''
                                              ? condition.currentTemperature
                                              : currentTemperature,
                                            currentHeartRate == ''
                                              ? condition.currentHeartRate
                                              : currentHeartRate,
                                            currentSymptom == ''
                                              ? condition.currentSymptom
                                              : currentSymptom,
                                            currentIllness == ''
                                              ? condition.currentIllness
                                              : currentIllness,
                                            notes == ''
                                              ? condition.notes
                                              : notes,
                                            widget.patientId,
                                          );
                                      }
                                      Navigator.pop(context);
                                  }
                                  )
                                ],
                              ),
                            ),
                          );
                        }else{
                          return Container();
                        }
                      },
                    )
                  ],
                ),
              )
            );
          }else{
            return Container();
          }
        },
      );
    }
  }
}
