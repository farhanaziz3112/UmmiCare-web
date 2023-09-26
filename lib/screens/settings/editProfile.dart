import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/services/database.dart';
import 'package:ummicare/services/storage.dart';
import 'package:ummicare/shared/loading.dart';
import '../../models/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/shared/constant.dart';

class editProfile extends StatefulWidget {
  const editProfile({super.key, required this.currentuserId});
  final String currentuserId;

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  final _formKey = GlobalKey<FormState>();

  //form values holder
  String _currentName = '';
  String _currentFirstname = '';
  String _currentLastname = '';
  String _currentPhoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: DatabaseService(userId: widget.currentuserId).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserModel? usermodel = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Update Your Profile Details",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
            ),
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(usermodel!.userProfileImg),
                              radius: 50.0,
                              backgroundColor: Colors.grey,
                            ),
                            Positioned(
                              bottom: -60,
                              right: -15,
                              top: 0,
                              child: RawMaterialButton(
                                onPressed: () async {
                                  ImagePicker imagePicker = ImagePicker();
                                  XFile? file = await imagePicker.pickImage(
                                      source: ImageSource.camera);
                                  print('${file!.path}');
              
                                  StorageService _storageService = StorageService();
                                  _storageService.uploadUserProfilePic(
                                      usermodel, file);
                                },
                                constraints: BoxConstraints.tight(Size(30, 30)),
                                elevation: 2.0,
                                fillColor: Color.fromARGB(255, 216, 216, 216),
                                child: Icon(Icons.edit, color: Colors.black),
                                padding: EdgeInsets.all(0.0),
                                shape: CircleBorder(),
                              ),
                            )
                          ],
                        ),
                        // CircleAvatar(
                        //   radius: 50.0,
                        //   backgroundImage: NetworkImage(usermodel.userProfileImg),
                        // ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Username',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          initialValue: _currentName == ''
                              ? usermodel.userName
                              : _currentName,
                          decoration: textInputDecoration,
                          validator: (value) =>
                              value == '' ? 'Please enter your username' : null,
                          onChanged: (value) =>
                              setState(() => _currentName = value),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            'First Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          initialValue: _currentFirstname == ''
                              ? usermodel.userFirstname
                              : _currentFirstname,
                          decoration: textInputDecoration,
                          validator: (value) =>
                              value == '' ? 'Please enter your first name' : null,
                          onChanged: (value) =>
                              setState(() => _currentFirstname = value),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Last Name',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          initialValue: _currentLastname == ''
                              ? usermodel.userLastname
                              : _currentLastname,
                          decoration: textInputDecoration,
                          validator: (value) =>
                              value == '' ? 'Please enter your last name' : null,
                          onChanged: (value) =>
                              setState(() => _currentLastname = value),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.only(left: 20.0),
                          child: Text(
                            'Phone Number',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[500],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          initialValue: _currentPhoneNumber == ''
                              ? usermodel.userPhoneNumber
                              : _currentPhoneNumber,
                          decoration: textInputDecoration,
                          validator: (value) =>
                              value == '' ? 'Please enter your phone number' : null,
                          onChanged: (value) =>
                              setState(() => _currentPhoneNumber = value),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff8290F0),
                          ),
                          child: Text(
                            'Update Profile Details',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await DatabaseService(userId: widget.currentuserId)
                                  .updateUserData(
                                      usermodel.userType,
                                      _currentName == ''
                                          ? usermodel.userName
                                          : _currentName,
                                      _currentFirstname == ''
                                          ? usermodel.userFirstname
                                          : _currentFirstname,
                                      _currentLastname == ''
                                          ? usermodel.userLastname
                                          : _currentLastname,
                                      usermodel.userEmail,
                                      _currentPhoneNumber == ''
                                          ? usermodel.userPhoneNumber
                                          : _currentPhoneNumber,
                                      usermodel.userProfileImg);
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container(child: Text('no data'));
        }
      },
    );
  }
}
