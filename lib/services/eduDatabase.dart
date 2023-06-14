import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ummicare/models/usermodel.dart';
import 'package:ummicare/models/educationmodel.dart';

class EduDatabaseService {
  final String childId;
  final String? schoolId;
  final String? educationId;

  EduDatabaseService({required this.childId, this.schoolId, this.educationId});

  //------------------------------EDUCATION----------------------------------

//collection reference
  final CollectionReference educationCollection =
      FirebaseFirestore.instance.collection('Education');

//collection reference
  final CollectionReference educationSubjectsCollection = FirebaseFirestore
      .instance
      .collection('Education')
      .doc()
      .collection('subjects');

//get education stream
  Stream<List<EducationModel>> get educationData {
    return educationCollection
        .where('childId', isEqualTo: childId)
        .where('status', isEqualTo: 'current')
        .snapshots()
        .map(_createEducationModelList);
  }

//create a education model object
  EducationModel _createEducationModelObject(DocumentSnapshot snapshot) {
    return EducationModel(
      educationId: snapshot.id,
      calendarEndDate: snapshot['calendarEndDate'],
      calendarStartDate: snapshot['calendarStartDate'],
      childId: snapshot['childId'],
      classId: snapshot['classId'],
      schoolId: snapshot['schoolId'],
      currentYear: snapshot['currentYear'],
      status: snapshot['status'],
      subjects: snapshot['subjects'],
    );
  }

  //create a list of education model object
  List<EducationModel> _createEducationModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<EducationModel>((doc) {
      return EducationModel(
        educationId: doc.id,
        calendarEndDate: doc.get('calendarEndDate') ?? '',
        calendarStartDate: doc.get('calendarStartDate') ?? '',
        childId: doc.get('childId') ?? '',
        classId: doc.get('classId') ?? '',
        schoolId: doc.get('schoolId') ?? '',
        currentYear: doc.get('currentYear') ?? 2,
        status: doc.get('status') ?? '',
        subjects: doc.get('subjects') ?? '',
      );
    }).toList();
  }

//create education data
  Future<void> createEducationData(
      String educationId,
      String calendarEndDate,
      String calendarStartDate,
      String childId,
      String classId,
      String schoolId,
      String currentYear,
      String status,
      List<String> subjects) async {
    return await educationCollection.doc().set({
      'calendarEndDate': calendarEndDate,
      'calendarStartDate': calendarStartDate,
      'childId': childId,
      'classId': classId,
      'currentYear': currentYear,
      'schoolId': schoolId,
      'status': status,
    });
  }

//------------------------------SCHOOL----------------------------------

  //collection reference
  final CollectionReference schoolCollection =
      FirebaseFirestore.instance.collection('School');

  //create a school model
  SchoolModel _createSchoolModelObject(DocumentSnapshot snapshot) {
    return SchoolModel(
      schoolId: snapshot.id,
      schoolAddress: snapshot['schoolAddress'],
      schoolEmail: snapshot['schoolEmail'],
      schoolName: snapshot['schoolName'],
      schoolPhoneNumber: snapshot['schoolPhoneNumber'],
    );
  }

  //create school data
  Future<void> createSchoolData(String schoolId, String schoolAddress,
      String schoolEmail, String schoolName, String schoolPhoneNumber) async {
    return await schoolCollection.doc(schoolId).set({
      'schoolAddress': schoolAddress,
      'schoolEmail': schoolEmail,
      'schoolName': schoolName,
      'schoolPhoneNumber': schoolPhoneNumber
    });
  }

//------------------------------CLASS----------------------------------

  //collection reference
  final CollectionReference classCollection =
      FirebaseFirestore.instance.collection('Class');

  //create a school model
  ClassModel _createClassModelObject(DocumentSnapshot snapshot) {
    return ClassModel(
      classId: snapshot.id,
      className: snapshot['className'],
      classTeacherId: snapshot['classTeacherId'],
      schoolId: snapshot['schoolId'],
    );
  }

//------------------------------TEACHER----------------------------------

  final CollectionReference teacherCollection =
      FirebaseFirestore.instance.collection('Teacher');

  //create a school model
  TeacherModel _createTeacherModelObject(DocumentSnapshot snapshot) {
    return TeacherModel(
      teacherId: snapshot.id,
      teacherEmail: snapshot['teacherEmail'],
      teacherName: snapshot['teacherName'],
      teacherPhoneNumber: snapshot['teacherPhoneNumber'],
      schoolId: snapshot['schoolId'],
      classId: snapshot['classId'],
    );
  }
}
