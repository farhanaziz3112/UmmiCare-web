import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/staffDatabase.dart';
import 'package:ummicare/services/storage.dart';
import 'package:ummicare/shared/constant.dart';

class adminEditProfile extends StatefulWidget {
  const adminEditProfile({super.key});

  @override
  State<adminEditProfile> createState() => _adminEditProfileState();
}

class _adminEditProfileState extends State<adminEditProfile> {
  final _formKey = GlobalKey<FormState>();

  //form values holder
  String _currentFullName = '';
  String _currentFirstName = '';
  String _currentLastName = '';
  String _currentPhoneNumber = '';

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder<staffUserModel>(
        stream: staffDatabase(staffId: user!.userId).staffData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            staffUserModel? staff = snapshot.data;
            return Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            text: 'Settings',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/admin/settings');
                              }),
                      ),
                      const SizedBox(width: 10),
                      const Text('>'),
                      const SizedBox(width: 10),
                      RichText(
                        text: const TextSpan(
                          text: 'Edit Profile',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 45.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'You can edit your profile details here.',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 50),
                  Form(
                    key: _formKey,
                    child: Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 30),
                          child: Column(
                            children: <Widget>[
                              Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(staff!.staffProfileImg),
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
                                        XFile? file =
                                            await imagePicker.pickImage(
                                                source: ImageSource.gallery);
                                        print('${file!.path}');

                                        StorageService _storageService =
                                            StorageService();
                                        _storageService.uploadStaffProfilePic(
                                            staff, file);
                                      },
                                      constraints: BoxConstraints.tight(
                                          const Size(30, 30)),
                                      elevation: 2.0,
                                      fillColor: const Color.fromARGB(
                                          255, 216, 216, 216),
                                      child: const Icon(Icons.edit,
                                          color: Colors.black),
                                      padding: const EdgeInsets.all(0.0),
                                      shape: const CircleBorder(),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(staff.staffFullName),
                              const SizedBox(height: 15),
                              Text(staff.staffEmail)
                            ],
                          ),
                        ),
                        SizedBox(
                            width: 430,
                            child: Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: const Text(
                                      'Username',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  TextFormField(
                                    initialValue: _currentFullName == ''
                                        ? staff.staffFullName
                                        : _currentFullName,
                                    decoration: textInputDecoration,
                                    validator: (value) => value == ''
                                        ? 'Please enter your full name'
                                        : null,
                                    onChanged: (value) => setState(
                                        () => _currentFullName = value),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: const Text(
                                      'First Name',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  TextFormField(
                                    initialValue: _currentFirstName == ''
                                        ? staff.staffFirstName
                                        : _currentFirstName,
                                    decoration: textInputDecoration,
                                    validator: (value) => value == ''
                                        ? 'Please enter your first name'
                                        : null,
                                    onChanged: (value) => setState(
                                        () => _currentFirstName = value),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: const Text(
                                      'Last Name',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  TextFormField(
                                    initialValue: _currentLastName == ''
                                        ? staff.staffLastName
                                        : _currentLastName,
                                    decoration: textInputDecoration,
                                    validator: (value) => value == ''
                                        ? 'Please enter your last name'
                                        : null,
                                    onChanged: (value) => setState(
                                        () => _currentLastName = value),
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: const Text(
                                      'Phone Number',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  TextFormField(
                                    initialValue: _currentPhoneNumber == ''
                                        ? staff.staffPhoneNumber
                                        : _currentPhoneNumber,
                                    decoration: textInputDecoration,
                                    validator: (value) => value == ''
                                        ? 'Please enter your phone number'
                                        : null,
                                    onChanged: (value) => setState(
                                        () => _currentPhoneNumber = value),
                                  ),
                                  const SizedBox(
                                    height: 30.0,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffF29180),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    child: const Text(
                                      'Update Profile Details',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        await staffDatabase(
                                                staffId: staff.staffId)
                                            .updateStaffData(
                                                staff.staffId,
                                                staff.staffCreatedDate,
                                                staff.staffUserType,
                                                _currentFullName == ''
                                                    ? staff.staffFullName
                                                    : _currentFullName,
                                                _currentFirstName == ''
                                                    ? staff.staffFirstName
                                                    : _currentFirstName,
                                                _currentLastName == ''
                                                    ? staff.staffLastName
                                                    : _currentLastName,
                                                staff.staffEmail,
                                                _currentPhoneNumber == ''
                                                    ? staff.staffPhoneNumber
                                                    : _currentPhoneNumber,
                                                staff
                                                    .staffSupportingDocumentLink,
                                                staff.staffProfileImg,
                                                staff.isVerified);
                                        context.go('/admin/settings');
                                      }
                                    },
                                  ),
                                ],
                              ),
                            )),
                        Expanded(child: Container())
                      ],
                    ),
                  )
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
