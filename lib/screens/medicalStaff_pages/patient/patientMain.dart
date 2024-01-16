import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/patientGrid.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class patientMain extends StatefulWidget {
  const patientMain({super.key});

  @override
  State<patientMain> createState() => _patientMainState();
}

class _patientMainState extends State<patientMain> {
  final _formKey = GlobalKey<FormState>();

  String searchName = '';
  List<patientModel> patientList = [];

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder<medicalStaffModel>(
      stream: medicalStaffDatabase().medicalStaffData(user!.userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          medicalStaffModel? med = snapshot.data;
          return SingleChildScrollView(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Patient',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 50.0,
                          fontFamily: 'Comfortaa',
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
                  StreamBuilder<List<patientModel>>(
                      stream: PatientDatabaseService()
                          .allPatientData(med!.clinicId),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<patientModel>? patients = snapshot.data;
                          return Form(
                            key: _formKey,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    initialValue: searchName,
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Patient Name'),
                                    validator: (value) => value == ''
                                        ? 'Please enter patient name'
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
                                    patientList.clear();
                                    for (int i = 0; i < patients!.length; i++) {
                                      if (patients[i]
                                          .patientName
                                          .toLowerCase()
                                          .contains(searchName.toLowerCase())) {
                                        setState(() {
                                          patientList.add(patients[i]);
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
                    children: [
                      Expanded(
                        child: patientGrid(
                          patientList: patientList,
                        ),
                      ),
                      Expanded(child: Container())
                    ],
                  )
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
