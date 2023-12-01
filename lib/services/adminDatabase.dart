import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/models/staffUserModel.dart';

class adminDatabase {
  
  // //collection reference
  // final CollectionReference staffApplicationCollection = FirebaseFirestore.instance.collection('Staff Application');

  //staff collection reference
  final CollectionReference staffCollection = FirebaseFirestore.instance.collection('Staff');

  //parent collection reference
  final CollectionReference parentCollection = FirebaseFirestore.instance.collection('Parent');

  //child collection reference
  final CollectionReference childCollection = FirebaseFirestore.instance.collection('Child');

  // //create a staff application model object
  // StaffApplicationModel _createStaffApplicationModel(DocumentSnapshot snapshot) {
  //   return StaffApplicationModel(
  //     applicationId: snapshot.id,
  //     firstName: snapshot['firstName'],
  //     lastName: snapshot['lastName'],
  //     fullName: snapshot['fullName'],
  //     email: snapshot['email'],
  //     phoneNumber: snapshot['phoneNumber'],
  //     supportingDocumentLink: snapshot['supportingDocumentLink'],
  //     userType: snapshot['userType'],
  //     applicationStatus: snapshot['applicationStatus'],
  //     submissionDate: snapshot['submissionDate'],
  //   );
  // }

  // //create a list of staff applications
  // List<StaffApplicationModel> _createStaffApplicationModelList(QuerySnapshot snapshot) {
  //   return snapshot.docs.map<StaffApplicationModel>((doc) {
  //     return StaffApplicationModel(
  //       applicationId: doc.id,
  //       firstName: doc.get('firstName') ?? '',
  //       lastName: doc.get('lastName') ?? '',
  //       fullName: doc.get('fullName') ?? '',
  //       email: doc.get('email') ?? '',
  //       phoneNumber: doc.get('phoneNumber') ?? '',
  //       supportingDocumentLink: doc.get('supportingDocumentLink') ?? '',
  //       userType: doc.get('userType') ?? '',
  //       applicationStatus: doc.get('applicationStatus') ?? '',
  //       submissionDate: doc.get('submissionDate') ?? '',
  //     );
  //   }).toList();
  // }

  // //create staff application data
  // Future<void> createStaffApplicationData(
  //   String firstName,
  //   String lastName,
  //   String fullName,
  //   String email,
  //   String phoneNumber,
  //   String supportingDocumentLink,
  //   String userType,
  //   String applicationStatus,
  //   String submissionDate,
  // ) async {
  //   return await staffApplicationCollection.doc().set({
  //     'firstName' : firstName,
  //     'lastName' : lastName,
  //     'fullName' : fullName,
  //     'email' : email,
  //     'phoneNumber' : phoneNumber,
  //     'supportingDocumentLink' : supportingDocumentLink,
  //     'userType' : userType,
  //     'applicationStatus' : applicationStatus,
  //     'submissionDate' : submissionDate
  //   });
  // }

  // //edit staff application data
  // Future<void> editStaffApplicationData(
  //   String firstName,
  //   String lastName,
  //   String fullName,
  //   String email,
  //   String phoneNumber,
  //   String supportingDocumentLink,
  //   String userType,
  //   String applicationStatus,
  //   String submissionDate,
  //   String applicationId
  // ) async {
  //   return await staffApplicationCollection.doc(applicationId).set({
  //     'firstName' : firstName,
  //     'lastName' : lastName,
  //     'fullName' : fullName,
  //     'email' : email,
  //     'phoneNumber' : phoneNumber,
  //     'supportingDocumentLink' : supportingDocumentLink,
  //     'userType' : userType,
  //     'applicationStatus' : applicationStatus,
  //     'submissionDate' : submissionDate
  //   });
  // }

  // //get specific staff application data
  // Stream<StaffApplicationModel> advisorPendingApplication (String applicationId) {
  //   return staffApplicationCollection.doc(applicationId).snapshots().map(_createStaffApplicationModel);
  // }

  // //get all advisor applications stream with pending status
  // Stream<List<StaffApplicationModel>> get allAdvisorPendingApplications {
  //   return staffApplicationCollection.where('applicationStatus', isEqualTo: 'pending').where('userType', isEqualTo: 'advisor').snapshots().map(_createStaffApplicationModelList);
  // }

  //get specific staff
  Stream<staffUserModel> staffData (String staffId){
    return staffCollection.doc(staffId).snapshots().map(_createStaffUserModel);
  }

