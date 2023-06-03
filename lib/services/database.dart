import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ummicare/models/usermodel.dart';

import '../models/childmodel.dart';

class DatabaseService {
  final String userId;
  DatabaseService({required this.userId});

  FirebaseAuth _auth = FirebaseAuth.instance;

  //------------------------------USER----------------------------------

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');

  //get specific user document stream
  Stream<UserModel> get userData {
    return userCollection.doc(userId).snapshots().map(_createUserModelObject);
  }

  //get all userdetails stream
  Stream<List<UserModel>> get allUserData {
    return userCollection.snapshots().map(_createUserModelList);
  }

  //create a user model object
  UserModel _createUserModelObject(DocumentSnapshot snapshot) {
    return UserModel(
      userId: userId,
      userType: snapshot['userType'],
      userName: snapshot['userName'],
      userFirstname: snapshot['userFirstname'],
      userLastname: snapshot['userLastname'],
      userEmail: snapshot['userEmail'],
      userPhoneNumber: snapshot['userPhoneNumber'],
      userProfileImg: snapshot['userProfileImg'],
    );
  }

  //create a list of user model object
  List<UserModel> _createUserModelList(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserModel(
        userId: userId,
        userType: doc.get('userType'),
        userName: doc.get('userName'),
        userFirstname: doc.get('userFirstname'),
        userLastname: doc.get('userLastname'),
        userEmail: doc.get('userEmail'),
        userPhoneNumber: doc.get('userPhoneNumber'),
        userProfileImg: doc.get('userProfileImg'),
      );
    }).toList();
  }

  //update user data
  Future<void> updateUserData(
      String userType,
      String userName,
      String userFirstname,
      String userLastName,
      String userEmail,
      String userPhoneNumber,
      String userProfileImg) async {
    return await userCollection.doc(userId).set({
      'userType': userType,
      'userName': userName,
      'userFirstname': userFirstname,
      'userLastname': userLastName,
      'userEmail': userEmail,
      'userPhoneNumber': userPhoneNumber,
      'userProfileImg': userProfileImg,
    });
  }

  //------------------------------CHILD----------------------------------

  //collection reference
  final CollectionReference childCollection =
      FirebaseFirestore.instance.collection('Child');

  //get specific child document stream
  Stream<ChildModel> get childData {
    return userCollection.doc(userId).snapshots().map(_createChildModelObject);
  }

  //get all childs stream
  Stream<List<ChildModel>> get allChildData {
    return childCollection
        .where('parentId', isEqualTo: userId)
        .snapshots()
        .map(_createChildModelList);
  }

  //create a list of user model object
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

  //update user data
  Future<void> updateChildData(
      String parentId,
      String childName,
      String childFirstname,
      String childLastname,
      String childBirthday,
      int childCurrentAge,
      String childAgeCategory,
      String childProfileImg) async {
    return await childCollection.doc().set({
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
