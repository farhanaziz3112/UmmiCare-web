import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class addNewClinic extends StatefulWidget {
  const addNewClinic({super.key});

  @override
  State<addNewClinic> createState() => _addNewClinicState();
}

class _addNewClinicState extends State<addNewClinic> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String address = '';
  String email = '';
  String num = '';

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamProvider<medicalStaffModel?>.value(
      value: medicalStaffDatabase(medicalStaffId: user!.userId).medicalStaffData,
      initialData: null,
      catchError: (_, __) {
        return null;
      },
      child: Container(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
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
                            context.go('/medicalstaff/settings');
                          }),
                  ),
                  const SizedBox(width: 10),
                  const Text('>'),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                        text: 'Clinic Registration',
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go('/medicalstaff/settings/clinicregistration');
                          }),
                  ),
                  const SizedBox(width: 10),
                  const Text('>'),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                        text: 'Register New Clinic',
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go('/medicalstaff/settings/clinicregistration/registernewclinic');
                          }),
                  ),
                  const SizedBox(width: 10),
                  const Text('>'),
                  const SizedBox(width: 10),
                  RichText(
                    text: const TextSpan(
                      text: 'Add New Clinic',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Register New Clinic',
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
                  'Choose and register to new Clinic.',
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
              const SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Name',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        initialValue: name,
                        decoration: textInputDecoration,
                        validator: (value) =>
                            value == '' ? 'Please enter the name' : null,
                        onChanged: (value) =>
                            setState(() => name = value),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Address',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        initialValue: address,
                        decoration: textInputDecoration,
                        validator: (value) =>
                            value == '' ? 'Please enter the address' : null,
                        onChanged: (value) =>
                            setState(() => address = value),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Email',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        initialValue: email,
                        decoration: textInputDecoration,
                        validator: (value) =>
                            value == '' ? 'Please enter the email' : null,
                        onChanged: (value) =>
                            setState(() => email = value),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Contact Number',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                        initialValue: num,
                        decoration: textInputDecoration,
                        validator: (value) =>
                            value == '' ? 'Please enter the contact Number' : null,
                        onChanged: (value) =>
                            setState(() => num = value),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await medicalStaffDatabase(medicalStaffId: user.userId)
                              .createClinicData(name,address,num);   
                          }

                          Navigator.pop(context);
                      }
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
