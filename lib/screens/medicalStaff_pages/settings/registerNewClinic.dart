import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/settings/clinicList.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class registerNewClinic extends StatefulWidget {
  const registerNewClinic({super.key});

  @override
  State<registerNewClinic> createState() => _registerNewClinicState();
}

class _registerNewClinicState extends State<registerNewClinic> {
  final _formKey = GlobalKey<FormState>();

  String searchName = '';
  List<ClinicModel> ClinicDetails = [];

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
                            context.go('/medicalStaff/settings');
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
                            context.go('/medicalStaff/settings/clinicregistration');
                          }),
                  ),
                  const SizedBox(width: 10),
                  const Text('>'),
                  const SizedBox(width: 10),
                  RichText(
                    text: const TextSpan(
                      text: 'Register New Clinic',
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
              const SizedBox(height: 50),
              StreamBuilder<List<ClinicModel>>(
                  stream: medicalStaffDatabase(medicalStaffId: user.userId).allClinicData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<ClinicModel>? clinics = snapshot.data;
                      return Form(
                        key: _formKey,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                initialValue: searchName,
                                decoration: textInputDecoration.copyWith(
                                    hintText: 'Clinic Name'),
                                validator: (value) => value == ''
                                    ? 'Please enter Clinic name'
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
                                ClinicDetails.clear();
                                for (int i = 0; i < clinics!.length; i++) {
                                  if (clinics[i]
                                      .clinicName
                                      .toLowerCase()
                                      .contains(searchName.toLowerCase())) {
                                    setState(() {
                                      ClinicDetails.add(clinics[i]);
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
                        'Clinic ID',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              clinicList(clinicDetails: ClinicDetails),
            ],
          ),
        ),
      ),
    );
  }
}
