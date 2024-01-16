import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/childModel.dart';

class childDatabase {
  final String childId;

  childDatabase({required this.childId});

  //collection reference
  final CollectionReference childCollection =
      FirebaseFirestore.instance.collection('Child');

  //get specific child document stream
  Stream<childModel> get childData {
    return childCollection
        .doc(childId)
        .snapshots()
        .map(_createchildModelObject);
  }

  Stream<List<childModel>> get allChild {
    return childCollection.snapshots().map(_createchildModelList);
  }

  //create a list of child model object
  List<childModel> _createchildModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<childModel>((doc) {
      return childModel(
        childId:
            doc.data().toString().contains('childId') ? doc.get('childId') : '',
        parentId: doc.data().toString().contains('parentId')
            ? doc.get('parentId')
            : '',
        childCreatedDate: doc.data().toString().contains('childCreatedDate')
            ? doc.get('childCreatedDate')
            : '',
        childName: doc.data().toString().contains('childName')
            ? doc.get('childName')
            : '',
        childFirstname: doc.data().toString().contains('childFirstname')
            ? doc.get('childFirstname')
            : '',
        childLastname: doc.data().toString().contains('childLastname')
            ? doc.get('childLastname')
            : '',
        childBirthday: doc.data().toString().contains('childBirthday')
            ? doc.get('childBirthday')
            : '',
        childCurrentAge: doc.data().toString().contains('childCurrentAge')
            ? doc.get('childCurrentAge')
            : '',
        childAgeCategory: doc.data().toString().contains('childAgeCategory')
            ? doc.get('childAgeCategory')
            : '',
        childProfileImg: doc.data().toString().contains('childProfileImg')
            ? doc.get('childProfileImg')
            : '',
        educationId: doc.data().toString().contains('educationId')
            ? doc.get('educationId')
            : '',
        healthId: doc.data().toString().contains('healthId')
            ? doc.get('healthId')
            : '',
        overallStatus: doc.data().toString().contains('overallStatus')
            ? doc.get('overallStatus')
            : '',
      );
    }).toList();
  }

  //create a child model object
  childModel _createchildModelObject(DocumentSnapshot snapshot) {
    return childModel(
      childId: snapshot.id,
      parentId: snapshot['parentId'],
      childCreatedDate: snapshot['childCreatedDate'],
      childName: snapshot['childName'],
      childFirstname: snapshot['childFirstname'],
      childLastname: snapshot['childLastname'],
      childBirthday: snapshot['childBirthday'],
      childCurrentAge: snapshot['childCurrentAge'],
      childAgeCategory: snapshot['childAgeCategory'],
      childProfileImg: snapshot['childProfileImg'],
      educationId: snapshot['educationId'],
      healthId: snapshot['healthId'],
      overallStatus: snapshot['overallStatus'],
    );
  }

  //update child data
  Future<void> updateChildData(
      String childId,
      String parentId,
      String childCreatedDate,
      String childName,
      String childFirstname,
      String childLastname,
      String childBirthday,
      int childCurrentAge,
      String childAgeCategory,
      String childProfileImg,
      String educationId,
      String healthId,
      String overallStatus) async {
    return await childCollection.doc(childId).set({
      'childId': childId,
      'parentId': parentId,
      'childCreatedDate': childCreatedDate,
      'childName': childName,
      'childFirstname': childFirstname,
      'childLastname': childLastname,
      'childBirthday': childBirthday,
      'childCurrentAge': childCurrentAge,
      'childAgeCategory': childAgeCategory,
      'childProfileImg': childProfileImg,
      'educationId': educationId,
      'healthId': healthId,
      'overallStatus': overallStatus
    });
  }

  //create child data
  Future<void> createChildData(
      String childId,
      String parentId,
      String childCreatedDate,
      String childName,
      String childFirstname,
      String childLastname,
      String childBirthday,
      int childCurrentAge,
      String childAgeCategory,
      String childProfileImg,
      String educationId,
      String healthId,
      String overallStatus) async {
    final document = childCollection.doc();
    return await childCollection.doc(document.id).set({
      'childId': document.id,
      'parentId': parentId,
      'childName': childName,
      'childFirstname': childFirstname,
      'childLastname': childLastname,
      'childBirthday': childBirthday,
      'childCurrentAge': childCurrentAge,
      'childAgeCategory': childAgeCategory,
      'childProfileImg': childProfileImg,
      'educationId': educationId,
      'healthId': healthId,
      'overallStatus': overallStatus
    });
  }
}
