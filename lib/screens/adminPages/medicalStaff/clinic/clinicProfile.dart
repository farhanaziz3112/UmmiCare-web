import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; 
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';

class clinicProfile extends StatefulWidget {
  const clinicProfile({super.key, required this.clinicId});
  final String clinicId;

  @override
  State<clinicProfile> createState() => _clinicProfileState();
}

class _clinicProfileState extends State<clinicProfile> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ClinicModel>(
      stream: medicalStaffDatabase().clinicData(widget.clinicId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ClinicModel? clinic = snapshot.data;
          return Container(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            text: 'Medical Staff',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/admin/medicalstaff');
                              }),
                      ),
                      const SizedBox(width: 10),
                      const Text('>'),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                            text: 'Clinic',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/admin/medicalstaff/clinic');
                              }),
                      ),
                      const SizedBox(width: 10),
                      const Text('>'),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          text: clinic!.clinicName,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      clinic.clinicName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 45.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      clinic.clinicEmail,
                      style: const TextStyle(
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
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Text(
                          'Clinic Details',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 25,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    final _formKey = GlobalKey<FormState>();

                                    String newClinicName = clinic.clinicName;
                                    String newClinicAddress =
                                        clinic.clinicAddress;
                                    String newClinicEmail = clinic.clinicEmail;
                                    String newClinicPhoneNumber =
                                        clinic.clinicPhoneNumber;

                                    return AlertDialog(
                                      scrollable: true,
                                      title: const Text('Edit Clinic Details'),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                initialValue: clinic.clinicName,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "Clinic Name",
                                                  icon: Icon(Icons.school),
                                                ),
                                                validator: (value) => value ==
                                                        ''
                                                    ? 'Please enter clinic name'
                                                    : null,
                                                onChanged: ((value) =>
                                                    setState(() {
                                                      newClinicName = value;
                                                    })),
                                              ),
                                              TextFormField(
                                                initialValue:
                                                    clinic.clinicAddress,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "Clinic Address",
                                                  icon:
                                                      Icon(Icons.location_city),
                                                ),
                                                validator: (value) => value ==
                                                        ''
                                                    ? 'Please enter clinic address'
                                                    : null,
                                                onChanged: ((value) =>
                                                    setState(() {
                                                      newClinicAddress = value;
                                                    })),
                                              ),
                                              TextFormField(
                                                initialValue:
                                                    clinic.clinicEmail,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "Clinic Email",
                                                  icon: Icon(Icons.email),
                                                ),
                                                validator: (value) => value ==
                                                        ''
                                                    ? 'Please enter clinic email'
                                                    : null,
                                                onChanged: ((value) =>
                                                    setState(() {
                                                      newClinicEmail = value;
                                                    })),
                                              ),
                                              TextFormField(
                                                initialValue:
                                                    clinic.clinicPhoneNumber,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText:
                                                      "Clinic Contact Number",
                                                  icon: Icon(Icons.phone),
                                                ),
                                                validator: (value) => value ==
                                                        ''
                                                    ? 'Please enter clinic contact number'
                                                    : null,
                                                onChanged: ((value) =>
                                                    setState(() {
                                                      newClinicPhoneNumber =
                                                          value;
                                                    })),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xffF29180),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Cancel",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xff8290F0),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                          ),
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              medicalStaffDatabase().updateClinicData(
                                                  clinic.clinicId,
                                                  newClinicName,
                                                  newClinicAddress,
                                                  newClinicEmail,
                                                  newClinicPhoneNumber);
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: const Text("Update",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            style: IconButton.styleFrom(
                                backgroundColor: const Color(0xffF29180)))
                      ],
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
                                'Clinic Name',
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
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                clinic.clinicName,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: const Text(
                                'Clinic Email',
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
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                clinic.clinicEmail,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: const Text(
                                'Clinic Address',
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
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                clinic.clinicAddress,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: const Text(
                                'Clinic Contact Number',
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
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                clinic.clinicPhoneNumber,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 2, child: Container()),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
