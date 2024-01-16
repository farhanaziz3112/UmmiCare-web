import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';

class clinicTile extends StatefulWidget {
  const clinicTile({super.key, required this.clinicDetails});
  final ClinicModel clinicDetails;

  @override
  State<clinicTile> createState() => _schoolTileState();
}

class _schoolTileState extends State<clinicTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ClinicModel>(
      stream: medicalStaffDatabase().clinicData(widget.clinicDetails.clinicId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          ClinicModel? clinic = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: (() {
                    var id = clinic.clinicId;
                    context.go('/admin/medicalstaff/clinic/${id}');
                  }),
              child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
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
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
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
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
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
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
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
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
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