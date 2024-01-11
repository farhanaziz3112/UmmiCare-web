import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class editPhysicalCondition extends StatefulWidget {
  const editPhysicalCondition({super.key, required this.patientId, required this.physicalConditionId});
  final String patientId;
  final String physicalConditionId;

  @override
  State<editPhysicalCondition> createState() => _editPhysicalConditionState();
}

class _editPhysicalConditionState extends State<editPhysicalCondition> {
  final _formKey = GlobalKey<FormState>();

  String currentInjury = '';
  String details= '';

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
                            text: 'Physical Condition',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}/physicalcondition');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: widget.physicalConditionId,
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}/physicalcondition/${widget.physicalConditionId}');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: const TextSpan(
                            text: 'Edit Physical Condition',
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
                    const SizedBox(height: 20),
                    StreamBuilder<PhysicalConditionModel>(
                      stream: healthDatabaseService().physicalConditionData(widget.physicalConditionId),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          PhysicalConditionModel? physical = snapshot.data;
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
                                      'Injury',
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
                                    initialValue: currentInjury == ''
                                    ? physical?.currentInjury 
                                    : currentInjury,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the temperature' : null,
                                    onChanged: (value) =>
                                        setState(() => currentInjury = value),
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
                                    initialValue: details == ''
                                    ? physical?.details
                                    : details,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the heart rate' : null,
                                    onChanged: (value) =>
                                        setState(() => details = value),
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
                                          .updatePhysicalConditionData(
                                            physical!.physicalConditionId,
                                            currentInjury == ''
                                              ? physical.currentInjury
                                              : currentInjury,
                                            details == ''
                                              ? physical.details
                                              : details,
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
                            text: 'Physical Condition',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}/physicalcondition');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: widget.physicalConditionId,
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}/healthcondition/${widget.physicalConditionId}');
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
                    StreamBuilder<PhysicalConditionModel>(
                      stream: healthDatabaseService().physicalConditionData(widget.physicalConditionId),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          PhysicalConditionModel? physical = snapshot.data;
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
                                      'Injury',
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
                                    initialValue: currentInjury == ''
                                    ? physical?.currentInjury 
                                    : currentInjury,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the temperature' : null,
                                    onChanged: (value) =>
                                        setState(() => currentInjury = value),
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
                                    initialValue: details == ''
                                    ? physical?.details
                                    : details,
                                    decoration: textInputDecoration,
                                    validator: (value) =>
                                        value == '' ? 'Please enter the heart rate' : null,
                                    onChanged: (value) =>
                                        setState(() => details = value),
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
                                          .updatePhysicalConditionData(
                                            physical!.physicalConditionId,
                                            currentInjury == ''
                                              ? physical.currentInjury
                                              : currentInjury,
                                            details == ''
                                              ? physical.details
                                              : details,
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
