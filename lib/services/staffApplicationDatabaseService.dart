import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/staffapplicationmodel.dart';

class staffApplicationDatabaseService {
  
  //collection reference
  final CollectionReference staffApplicationCollection = FirebaseFirestore.instance.collection('Staff Application');

  //create a staff application model object
  StaffApplicationModel _createStaffApplicationModel(DocumentSnapshot snapshot) {
    return StaffApplicationModel(
      applicationId: snapshot.id,
      firstName: snapshot['firstName'],
      lastName: snapshot['lastName'],
      fullName: snapshot['fullName'],
      email: snapshot['email'],
      phoneNumber: snapshot['phoneNumber'],
      supportingDocumentLink: snapshot['supportingDocumentLink'],
      userType: snapshot['userType'],
      applicationStatus: snapshot['applicationStatus'],
      submissionDate: snapshot['submissionDate'],
    );
  }

  //create a list of staff applications
  List<StaffApplicationModel> _createStaffApplicationModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<StaffApplicationModel>((doc) {
      return StaffApplicationModel(
        applicationId: doc.id,
        firstName: doc.get('firstName') ?? '',
        lastName: doc.get('lastName') ?? '',
        fullName: doc.get('fullName') ?? '',
        email: doc.get('email') ?? '',
        phoneNumber: doc.get('phoneNumber') ?? '',
        supportingDocumentLink: doc.get('supportingDocumentLink') ?? '',
        userType: doc.get('userType') ?? '',
        applicationStatus: doc.get('applicationStatus') ?? '',
        submissionDate: doc.get('submissionDate') ?? '',
      );
    }).toList();
  }

  //create staff application data
  Future<void> createStaffApplicationData(
    String firstName,
    String lastName,
    String fullName,
    String email,
    String phoneNumber,
    String supportingDocumentLink,
    String userType,
    String applicationStatus,
    String submissionDate,
  ) async {
    return await staffApplicationCollection.doc().set({
      'firstName' : firstName,
      'lastName' : lastName,
      'fullName' : fullName,
      'email' : email,
      'phoneNumber' : phoneNumber,
      'supportingDocumentLink' : supportingDocumentLink,
      'userType' : userType,
      'applicationStatus' : applicationStatus,
      'submissionDate' : submissionDate
    });
  }

  //edit staff application data
  Future<void> editStaffApplicationData(
    String firstName,
    String lastName,
    String fullName,
    String email,
    String phoneNumber,
    String supportingDocumentLink,
    String userType,
    String applicationStatus,
    String submissionDate,
    String applicationId
  ) async {
    return await staffApplicationCollection.doc(applicationId).set({
      'firstName' : firstName,
      'lastName' : lastName,
      'fullName' : fullName,
      'email' : email,
      'phoneNumber' : phoneNumber,
      'supportingDocumentLink' : supportingDocumentLink,
      'userType' : userType,
      'applicationStatus' : applicationStatus,
      'submissionDate' : submissionDate
    });
  }

  //get specific staff application data
  Stream<StaffApplicationModel> advisorPendingApplication (String applicationId) {
    return staffApplicationCollection.doc(applicationId).snapshots().map(_createStaffApplicationModel);
  }

  //get all advisor applications stream with pending status
  Stream<List<StaffApplicationModel>> get allAdvisorPendingApplications {
    return staffApplicationCollection.where('applicationStatus', isEqualTo: 'pending').where('userType', isEqualTo: 'advisor').snapshots().map(_createStaffApplicationModelList);
  }


}