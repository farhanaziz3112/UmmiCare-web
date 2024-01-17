import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';
import 'package:ummicare/services/scheduleDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class addNewAppointment extends StatefulWidget {
  const addNewAppointment({super.key, required this.patientId});
  final String patientId;

  @override
  State<addNewAppointment> createState() => _addNewAppointmentState();
}

class _addNewAppointmentState extends State<addNewAppointment> {
  final _formKey = GlobalKey<FormState>();

  String _vaccineType = '';
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
                                  text: patient.patientName,
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
                                text: const TextSpan(
                                  text: 'Add Appointment',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Appointment',
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
                          Container(
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
                                      'Vaccine Type',
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
                                    initialValue: _vaccineType,
                                    decoration: textInputDecoration,
                                    validator: (value) => value == ''
                                        ? 'Please enter vaccine type'
                                        : null,
                                    onChanged: (value) =>
                                        setState(() => _vaccineType = value),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => _selectDate(context),
                                        child: Text('Select Date'),
                                      ),
                                      SizedBox(width: 20),
                                      ElevatedButton(
                                        onPressed: () => _selectTime(context),
                                        child: Text('Select Time'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
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
                                          String _formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(selectedDate);
                                          String formattedMinute = _selectedTime
                                              .minute
                                              .toString()
                                              .padLeft(2, '0');
                                          String formattedTime =
                                              '${_selectedTime.hourOfPeriod}:$formattedMinute ${_selectedTime.period.index == 0 ? 'AM' : 'PM'}';
                                          await PatientDatabaseService()
                                              .createVaccinationAppointmentData(
                                            _vaccineType,
                                            _formattedDate,
                                            formattedTime,
                                            patient.healthId,
                                            patient.clinicId,
                                          );
                                          scheduleDatabase().createScheduleData(
                                              'Vaccination Appointment - ${child!.childFirstname}',
                                              child!.parentId,
                                              child.childId,
                                              selectedDate
                                                  .millisecondsSinceEpoch
                                                  .toString(),
                                              selectedDate
                                                  .millisecondsSinceEpoch
                                                  .toString(),
                                              'health',
                                              'true');
                                          Navigator.pop(context);
                                        }
                                      })
                                ],
                              ),
                            ),
                          ),
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
                                  text: patient.patientName,
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
                                text: const TextSpan(
                                  text: 'Add Appointment',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: const Text(
                              'Appointment',
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
                          Container(
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
                                      'Vaccine Type',
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
                                    initialValue: _vaccineType,
                                    decoration: textInputDecoration,
                                    validator: (value) => value == ''
                                        ? 'Please enter vaccine type'
                                        : null,
                                    onChanged: (value) =>
                                        setState(() => _vaccineType = value),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => _selectDate(context),
                                        child: Text('Select Date'),
                                      ),
                                      SizedBox(width: 20),
                                      ElevatedButton(
                                        onPressed: () => _selectTime(context),
                                        child: Text('Select Time'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
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
                                          String _formattedDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(selectedDate);
                                          String formattedMinute = _selectedTime
                                              .minute
                                              .toString()
                                              .padLeft(2, '0');
                                          String formattedTime =
                                              '${_selectedTime.hourOfPeriod}:$formattedMinute ${_selectedTime.period.index == 0 ? 'AM' : 'PM'}';
                                          await PatientDatabaseService()
                                              .createVaccinationAppointmentData(
                                            _vaccineType,
                                            _formattedDate,
                                            formattedTime,
                                            patient.healthId,
                                            patient.clinicId,
                                          );
                                          scheduleDatabase().createScheduleData(
                                              'Vaccination Appointment - ${child!.childFirstname}',
                                              child.parentId,
                                              child.childId,
                                              selectedDate
                                                  .millisecondsSinceEpoch
                                                  .toString(),
                                              selectedDate
                                                  .millisecondsSinceEpoch
                                                  .toString(),
                                              'health',
                                              'true');
                                          Navigator.pop(context);
                                        }
                                      })
                                ],
                              ),
                            ),
                          ),
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