    //create a staff model object
  staffUserModel _createStaffUserModel(DocumentSnapshot snapshot) {
    return staffUserModel(
      staffId: snapshot.id,
      staffCreatedDate: snapshot['staffCreatedDate'],
      staffUserType: snapshot['staffUserType'],
      staffFullName: snapshot['staffFullName'],
      staffFirstName: snapshot['staffFirstName'],
      staffLastName: snapshot['staffLastName'],
      staffEmail: snapshot['staffEmail'],
      staffPhoneNumber: snapshot['staffPhoneNumber'],
      staffSupportingDocumentLink: snapshot['staffSupportingDocumentLink'],
      staffProfileImg: snapshot['staffProfileImg'],
      isVerified: snapshot['isVerified']
    );
  }
  
  //get staff stream according to isVerified and userType
  Stream<List<staffUserModel>> allStaffData (String isVerified, String userType){
    return staffCollection
        .where('isVerified', isEqualTo: isVerified)
        .where('staffUserType', isEqualTo: userType)
        .snapshots()
        .map(_createStaffUserModelList);
  }

  //create a list of user model object
  List<staffUserModel> _createStaffUserModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return staffUserModel(
          staffId: doc.get('staffId'),
          staffCreatedDate: doc.get('staffCreatedDate'),
          staffUserType: doc.get('staffUserType'),
          staffFullName: doc.get('staffFullName'),
          staffFirstName: doc.get('staffFirstName'),
          staffLastName: doc.get('staffLastName'),
          staffEmail: doc.get('staffEmail'),
          staffPhoneNumber: doc.get('staffPhoneNumber'),
          staffSupportingDocumentLink: doc.get('staffSupportingDocumentLink'),
          staffProfileImg: doc.get('staffProfileImg'),
          isVerified: doc.get('isVerified'));
    }).toList();
  }

  //update staff data
  Future<void> updateStaffData(
      String staffId,
      String staffCreatedDate,
      String staffUserType,
      String staffFullName,
      String staffFirstName,
      String staffLastName,
      String staffEmail,
      String staffPhoneNumber,
      String staffSupportingDocumentLink,
      String staffProfileImg,
      String isVerified,) async {
    return await staffCollection.doc(staffId).set({
      'staffId': staffId,
      'staffCreatedDate': staffCreatedDate,
      'staffUserType': staffUserType,
      'staffFullName': staffFullName,
      'staffFirstName': staffFirstName,
      'staffLastName': staffLastName,
      'staffEmail': staffEmail,
      'staffPhoneNumber': staffPhoneNumber,
      'staffSupportingDocumentLink': staffSupportingDocumentLink,
      'staffProfileImg': staffProfileImg,
      'isVerified': isVerified,
    });
  }

  //get all userdetails stream
  Stream<List<parentModel>> get allParentData {
    return parentCollection.snapshots().map(_createparentModelList);
  }

  //create a user model object
  parentModel _createparentModelObject(DocumentSnapshot snapshot) {
    return parentModel(
      parentId: snapshot['parentId'],
      parentCreatedDate: snapshot['parentCreatedDate'],
      parentFullName: snapshot['parentFullName'],
      parentFirstName: snapshot['parentFirstName'],
      parentLastName: snapshot['parentLastName'],
      parentEmail: snapshot['parentEmail'],
      parentPhoneNumber: snapshot['parentPhoneNumber'],
      parentProfileImg: snapshot['parentProfileImg'],
      advisorId: snapshot['advisorId'],
      noOfChild: snapshot['noOfChild']
    );
  }

  //create a list of user model object
  List<parentModel> _createparentModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return parentModel(
        parentId: doc.get('parentId'),
        parentCreatedDate: doc.get('parentCreatedDate'),
        parentFullName: doc.get('parentFullName'),
        parentFirstName: doc.get('parentFirstName'),
        parentLastName: doc.get('parentLastName'),
        parentEmail: doc.get('parentEmail'),
        parentPhoneNumber: doc.get('parentPhoneNumber'),
        parentProfileImg: doc.get('parentProfileImg'),
        advisorId: doc.get('advisorId'),
        noOfChild: doc.get('noOfChild')
      );
    }).toList();
  }

  //get all userdetails stream
  Stream<List<childModel>> get allChildData {
    return childCollection.snapshots().map(_createchildModelList);
  }

  //create a list of child model object
  List<childModel> _createchildModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<childModel>((doc) {
      return childModel(
        childId: doc.id,
        parentId: doc.get('parentId') ?? '',
        childCreatedDate: doc.get('childCreatedDate') ?? '',
        childName: doc.get('childName') ?? '',
        childFirstname: doc.get('childFirstname') ?? '',
        childLastname: doc.get('childLastname') ?? '',
        childBirthday: doc.get('childBirthday') ?? '',
        childCurrentAge: doc.get('childCurrentAge') ?? '',
        childAgeCategory: doc.get('childAgeCategory') ?? '',
        childProfileImg: doc.get('childProfileImg') ?? '',
        educationId: doc.get('educationId') ?? '',
        healthId: doc.get('healthId') ?? '',
      );
    }).toList();
  }

}