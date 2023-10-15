import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/childmodel.dart';

class childDatabase {
  final String parentId;
  final String childId;

  childDatabase({
    required this.parentId,
    required this.childId
  });

    //collection reference
  final CollectionReference childCollection =
      FirebaseFirestore.instance.collection('Child');

  //get specific child document stream
  Stream<ChildModel> get childData {
    return childCollection
        .doc(childId)
        .snapshots()
        .map(_createChildModelObject);
  }

  //get all childs stream
  Stream<List<ChildModel>> get allChildData {
    return childCollection
        .where('parentId', isEqualTo: parentId)
        .snapshots()
        .map(_createChildModelList);
  }

  //create a list of child model object
  List<ChildModel> _createChildModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map<ChildModel>((doc) {
      return ChildModel(
        childId: doc.id,
        parentId: doc.get('parentId') ?? '',
        childName: doc.get('childName') ?? '',
        childFirstname: doc.get('childFirstname') ?? '',
        childLastname: doc.get('childLastname') ?? '',
        childBirthday: doc.get('childBirthday') ?? '',
        childCurrentAge: doc.get('childCurrentAge') ?? 2,
        childAgeCategory: doc.get('childAgeCategory') ?? '',
        childProfileImg: doc.get('childProfileImg') ?? '',
      );
    }).toList();
  }

  //create a child model object
  ChildModel _createChildModelObject(DocumentSnapshot snapshot) {
    return ChildModel(
      childId: snapshot.id,
      parentId: snapshot['parentId'],
      childName: snapshot['childName'],
      childFirstname: snapshot['childFirstname'],
      childLastname: snapshot['childLastname'],
      childBirthday: snapshot['childBirthday'],
      childCurrentAge: snapshot['childCurrentAge'],
      childAgeCategory: snapshot['childAgeCategory'],
      childProfileImg: snapshot['childProfileImg'],
    );
  }

  //update child data
  Future<void> updateChildData(
      String childId,
      String parentId,
      String childName,
      String childFirstname,
      String childLastname,
      String childBirthday,
      int childCurrentAge,
      String childAgeCategory,
      String childProfileImg) async {
    return await childCollection.doc(childId).set({
      'childId' : childId,
      'parentId': parentId,
      'childName': childName,
      'childFirstname': childFirstname,
      'childLastname': childLastname,
      'childBirthday': childBirthday,
      'childCurrentAge': childCurrentAge,
      'childAgeCategory': childAgeCategory,
      'childProfileImg': childProfileImg,
    });
  }

}