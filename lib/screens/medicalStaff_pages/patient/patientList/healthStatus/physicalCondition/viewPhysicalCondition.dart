import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';

class viewPhysicalCondition extends StatefulWidget {
  const viewPhysicalCondition({super.key, required this.patientId, required this.physicalConditionId});
  final String patientId;
  final String physicalConditionId;

  @override
  State<viewPhysicalCondition> createState() => _viewPhysicalConditionState();
}

class _viewPhysicalConditionState extends State<viewPhysicalCondition> {

  HealthStatusModel? status;

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
                          text: TextSpan(
                            text: 'Physical Condition',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}/physicalcondition');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: widget.physicalConditionId,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Physical Condition',
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
                    StreamBuilder<PhysicalConditionModel>(
                      stream: healthDatabaseService().physicalConditionData(widget.physicalConditionId),
                      builder: ((context, snapshot) {
                        if(snapshot.hasData){
                          PhysicalConditionModel? physical = snapshot.data;
                          return SizedBox(
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
                                            'Physical Condition',
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
                                                    'Injury',
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
                                                    physical!.currentInjury,
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
                                                    physical.details,
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
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                    ),
                    const SizedBox(height: 30),
                    StreamBuilder<HealthStatusModel>(
                      stream: healthDatabaseService().healthStatusData(patient.healthStatusId),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          status = snapshot.data;
                          return Container();
                        }else{
                          return Container();
                        }
                      }
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.edit,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xff71CBCA),
                                fixedSize: const Size(250, 50),
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                              ),
                              onPressed: () {
                                context.go('/medicalstaff/patient/${patient.patientId}/physicalcondition/${widget.physicalConditionId}/editphysicalcondition');
                              },
                              label: const Text(
                                'Edit Physical Condition',
                                style:
                                    TextStyle(fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.delete,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xff8290F0),
                                fixedSize: const Size(250, 50),
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                              ),
                              onPressed: () async {
                                DocumentReference documentReference =
                                      FirebaseFirestore.instance.collection("Physical Condition").doc(widget.physicalConditionId);

                                await documentReference.delete();
                                
                                await healthDatabaseService().updateHealthStatusData(
                                  status!.healthStatusId,
                                  status!.healthConditionId,
                                  status?.physicalConditionId == widget.physicalConditionId
                                    ? ''
                                    : status!.physicalConditionId,
                                  status!.chronicConditionId,
                                  status!.patientId,
                                );

                                context.go('/medicalstaff/patient/${patient.patientId}/physicalcondition');
                              },
                              label: const Text(
                                'Delete Physical Condition',
                                style:
                                    TextStyle(fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
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
    } else {
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
                          text: TextSpan(
                            text: 'Physical Condition',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go(
                                    '/medicalstaff/patient/${patient.patientId}/physicalcondition');
                              },
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            text: widget.physicalConditionId,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Physical Condition',
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
                    StreamBuilder<PhysicalConditionModel>(
                      stream: healthDatabaseService().physicalConditionData(widget.physicalConditionId),
                      builder: ((context, snapshot) {
                        if(snapshot.hasData){
                          PhysicalConditionModel? physical = snapshot.data;
                          return SizedBox(
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
                                            'Physical Condition',
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
                                                    'Injury',
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
                                                    physical!.currentInjury,
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
                                                    physical.details,
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
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                    ),
                    const SizedBox(height: 30),
                    StreamBuilder<HealthStatusModel>(
                      stream: healthDatabaseService().healthStatusData(patient.healthStatusId),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          status = snapshot.data;
                          return Container();
                        }else{
                          return Container();
                        }
                      }
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.edit,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xff71CBCA),
                                fixedSize: const Size(250, 50),
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                              ),
                              onPressed: () {
                                context.go('/medicalstaff/patient/${patient.patientId}/physicalcondition/${widget.physicalConditionId}/editphysicalcondition');
                              },
                              label: const Text(
                                'Edit Physical Condition',
                                style:
                                    TextStyle(fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(width: 30),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton.icon(
                              icon: const Icon(
                                Icons.delete,
                                size: 24.0,
                                color: Colors.white,
                              ),
                              style: OutlinedButton.styleFrom(
                                backgroundColor: const Color(0xff8290F0),
                                fixedSize: const Size(250, 50),
                                alignment: Alignment.center,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    side: BorderSide.none),
                              ),
                              onPressed: () async {
                                DocumentReference documentReference =
                                      FirebaseFirestore.instance.collection("Physical Condition").doc(widget.physicalConditionId);

                                await documentReference.delete();

                                await healthDatabaseService().updateHealthStatusData(
                                  status!.healthStatusId,
                                  status!.healthConditionId,
                                  status?.physicalConditionId == widget.physicalConditionId
                                    ? ''
                                    : status!.physicalConditionId,
                                  status!.chronicConditionId,
                                  status!.patientId,
                                );
                                
                                context.go('/medicalstaff/patient/${patient.patientId}/physicalcondition');
                              },
                              label: const Text(
                                'Delete Physical Condition',
                                style:
                                    TextStyle(fontSize: 15.0, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
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
}
