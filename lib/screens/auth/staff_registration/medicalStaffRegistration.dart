import 'package:flutter/material.dart';
import 'package:ummicare/screens/auth/staff_registration/applicationCompletion.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/shared/constant.dart';

class medicalStaffRegistration extends StatefulWidget {
  const medicalStaffRegistration({super.key});

  @override
  State<medicalStaffRegistration> createState() =>
      _medicalStaffRegistrationState();
}

class _medicalStaffRegistrationState extends State<medicalStaffRegistration> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  //authentication
  String email = '';
  String password = '';

  //account details
  String staffUserType = 'medicalstaff';
  String staffFullName = '';
  String staffFirstName = '';
  String staffLastName = '';
  String staffEmail = '';
  String staffPhoneNumber = '';
  String staffProfileImg = 'https://firebasestorage.googleapis.com/v0/b/ummicare-6db1a.appspot.com/o/other%2Fistockphoto-1223671392-612x612.jpg?alt=media&token=0c876dbc-4385-4270-95bc-7a2130f243b1';
  String isVerified = 'false';
  String staffSupportingDocumentLink = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Medical Staff Registration",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: const Color(0xfff29180),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Row(
            children: [
              Expanded(child: Container()),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 40.0, horizontal: 30.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        const Text(
                          'Please fill in your details.',
                          style: TextStyle(
                              fontSize: 23.0, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.start,
                        ),
                        const SizedBox(height: 30.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10.0),
                          child: const Text(
                            'Authentication Details:',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: const Text(
                            'Email',
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
                          initialValue: email,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          validator: (value) =>
                              value == '' ? 'Please enter your email' : null,
                          onChanged: ((value) => setState(() {
                                email = value;
                              })),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: const Text(
                            'Password',
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
                          initialValue: password,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          obscureText: true,
                          validator: (value) =>
                              value == '' ? 'Please enter your password' : null,
                          onChanged: ((value) => setState(() {
                                password = value;
                              })),
                        ),
                        const SizedBox(height: 30.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 10.0),
                          child: const Text(
                            'Account Details:',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(height: 20.0),
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
                          initialValue: staffFirstName,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'First Name'),
                          validator: (value) => value == ''
                              ? 'Please enter your first name'
                              : null,
                          onChanged: ((value) => setState(() {
                                staffFirstName = value;
                              })),
                        ),
                        const SizedBox(height: 20.0),
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
                          initialValue: staffLastName,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Last Name'),
                          validator: (value) => value == ''
                              ? 'Please enter your last name'
                              : null,
                          onChanged: ((value) => setState(() {
                                staffLastName = value;
                              })),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: const Text(
                            'Full Name',
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
                          initialValue: staffFullName,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Full Name'),
                          validator: (value) => value == ''
                              ? 'Please enter your full name'
                              : null,
                          onChanged: ((value) => setState(() {
                                staffFullName = value;
                              })),
                        ),
                        const SizedBox(height: 20.0),
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
                          initialValue: staffPhoneNumber,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Phone Number'),
                          validator: (value) => value == ''
                              ? 'Please enter your phone number'
                              : null,
                          onChanged: ((value) => setState(() {
                                staffPhoneNumber = value;
                              })),
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 20.0),
                          child: const Text(
                            'Supporting Documents Link',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        TextFormField(
                          initialValue: staffSupportingDocumentLink,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Supporting Document Link'),
                          validator: (value) => value == ''
                              ? 'Please enter your supporting document link'
                              : null,
                          onChanged: ((value) => setState(() {
                                staffSupportingDocumentLink = value;
                              })),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff8290F0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: const Text(
                            'Submit Application',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              dynamic result =
                                  await _auth.registerStaffWithEmailAndPassword(
                                      email,
                                      password,
                                      staffUserType,
                                      staffFullName,
                                      staffFirstName,
                                      staffLastName,
                                      staffPhoneNumber,
                                      staffProfileImg,
                                      staffSupportingDocumentLink,
                                      isVerified);
                              print(result);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const applicationCompletion()),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          height: 100.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
