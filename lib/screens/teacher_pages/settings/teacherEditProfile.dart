import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/services/staffDatabase.dart';
import 'package:ummicare/services/storage.dart';
import 'package:ummicare/shared/constant.dart';

class teacherEditProfile extends StatefulWidget {
  const teacherEditProfile({super.key, required this.teacherId});
  final String teacherId;

  @override
  State<teacherEditProfile> createState() => _teacherEditProfileState();
}

class _teacherEditProfileState extends State<teacherEditProfile> {

  final _formKey = GlobalKey<FormState>();

  //form values holder
  String _currentFullName = '';
  String _currentFirstName = '';
  String _currentLastName = '';
  String _currentPhoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<staffUserModel>(
      stream: staffDatabase(staffId: widget.teacherId).staffData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          staffUserModel? staff = snapshot.data;
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
              iconTheme: const IconThemeData(color: Colors.black),
              centerTitle: true,
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              elevation: 3,
            ),
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                  child: Form(
                    key: _formKey,
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
                                  XFile? file = await imagePicker.pickImage(
                                      source: ImageSource.camera);
                                  print('${file!.path}');
              
                                  StorageService _storageService = StorageService();
                                  _storageService.uploadStaffProfilePic(
                                      staff, file);
                                },
                                constraints: BoxConstraints.tight(const Size(30, 30)),
                                elevation: 2.0,
                                fillColor: const Color.fromARGB(255, 216, 216, 216),
                                child: const Icon(Icons.edit, color: Colors.black),
                                padding: const EdgeInsets.all(0.0),
                                shape: const CircleBorder(),
                              ),
                            )
                          ],
                        ),
                        // CircleAvatar(
                        //   radius: 50.0,
                        //   backgroundImage: NetworkImage(usermodel.userProfileImg),
                        // ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
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
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          initialValue: _currentFullName == ''
                              ? staff.staffFullName
                              : _currentFullName,
                          decoration: textInputDecoration,
                          validator: (value) =>
                              value == '' ? 'Please enter your full name' : null,
                          onChanged: (value) =>
                              setState(() => _currentFullName = value),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
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
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          initialValue: _currentFirstName == ''
                              ? staff.staffFirstName
                              : _currentFirstName,
                          decoration: textInputDecoration,
                          validator: (value) =>
                              value == '' ? 'Please enter your first name' : null,
                          onChanged: (value) =>
                              setState(() => _currentFirstName = value),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
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
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          initialValue: _currentLastName == ''
                              ? staff.staffLastName
                              : _currentLastName,
                          decoration: textInputDecoration,
                          validator: (value) =>
                              value == '' ? 'Please enter your last name' : null,
                          onChanged: (value) =>
                              setState(() => _currentLastName = value),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
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
                        const SizedBox(
                          height: 5.0,
                        ),
                        TextFormField(
                          initialValue: _currentPhoneNumber == ''
                              ? staff.staffPhoneNumber
                              : _currentPhoneNumber,
                          decoration: textInputDecoration,
                          validator: (value) =>
                              value == '' ? 'Please enter your phone number' : null,
                          onChanged: (value) =>
                              setState(() => _currentPhoneNumber = value),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff8290F0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)
                            ),
                          ),
                          child: const Text(
                            'Update Profile Details',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await staffDatabase(staffId: staff.staffId)
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
                                      staff.staffSupportingDocumentLink,
                                      staff.staffProfileImg,
                                      staff.isVerified);
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
          return Container(child: const Text('no data'));
        }
      },
    );
  }
}