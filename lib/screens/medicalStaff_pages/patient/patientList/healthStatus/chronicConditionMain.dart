import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/patient/patientList/healthStatus/chronicCondition/chronicConditionList.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class chronicConditionMain extends StatefulWidget {
  const chronicConditionMain({super.key, required this.patientId});
  final String patientId;

  @override
  State<chronicConditionMain> createState() => _chronicConditionMainState();
}

class _chronicConditionMainState extends State<chronicConditionMain> {
  final _formKey = GlobalKey<FormState>();

  String searchName = '';
  List<ChronicConditionModel> chronicDetails = [];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 1300) {
      return StreamBuilder<patientModel>(
        stream: PatientDatabaseService().patientData(widget.patientId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            patientModel? patient = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: 'Patient',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/medicalstaff/patient');
                                }),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: patient!.patientName,
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: const TextSpan(
                            text: 'Chronic Condition',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Chronic Condition',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 45.0,
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
                    StreamBuilder<HealthStatusModel>(
                      stream: healthDatabaseService().healthStatusData(patient.healthStatusId),
                      builder:(context, snapshot) {
                        HealthStatusModel? health = snapshot.data;
                        if(snapshot.hasData && health!.chronicConditionId.isNotEmpty){
                          return StreamBuilder<ChronicConditionModel>(
                            stream: healthDatabaseService().chronicConditionData(health.chronicConditionId),
                            builder: ((context, snapshot) {
                              if(snapshot.hasData){
                                ChronicConditionModel? chronic = snapshot.data;
                                return SizedBox(
                                  height: 300,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(),
                                            borderRadius:
                                                const BorderRadius.all(Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: const Offset(
                                                    0, 3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.topCenter,
                                                child: const Text(
                                                  'Latest Chronic Condition',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0,
                                                      fontFamily: 'Comfortaa',
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              const SizedBox(height: 30),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        alignment: Alignment.centerLeft,
                                                        padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                        child: const Text(
                                                          'Allergies',
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:FontWeight.bold,
                                                            color: Colors.black),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Container(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 20),
                                                        child: Text(
                                                          chronic!.childAllergies,
                                                          textAlign: TextAlign.left,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                              color: Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        alignment: Alignment.centerLeft,
                                                        padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                        child: const Text(
                                                          'Details',
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:FontWeight.bold,
                                                            color: Colors.black),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Container(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 20),
                                                        child: Text(
                                                          chronic.childChronic,
                                                          textAlign: TextAlign.left,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                              color: Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Expanded(
                                        child: Container(),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                          );
                        }else{
                          return SizedBox(
                            height: 300,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topCenter,
                                          child: const Text(
                                            'Latest Chronic Condition',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding:
                                                    const EdgeInsets.only(
                                                        left: 20),
                                                  child: const Text(
                                                    'Allergies',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:FontWeight.bold,
                                                      color: Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: const Text(
                                                    "No data",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding:
                                                    const EdgeInsets.only(
                                                        left: 20),
                                                  child: const Text(
                                                    'Details',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:FontWeight.bold,
                                                      color: Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: const Text(
                                                    "No data",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: Container(),
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    Container(
                      alignment: Alignment.bottomLeft,
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
                          context.go('/medicalstaff/patient/${patient.patientId}/chroniccondition/addnewchroniccondition');
                        },
                        label: const Text(
                          'Add New Chronic Condition',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'History',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder<List<ChronicConditionModel>>(
                      stream: healthDatabaseService().allChronicConditionData(widget.patientId),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          List<ChronicConditionModel>? chronic = snapshot.data;
                          return Form(
                            key: _formKey,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    initialValue: searchName,
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Allergies'),
                                    validator: (value) => value == ''
                                        ? 'Please enter the allergies'
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
                                    chronicDetails.clear();
                                    for (int i = 0; i < chronic!.length; i++) {
                                      if (chronic[i]
                                          .childAllergies
                                          .toLowerCase()
                                          .contains(searchName.toLowerCase())) {
                                        setState(() {
                                          chronicDetails.add(chronic[i]);
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
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            constraints:
                                const BoxConstraints(minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Allergies',
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.center,
                            constraints:
                                const BoxConstraints(minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Details',
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.center,
                            constraints:
                                const BoxConstraints(minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Health Condition Id',
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    chronicConditionList(chronicDetail: chronicDetails)
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        },
      );
    }else{
      return StreamBuilder<patientModel>(
        stream: PatientDatabaseService().patientData(widget.patientId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            patientModel? patient = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: 'Patient',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/medicalstaff/patient');
                                }),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: patient!.patientName,
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: const TextSpan(
                            text: 'Chronic Condition',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Chronic Condition',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 45.0,
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
                    StreamBuilder<HealthStatusModel>(
                      stream: healthDatabaseService().healthStatusData(patient.healthStatusId),
                      builder:(context, snapshot) {
                        HealthStatusModel? health = snapshot.data;
                        if(snapshot.hasData && health!.chronicConditionId.isNotEmpty){
                          return StreamBuilder<ChronicConditionModel>(
                            stream: healthDatabaseService().chronicConditionData(health.chronicConditionId),
                            builder: ((context, snapshot) {
                              if(snapshot.hasData){
                                ChronicConditionModel? chronic = snapshot.data;
                                return SizedBox(
                                  height: 300,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(),
                                            borderRadius:
                                                const BorderRadius.all(Radius.circular(10)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: const Offset(
                                                    0, 3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                alignment: Alignment.topCenter,
                                                child: const Text(
                                                  'Latest Chronic Condition',
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 20.0,
                                                      fontFamily: 'Comfortaa',
                                                      fontWeight: FontWeight.bold),
                                                ),
                                              ),
                                              const SizedBox(height: 30),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        alignment: Alignment.centerLeft,
                                                        padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                        child: const Text(
                                                          'Allergies',
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:FontWeight.bold,
                                                            color: Colors.black),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Container(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 20),
                                                        child: Text(
                                                          chronic!.childAllergies,
                                                          textAlign: TextAlign.left,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                              color: Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Container(
                                                        alignment: Alignment.centerLeft,
                                                        padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                        child: const Text(
                                                          'Details',
                                                          textAlign: TextAlign.left,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:FontWeight.bold,
                                                            color: Colors.black),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 5),
                                                      Container(
                                                        alignment:
                                                            Alignment.centerLeft,
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 20),
                                                        child: Text(
                                                          chronic.childChronic,
                                                          textAlign: TextAlign.left,
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight.normal,
                                                              color: Colors.black),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      Expanded(
                                        child: Container(),
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                          );
                        }else{
                          return SizedBox(
                            height: 300,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(),
                                      borderRadius:
                                          const BorderRadius.all(Radius.circular(10)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(
                                              0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.topCenter,
                                          child: const Text(
                                            'Latest Chronic Condition',
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20.0,
                                                fontFamily: 'Comfortaa',
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding:
                                                    const EdgeInsets.only(
                                                        left: 20),
                                                  child: const Text(
                                                    'Allergies',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:FontWeight.bold,
                                                      color: Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: const Text(
                                                    "No data",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  alignment: Alignment.centerLeft,
                                                  padding:
                                                    const EdgeInsets.only(
                                                        left: 20),
                                                  child: const Text(
                                                    'Details',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:FontWeight.bold,
                                                      color: Colors.black),
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Container(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: const Text(
                                                    "No data",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: Container(),
                                )
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    Container(
                      alignment: Alignment.bottomLeft,
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
                          context.go('/medicalstaff/patient/${patient.patientId}/chroniccondition/addnewchroniccondition');
                        },
                        label: const Text(
                          'Add New Chronic Condition',
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'History',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30.0,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 20),
                    StreamBuilder<List<ChronicConditionModel>>(
                      stream: healthDatabaseService().allChronicConditionData(widget.patientId),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          List<ChronicConditionModel>? chronic = snapshot.data;
                          return Form(
                            key: _formKey,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    initialValue: searchName,
                                    decoration: textInputDecoration.copyWith(
                                        hintText: 'Allergies'),
                                    validator: (value) => value == ''
                                        ? 'Please enter the allergies'
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
                                    chronicDetails.clear();
                                    for (int i = 0; i < chronic!.length; i++) {
                                      if (chronic[i]
                                          .childAllergies
                                          .toLowerCase()
                                          .contains(searchName.toLowerCase())) {
                                        setState(() {
                                          chronicDetails.add(chronic[i]);
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
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            constraints:
                                const BoxConstraints(minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Allergies',
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.center,
                            constraints:
                                const BoxConstraints(minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Details',
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.center,
                            constraints:
                                const BoxConstraints(minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Health Condition Id',
                              style: TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    chronicConditionList(chronicDetail: chronicDetails)
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
}