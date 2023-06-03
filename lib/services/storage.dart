import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/usermodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

import 'package:ummicare/services/database.dart';

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

  //upload image to parent folder
  Future<String> uploadUserProfilePic(UserModel user, XFile file) async {
    String uniqueFileName =
        DateTime.now().millisecondsSinceEpoch.toString() + user.userId;

    Reference imageToUpload;

    if (user.userType == 'parent') {
      imageToUpload = parentFolderReference.child(uniqueFileName);
    } else if (user.userType == 'advisor') {
      imageToUpload = advisorFolderReference.child(uniqueFileName);
    } else if (user.userType == 'admin') {
      imageToUpload = adminFolderReference.child(uniqueFileName);
    } else {
      imageToUpload = referenceRoot.child(uniqueFileName);
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
}
