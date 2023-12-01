import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class addSchool extends StatefulWidget {
  const addSchool({super.key});

  @override
  State<addSchool> createState() => _addSchoolState();
}

class _addSchoolState extends State<addSchool> {
  final _formKey = GlobalKey<FormState>();

  String schoolName = "";
  String schoolAddress = "";
  String schoolEmail = "";
  String schoolPhoneNumber = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      text: 'Teacher',
                      style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go('/admin/teacher');
                        }),
                ),
                const SizedBox(width: 10),
                const Text('>'),
                const SizedBox(width: 10),
                RichText(
                  text: TextSpan(
                      text: 'School',
                      style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go('/admin/teacher/school');
                        }),
                ),
                const SizedBox(width: 10),
                const Text('>'),
                const SizedBox(width: 10),
                RichText(
                  text: const TextSpan(
                    text: 'Add School',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Add New School',
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
                'Register new school into the system.',
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
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20.0),
                        child: const Text(
                          'School Name',
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
                        initialValue: schoolName,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'School Name'),
                        validator: (value) =>
                            value == '' ? 'Please enter school name' : null,
                        onChanged: ((value) => setState(() {
                              schoolName = value;
                            })),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20.0),
                        child: const Text(
                          'School Address',
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
                        initialValue: schoolAddress,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'School Address'),
                        validator: (value) =>
                            value == '' ? 'Please enter school address' : null,
                        onChanged: ((value) => setState(() {
                              schoolAddress = value;
                            })),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20.0),
                        child: const Text(
                          'School Email',
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
                        initialValue: schoolPhoneNumber,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'School Email'),
                        validator: (value) =>
                            value == '' ? 'Please enter school email' : null,
                        onChanged: ((value) => setState(() {
                              schoolEmail = value;
                            })),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(left: 20.0),
                        child: const Text(
                          'School Contact Number',
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
                        initialValue: schoolPhoneNumber,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'School Contact Number'),
                        validator: (value) => value == ''
                            ? 'Please enter school contact number'
                            : null,
                        onChanged: ((value) => setState(() {
                              schoolPhoneNumber = value;
                            })),
                      ),
                    ],
                  ),
                ),
                Expanded(flex: 2, child: Container()),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff8290F0),
                fixedSize: const Size(300, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: const Text(
                'Submit School Registration',
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  //await staffApplicationDatabaseService().createStaffApplicationData(firstName, lastName, fullName, email, phoneNumber, supportingDocumentLink, staffType, applicationStatus, submissionDate);
                  schoolDatabase().createSchoolData(schoolName, schoolAddress, schoolEmail, schoolPhoneNumber);
                  context.go('/admin/teacher/school');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
