import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ummicare/models/educationmodel.dart';
import 'package:ummicare/models/usermodel.dart';
import 'package:ummicare/models/educationmodel.dart';

class EduDatabaseService {
  final String childId;
  final String? schoolId;
  final String? classId;
  final String? teacherId;

  EduDatabaseService(
      {required this.childId, this.schoolId, this.classId, this.teacherId});

  //------------------------------EDUCATION----------------------------------

  //collection reference
  final CollectionReference educationCollection =
      FirebaseFirestore.instance.collection('Education');

  //get education stream
  Stream<List<EducationModel>> get educationData {
    return educationCollection
        .where('childId', isEqualTo: childId)
        .where('status', isEqualTo: 'Active')
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
      classTeacherId: snapshot['classTeacherId'],
      schoolId: snapshot['schoolId'],
      currentYear: snapshot['currentYear'],
      status: snapshot['status'],
      subjectsList: [],
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
        classTeacherId: doc.get('classTeacherId') ?? '',
        schoolId: doc.get('schoolId') ?? '',
        currentYear: doc.get('currentYear') ?? 2,
        status: doc.get('status') ?? '',
        subjectsList: [],
      );
    }).toList();
  }

  Future<List<String>> getSubjectsList(String educationId) async {
    Future<DocumentSnapshot<Map<String, dynamic>>> querySnapshot =
        educationCollection.doc(educationId).collection('subjects').doc().get();
    print(querySnapshot.toString());
    return [];
  }

  //create subjects list for education model
  // List<String> createSubjectsList(Future<DocumentSnapshot<Map<String, dynamic>>> subjectsList) {
  //   List<String> temp = [];
  //   for (var doc in subjectsList) {
  //     temp.add(doc.data().toString());
  //   }
  //   return temp;
  // }

  //create education data
  Future<void> createEducationData(
      String educationId,
      String calendarEndDate,
      String calendarStartDate,
      String childId,
      String classId,
      String classTeacherId,
      String schoolId,
      String currentYear,
      String status) async {
    return await educationCollection.doc(educationId).set({
      'calendarEndDate': calendarEndDate,
      'calendarStartDate': calendarStartDate,
      'childId': childId,
      'classId': classId,
      'classTeacherId': classTeacherId,
      'currentYear': currentYear,
      'schoolId': schoolId,
      'status': status,
    });
  }

  //------------------------------SUBJECTS LIST----------------------------------

  // //get education stream
  // Stream<List<SubjectModel>> get subjectsListData (String id){
  //   return educationCollection
  //       .where('childId', isEqualTo: childId)
  //       .where('status', isEqualTo: 'active')
  //       .snapshots()
  //       .map(_createEducationModelList);
  // }

  //------------------------------SCHOOL----------------------------------

  //collection reference
  final CollectionReference schoolCollection =
      FirebaseFirestore.instance.collection('School');

  //get specific school document stream
  Stream<SchoolModel> get schoolData {
    return schoolCollection
        .doc(schoolId)
        .snapshots()
        .map(_createSchoolModelObject);
  }

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

  //get specific class document stream
  Stream<ClassModel> get classData {
    return classCollection
        .doc(classId)
        .snapshots()
        .map(_createClassModelObject);
  }

  //create a class model
  ClassModel _createClassModelObject(DocumentSnapshot snapshot) {
    return ClassModel(
      classId: snapshot.id,
      className: snapshot['className'],
      classTeacherId: snapshot['classTeacherId'],
      schoolId: snapshot['schoolId'],
    );
  }

  //create class data
  Future<void> createClassData(String classId, String schoolId,
      String className, String classTeacherId) async {
    return await classCollection.doc(classId).set({
      'className': className,
      'schoolId': schoolId,
      'classTeacherId': classTeacherId,
    });
  }

//------------------------------TEACHER----------------------------------

  //collection reference
  final CollectionReference teacherCollection =
      FirebaseFirestore.instance.collection('Teacher');

  //get specific teacher model document data
  Stream<TeacherModel> get teacherData {
    return teacherCollection
        .doc(teacherId)
        .snapshots()
        .map(_createTeacherModelObject);
  }

  //create a teacher model
  TeacherModel _createTeacherModelObject(DocumentSnapshot snapshot) {
    return TeacherModel(
      teacherId: snapshot.id,
      teacherEmail: snapshot['teacherEmail'],
      teacherName: snapshot['teacherName'],
      teacherPhoneNumber: snapshot['teacherPhoneNumber'],
      schoolId: snapshot['schoolId'],
    );
  }

  //create teacher data
  Future<void> createTeacherData(
      String teacherId,
      String schoolId,
      String teacherEmail,
      String teacherName,
      String teacherPhoneNumber) async {
    return await teacherCollection.doc(teacherId).set({
      'schoolId': schoolId,
      'teacherEmail': teacherEmail,
      'teacherName': teacherName,
      'teacherPhoneNumber': teacherPhoneNumber
    });
  }
}
