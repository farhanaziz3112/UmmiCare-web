import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';

class clinicTile extends StatefulWidget {
  const clinicTile({super.key, required this.clinicDetail});
  final ClinicModel clinicDetail;

  @override
  State<clinicTile> createState() => _clinicTileState();
}

class _clinicTileState extends State<clinicTile> {
  //AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder<ClinicModel>(
      stream: medicalStaffDatabase(medicalStaffId: user!.userId).clinicData(widget.clinicDetail.clinicId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          ClinicModel? clinic = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: (() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      title: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                        child: Row(
                          children: [
                            const Icon(Icons.local_hospital),
                            const SizedBox(width: 10),
                            Text(clinic.clinicName),
                          ],
                        ),
                      ),
                      content: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
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
                              child: Text(
                                clinic.clinicPhoneNumber,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'REMINDER: Make sure you choose the right clinic before proceed to register!',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF29180),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel",
                              style: TextStyle(color: Colors.white)),
                        ),
                        StreamBuilder<medicalStaffModel>(
                            stream: medicalStaffDatabase(medicalStaffId: user.userId)
                                .medicalStaffData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                medicalStaffModel? medicalStaff = snapshot.data;
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff8290F0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            scrollable: true,
                                            title: const Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                  'Registration Confirmation'),
                                            ),
                                            content: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                      'Are you sure you want to register with '),
                                                  Text(
                                                    '${clinic.clinicName}?',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xffF29180),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
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
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                onPressed: () {
                                                  medicalStaffDatabase(
                                                          medicalStaffId: medicalStaff!
                                                              .medicalStaffId)
                                                      .updateMedicalStaffData(
                                                          medicalStaff.medicalStaffId,
                                                          medicalStaff
                                                              .medicalStaffCreatedDate,
                                                          medicalStaff
                                                              .medicalStaffFullName,
                                                          medicalStaff
                                                              .medicalStaffFirstName,
                                                          medicalStaff
                                                              .medicalStaffLastName,
                                                          medicalStaff.medicalStaffEmail,
                                                          medicalStaff
                                                              .medicalStaffPhoneNumber,
                                                          medicalStaff
                                                              .medicalStaffProfileImg,
                                                          clinic.clinicId);
                                                  context.go(
                                                      '/medicalStaff/settings/clinicregistration');
                                                },
                                                child: const Text("Confirm",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text("Register",
                                      style: TextStyle(color: Colors.white)),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ],
                    );
                  },
                );
              }),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                decoration: BoxDecoration(
                  color: const Color(0xff8290F0),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: Text(
                          clinic!.clinicName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: Text(
                          clinic.clinicAddress,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: Text(
                          clinic.clinicEmail,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: Text(
                          clinic.clinicPhoneNumber,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: Text(
                          clinic.clinicId,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
