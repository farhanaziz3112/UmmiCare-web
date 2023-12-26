import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';

class clinicRegistration extends StatefulWidget {
  const clinicRegistration({super.key});

  @override
  State<clinicRegistration> createState() => _clinicRegistrationState();
}

class _clinicRegistrationState extends State<clinicRegistration> {
  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder<medicalStaffModel>(
      stream: medicalStaffDatabase(medicalStaffId: user!.userId).medicalStaffData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          medicalStaffModel? medicalStaff = snapshot.data;
          return Container(
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
                        text: const TextSpan(
                          text: 'clinic Registration',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'clinic Registration',
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
                      'You can register and enrol to new clinic here.',
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
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'clinic Details',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(width: 40),
                      Container(
                        alignment: Alignment.topLeft,
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.add_circle,
                            size: 24.0,
                            color: Colors.white,
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: const Color(0xffF29180),
                            fixedSize: const Size(250, 50),
                            alignment: Alignment.center,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                                side: BorderSide.none),
                          ),
                          onPressed: () {
                            context.go('/medicalStaff/settings/clinicregistration/registernewclinic');
                          },
                          label: const Text(
                            'Register New clinic',
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  medicalStaff!.clinicId != ''
                      ? Row(
                          children: <Widget>[
                            StreamBuilder<ClinicModel>(
                                stream: medicalStaffDatabase(medicalStaffId: medicalStaff.medicalStaffId)
                                    .clinicData(medicalStaff.clinicId),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    ClinicModel? clinic = snapshot.data;
                                    return Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: const Text(
                                              'clinic Name',
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
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Text(
                                              clinic!.clinicName,
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
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: const Text(
                                              'clinic Email',
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
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
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
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: const Text(
                                              'clinic Address',
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
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
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
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: const Text(
                                              'clinic Contact Number',
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
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
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
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),
                            Expanded(flex: 2, child: Container()),
                          ],
                        )
                      : Container(
                          alignment: Alignment.centerLeft,
                          child: const Text(
                              'No clinic registered at the moment! Please click \'Register New clinic\' button above to register to new clinic.'),
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
