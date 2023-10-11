import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:ummicare/services/database.dart';

import '../models/childmodel.dart';

class StorageService {
  //root reference
  Reference referenceRoot = FirebaseStorage.instance.ref();

  //profile pic parent folder reference
  late Reference parentFolderReference = referenceRoot.child('parent');

  //profile pic advisor folder reference
  late Reference advisorFolderReference = referenceRoot.child('advisor');

  //profile pic admin folder reference
  late Reference adminFolderReference = referenceRoot.child('admin');

  //profile pic child folder reference
  late Reference childFolderReference = referenceRoot.child('child');

  //profile pic child folder reference
  late Reference teacherFolderReference = referenceRoot.child('teacher');

  //profile pic child folder reference
  late Reference medicalStaffFolderReference = referenceRoot.child('medicalStaff');

  //upload document for staff application
  Future<String> uploadDocumentForStaffApplication(String userType, PlatformFile? uploadedFile) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    
    Reference fileToUpload;

    final File filePath = File(uploadedFile!.path.toString());

    if (userType == 'advisor') {
      fileToUpload = advisorFolderReference.child('application').child(uniqueFileName);
    } else if (userType == 'teacher') {
      fileToUpload = teacherFolderReference.child('application').child(uniqueFileName);
    } else {
      fileToUpload = medicalStaffFolderReference.child('application').child(uniqueFileName);
    }

    String documentUrl = '';

    try {
      await fileToUpload.putFile(filePath);
      documentUrl = await fileToUpload.getDownloadURL();
      print('Document URL: ${documentUrl}');
    } catch (e){
      print(e);
    }

    return documentUrl;

  }

  //upload multiple document for staff application
  Future<List<String>> uploadMultipleDocumentForStaffApplication(String userType, List<File> files) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    
    Reference fileToUpload;

    //final File filePath = File(uploadedFile!.path.toString());

    if (userType == 'advisor') {
      fileToUpload = advisorFolderReference.child('application').child(uniqueFileName);
    } else if (userType == 'teacher') {
      fileToUpload = teacherFolderReference.child('application').child(uniqueFileName);
    } else {
      fileToUpload = medicalStaffFolderReference.child('application').child(uniqueFileName);
    }

    List<String> documentUrl = [];

    for (var i = 0; i < files.length; i++) {
      //try {
      await fileToUpload.putFile(File(files[i].path));
      documentUrl.add(await fileToUpload.getDownloadURL());
      print('Document URL: ${documentUrl[i]}');
      // } catch (e) {
      //   print(e);
      // }
    }

    return documentUrl;
  }


  //upload image to user folder
  Future<String> uploadUserProfilePic(UserModel user, XFile file) async {
    String uniqueFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + user.userId;

    Reference imageToUpload;

    if (user.userType == 'parent') {
      imageToUpload = parentFolderReference.child(uniqueFileName);
    } else if (user.userType == 'advisor') {
      imageToUpload = advisorFolderReference.child(uniqueFileName);
    } else {
      imageToUpload = adminFolderReference.child(uniqueFileName);
    }

    String imageUrl = '';

    try {
      await imageToUpload.putFile(File(file.path));
      imageUrl = await imageToUpload.getDownloadURL();
      print('Image URL: ${imageUrl}');
      updateUserProfileImageUrl(user, imageUrl);
    } catch (e) {
      print(e);
    }

    return imageUrl;
  }

  //upload image to child folder
  Future<String> uploadChildProfilePic(ChildModel child, XFile file) async {
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference imageToUpload = childFolderReference.child(uniqueFileName);

    String imageUrl = '';

    try {
      await imageToUpload.putFile(File(file.path));
      imageUrl = await imageToUpload.getDownloadURL();
      print('Image URL: ${imageUrl}');
      updateChildProfileImageUrl(child, imageUrl);
    } catch (e) {
      print(e);
    }

    return imageUrl;
  }

  //update user image url
  void updateUserProfileImageUrl(UserModel user, String imageUrl) {
    print('Updating user: ${user.userId}');
    DatabaseService(userId: user.userId).updateUserData(
        user.userType,
        user.userName,
        user.userFirstname,
        user.userLastname,
        user.userEmail,
        user.userPhoneNumber,
        imageUrl);
  }

  //update child image url
  void updateChildProfileImageUrl(ChildModel child, String imageUrl) {
    print('Updating user: ${child.childId}');
    DatabaseService(userId: child.parentId).updateChildData(
        child.childId,
        child.parentId,
        child.childName,
        child.childFirstname,
        child.childLastname,
        child.childBirthday,
        child.childCurrentAge,
        child.childAgeCategory,
        imageUrl);
  }
}
