import 'package:flutter/material.dart';
import 'package:ummicare/screens/auth/staff_registration/applicationCompletion.dart';
import 'package:ummicare/services/staffApplicationDatabaseService.dart';
import 'package:ummicare/shared/constant.dart';

class teacherRegistration extends StatefulWidget {
  const teacherRegistration({super.key});

  @override
  State<teacherRegistration> createState() => _teacherRegistrationState();
}

class _teacherRegistrationState extends State<teacherRegistration> {
  final _formKey = GlobalKey<FormState>();

  //form values holder
  String firstName = '';
  String lastName = '';
  String fullName = '';
  String email = '';
  String phoneNumber = '';
  String supportingDocumentLink = '';
  String userType = 'teacher';
  String applicationStatus = 'pending';
  String submissionDate = DateTime.now().toString();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Teacher Registration",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Color(0xfff29180),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Please fill in your details',
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'First Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: firstName,
                    decoration: textInputDecoration.copyWith(hintText: 'First Name'),
                    validator: (value) => value == '' ? 'Please enter your first name' : null,
                    onChanged: ((value) => setState(() {
                      firstName = value;
                    })),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Last Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: lastName,
                    decoration: textInputDecoration.copyWith(hintText: 'Last Name'),
                    validator: (value) => value == '' ? 'Please enter your last name' : null,
                    onChanged: ((value) => setState(() {
                      lastName = value;
                    })),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Full Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: fullName,
                    decoration: textInputDecoration.copyWith(hintText: 'Full Name'),
                    validator: (value) => value == '' ? 'Please enter your full name' : null,
                    onChanged: ((value) => setState(() {
                      fullName = value;
                    })),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Email',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: email,
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (value) => value == '' ? 'Please enter your email' : null,
                    onChanged: ((value) => setState(() {
                      email = value;
                    })),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Phone Number',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: phoneNumber,
                    decoration: textInputDecoration.copyWith(hintText: 'Phone Number'),
                    validator: (value) => value == '' ? 'Please enter your phone number' : null,
                    onChanged: ((value) => setState(() {
                      phoneNumber = value;
                    })),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Supporting Documents Link',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  TextFormField(
                    initialValue: supportingDocumentLink,
                    decoration: textInputDecoration.copyWith(hintText: 'Supporting Document Link'),
                    validator: (value) => value == '' ? 'Please enter your supporting document link' : null,
                    onChanged: ((value) => setState(() {
                      supportingDocumentLink = value;
                    })),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff8290F0)),
                    child: Text(
                      'Submit Application',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await staffApplicationDatabaseService().createStaffApplicationData(firstName, lastName, fullName, email, phoneNumber, supportingDocumentLink, userType, applicationStatus, submissionDate);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  applicationCompletion()),
                        );
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
  }
}