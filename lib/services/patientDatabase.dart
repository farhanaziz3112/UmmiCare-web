import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/patientModel.dart';

class VaccinationAppointmentDatabaseService {
  final String healthId;
  final String? vaccinationAppointmentId;

  VaccinationAppointmentDatabaseService(
    {required this.healthId, this.vaccinationAppointmentId}
  );
  //------------------------------Patient----------------------------------
  final CollectionReference patientCollection =
      FirebaseFirestore.instance.collection('patient');

  //get specific patient document stream
  Stream<patientModel> patientData(String patientId) {
    return patientCollection
        .doc(patientId)
        .snapshots()
        .map(_createPatientModelObject);
  }
  
  //create a patient model object
  patientModel _createPatientModelObject(DocumentSnapshot snapshot) {
    return patientModel(
        patientId: snapshot.id,
        childId: snapshot['childId'],
        clinicId: snapshot['clinicId'],
        vaccinationAppointmentId: snapshot['vaccinationAppointmentId'],
    );
  }

  //create a list of patient model object
  List<patientModel> _createPatientListModelObject(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return patientModel(
        patientId: doc.data().toString().contains('patientId')
            ? doc.get('patientId')
            : '',
        childId:
            doc.data().toString().contains('childId') ? doc.get('childId') : '',
        clinicId: doc.data().toString().contains('clinicId')
            ? doc.get('clinicId')
            : '',
        vaccinationAppointmentId: doc.data().toString().contains('vaccinationAppointmentId')
            ? doc.get('vaccinationAppointmentId')
            : '',
      );
    }).toList();
  }

  Future<void> updateStudentData(
      String patientId,
      String childId,
      String clinicId,
      String vaccinationAppointmentId,) async {
    return await patientCollection.doc(patientId).set({
      'patientId': patientId,
      'childId': childId,
      'clinicId': clinicId,
      'vaccinationAppointmentId': vaccinationAppointmentId,
    });
  }

  Future<void> createStudentData(
      String childId,
      String clinicId,
      String vaccinationAppointmentId,) async {
    final document = patientCollection.doc();
    return await patientCollection.doc(document.id).set({
      'patientId': document.id,
      'childId': childId,
      'clinicId': clinicId,
      'vaccinationAppointmentId': vaccinationAppointmentId,
    });
  }

  //------------------------------Vaccination Appointment----------------------------------
  //collection reference
  final CollectionReference vaccinationAppointmentCollection =
      FirebaseFirestore.instance.collection('Vaccination Appointment');

  //get specific Vaccincation Appointment document stream
  Stream<VaccinationAppointmentModel> get vaccincationAppointmentData {
    return vaccinationAppointmentCollection
      .doc(vaccinationAppointmentId)
      .snapshots()
      .map(_createVaccinationAppointmentModelObject);
  }

  Stream<List<VaccinationAppointmentModel>> get allVaccincationAppointmentData {
    return vaccinationAppointmentCollection
      .snapshots()
      .map(_createVaccinationAppointmentModelList);
  }

  //create a Vaccincation Appointment model object
  VaccinationAppointmentModel _createVaccinationAppointmentModelObject(DocumentSnapshot snapshot) {
    return VaccinationAppointmentModel(
      vaccinationAppointmentId: snapshot.id,
      vaccineType: snapshot['vaccineType'],
      vaccineDate: snapshot['vaccineDate'],
      vaccineTime: snapshot['vaccineTime'],
      healthId: snapshot['healthId'],
      clinicId: snapshot['clinicId'],
      medicalStaffId: snapshot['medicalStaffId']
    );
  }

  List<VaccinationAppointmentModel> _createVaccinationAppointmentModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<VaccinationAppointmentModel>((doc) {
      return VaccinationAppointmentModel(
        vaccinationAppointmentId: doc.id,
        vaccineType: doc.get('vaccineType') ?? '',
        vaccineDate: doc.get('vaccineDate') ?? '',
        vaccineTime: doc.get('vaccineTime') ?? '',
        healthId: doc.get('healthId') ?? '',
        clinicId: doc.get('clinicId') ?? '',
        medicalStaffId: doc.get('medicalStaffId') ?? '',
      );
    }).toList();
  }

  //create Vaccincation Appointment data
  Future<void> createVaccinationAppointmentData(
    String vaccinationAppointmentId,
    String vaccineType,
    String vaccineDate,
    String vaccineTime,
    String healthId,
    String clinicId,
    String medicalStaffId,) async {
    return await vaccinationAppointmentCollection.doc(vaccinationAppointmentId).set({
      'vaccineType': vaccineType,
      'vaccineDate': vaccineDate,
      'vaccineTime': vaccineTime,
      'healthId': healthId,
      'clinicId': clinicId,
      'medicalStaffId': medicalStaffId,
    });
  }

  Future<void> updateVaccinationAppointmentData(
    String vaccinationAppointmentId,
    String vaccineType,
    String vaccineDate,
    String vaccineTime,
    String healthId,
    String clinicId,
    String medicalStaffId,) async {
    return await vaccinationAppointmentCollection.doc(vaccinationAppointmentId).update({
      'vaccineType': vaccineType,
      'vaccineDate': vaccineDate,
      'vaccineTime': vaccineTime,
      'healthId': healthId,
      'clinicId': clinicId,
      'doctorId': medicalStaffId,
    }).then((value) => print('Data updated successfully!'))
    .catchError((error) => print('Failed to update data: $error'));
  }
}