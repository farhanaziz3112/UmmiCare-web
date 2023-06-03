import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ummicare/services/database.dart';
import 'package:ummicare/models/usermodel.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user object based on the firebase user verified
  UserAuthModel? _userAuthObjectFromFirebase(User user) {
    return user != null ? UserAuthModel(userId: user.uid) : null;
  }


  // UserModel? _userObjectFromFirebase(User user) {
  //   UserModel usermodel = new UserModel(
  //     userId: user.uid,
  //     userType: ,
  //     userName: '',
  //     userFirstname: '',
  //     userLastname: '',
  //     userEmail: '',
  //     userPhoneNumber: '',
  //     userProfileImg: '',
  //   );
  //   final docRef =
  //       DatabaseService(userId: user.uid).userCollection.doc(user.uid);
  //   docRef.get().then((DocumentSnapshot doc) {
  //     usermodel.userType = doc.get('userType');
  //     usermodel.userName = doc.get('userName');
  //     usermodel.userFirstname = doc.get('userFirstName');
  //     usermodel.userLastname = doc.get('userLastName');
  //     usermodel.userEmail = doc.get('userEmail');
  //     usermodel.userPhoneNumber = doc.get('userPhoneNumber');
  //     usermodel.userProfileImg = doc.get('userProfileImg');
  //     print('ngehhhhhhhhhhhhhhhh userType:' + doc.get('userType'));
  //     print('userName:' + doc.get('userName'));
  //   });
  //   return user != null ? usermodel : null;
  // }

  //auth change user stream
  Stream<UserAuthModel?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userAuthObjectFromFirebase(user!));
  }

  //register new user with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      await DatabaseService(userId: user!.uid).updateUserData(
        'parent',
        'new username',
        'new user first name',
        'new user last name',
        email,
        'new user phone number',
        'new profile image',
      );
      return _userAuthObjectFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = authResult.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
