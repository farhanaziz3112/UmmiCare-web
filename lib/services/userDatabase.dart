import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ummicare/models/userModel.dart';

class userDatabase {

  final String userId;
  userDatabase({required this.userId});

  //collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('User');

  //get specific user document stream
  Stream<userModel> get userData {
    return userCollection
        .doc(userId)
        .snapshots()
        .map(_createuserModelObject);
  }

  //create a user model object
  userModel _createuserModelObject(DocumentSnapshot snapshot) {
    return userModel(
      userId: userId,
      userType: snapshot['userType'],
      userEmail: snapshot['userEmail'],
    );
  }

  //update user data
  Future<void> updateUserData(
      String userId,
      String userType,
      String userEmail,) async {
    return await userCollection.doc(userId).set({
      'userId': userId,
      'userType': userType,
      'userEmail': userEmail,
    });
  }

}