import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/teacherPages/settings/schoolList.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class registerNewSchool extends StatefulWidget {
  const registerNewSchool({super.key});

  @override
  State<registerNewSchool> createState() => _registerNewSchoolState();
}

class _registerNewSchoolState extends State<registerNewSchool> {
  final _formKey = GlobalKey<FormState>();

  String searchName = '';
  List<schoolModel> schoolDetails = [];

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamProvider<teacherModel?>.value(
      value: teacherDatabase(teacherId: user!.userId).teacherData,
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
                            context.go('/teacher/settings');
                          }),
                  ),
                  const SizedBox(width: 10),
                  const Text('>'),
                  const SizedBox(width: 10),
                  RichText(
                    text: TextSpan(
                        text: 'School Registration',
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.go('/teacher/settings/schoolregistration');
                          }),
                  ),
                  const SizedBox(width: 10),
                  const Text('>'),
                  const SizedBox(width: 10),
                  RichText(
                    text: const TextSpan(
                      text: 'Register New School',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Register New School',
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
                  'Choose and register to new school.',
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
              StreamBuilder<List<schoolModel>>(
                  stream: schoolDatabase().allSchoolData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<schoolModel>? schools = snapshot.data;
                      return Form(
                        key: _formKey,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                initialValue: searchName,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'School Name'),
                                validator: (value) => value == ''
                                    ? 'Please enter school name'
                                    : null,
                                onChanged: ((value) => setState(() {
                                      searchName = value;
                                    })),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.search,
                                size: 30,
                                color: Colors.white,
                              ),
                              style: IconButton.styleFrom(
                                  backgroundColor: const Color(0xffF29180)),
                              onPressed: () async {
                                schoolDetails.clear();
                                for (int i = 0; i < schools!.length; i++) {
                                  if (schools[i]
                                      .schoolName
                                      .toLowerCase()
                                      .contains(searchName.toLowerCase())) {
                                    setState(() {
                                      schoolDetails.add(schools[i]);
                                    });
                                  }
                                }
                              },
                            ),
                            Expanded(flex: 2, child: Container()),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: const Text(
                        'Name',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: const Text(
                        'Address',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: const Text(
                        'Email',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: const Text(
                        'Contact Number',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: const Text(
                        'School ID',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              schoolList(schoolDetails: schoolDetails),
            ],
          ),
        ),
      ),
    );
  }
}
