import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/feeModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/services/childDatabase.dart';
import 'package:ummicare/services/feeDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class studentPaymentTile extends StatefulWidget {
  const studentPaymentTile({super.key, required this.feePaymentId});
  final String feePaymentId;

  @override
  State<studentPaymentTile> createState() => _studentPaymentTileState();
}

class _studentPaymentTileState extends State<studentPaymentTile> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return StreamBuilder<feePaymentModel>(
      stream: feeDatabase().feePaymentData(widget.feePaymentId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          feePaymentModel? feePayment = snapshot.data;
          return StreamBuilder(
            stream: studentDatabase().studentData(feePayment!.studentId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                studentModel? student = snapshot.data;
                return StreamBuilder(
                    stream: childDatabase(childId: student!.childId).childData,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        childModel? child = snapshot.data;
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(1)),
                                border: Border.all(color: Colors.grey),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                    offset: const Offset(
                                        0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: feePayment.feePaymentStatus == 'unpaid'
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            alignment: Alignment.center,
                                            constraints: const BoxConstraints(
                                                minWidth: 100, maxWidth: 200),
                                            child: Text(
                                              child!.childName,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.black,
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
                                              feePayment.studentId,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.black,
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
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.red[300],
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  10)),
                                                    ),
                                                    padding: const EdgeInsets.all(5),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        screenSize.width < 1300 ? Container() : const Icon(
                                                          Icons.cancel,
                                                          color: Colors.white,
                                                        ),
                                                        screenSize.width < 1300 ? Container() : const SizedBox(
                                                          width: 10,
                                                        ),
                                                        const Text(
                                                          'Unpaid',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                      ],
                                                    )),
                                              ),
                                              Expanded(
                                                  flex: 1, child: Container())
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : feePayment.feePaymentStatus == 'pending'
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment: Alignment.center,
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth: 100,
                                                        maxWidth: 200),
                                                child: Text(
                                                  child!.childName,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.black,
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
                                                    const BoxConstraints(
                                                        minWidth: 100,
                                                        maxWidth: 200),
                                                child: Text(
                                                  feePayment
                                                      .feePaymentAmountPaid,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                                    const BoxConstraints(
                                                        minWidth: 100,
                                                        maxWidth: 200),
                                                child: Text(
                                                  convertTimeToDateWithStringMonth(
                                                      feePayment
                                                          .feePaymentDate),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .yellow[800],
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        padding:
                                                            const EdgeInsets.all(5),
                                                        child:  Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            screenSize.width < 1300 ? Container() : const Icon(
                                                          Icons.schedule,
                                                          color: Colors.white,
                                                        ),
                                                        screenSize.width < 1300 ? Container() : const SizedBox(
                                                          width: 10,
                                                        ),
                                                        const Text(
                                                          'Pending',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                          ],
                                                        )),
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        icon: const Icon(Icons
                                                            .arrow_forward_ios),
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return StreamBuilder<
                                                                    feePaymentModel>(
                                                                  stream: feeDatabase()
                                                                      .feePaymentData(
                                                                          feePayment
                                                                              .feePaymentId),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    if (snapshot
                                                                        .hasData) {
                                                                      return AlertDialog(
                                                                        scrollable:
                                                                            true,
                                                                        title:
                                                                            const Padding(
                                                                          padding:
                                                                              EdgeInsets.all(10.0),
                                                                          child:
                                                                              Text('Fee Payment Confirmation'),
                                                                        ),
                                                                        content:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              10),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              const SizedBox(height: 20),
                                                                              const Text(
                                                                                'Payment Date',
                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                              ),
                                                                              const SizedBox(height: 5),
                                                                              Text('${convertTimeToDateWithStringMonth(feePayment.feePaymentDate)}'),
                                                                              const SizedBox(height: 10),
                                                                              const Text(
                                                                                'Payment Proof Image',
                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                              ),
                                                                              const SizedBox(height: 10),
                                                                              ImageNetwork(
                                                                                image: feePayment.feePaymentProofImg,
                                                                                height: 600,
                                                                                width: 400,
                                                                                borderRadius: BorderRadius.zero,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        actions: [
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: const Color(0xffF29180),
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                const Text("Cancel", style: TextStyle(color: Colors.white)),
                                                                          ),
                                                                          ElevatedButton(
                                                                            style:
                                                                                ElevatedButton.styleFrom(
                                                                              backgroundColor: const Color(0xff8290F0),
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                                                                            ),
                                                                            onPressed:
                                                                                () {
                                                                              feeDatabase().updateFeePaymentData(feePayment.feePaymentId, feePayment.feeId, feePayment.studentId, feePayment.academicCalendarId, feePayment.feePaymentAmountPaid, 'paid', feePayment.feePaymentDate, feePayment.feePaymentProofImg);
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                const Text("Confirm", style: TextStyle(color: Colors.white)),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    } else {
                                                                      return const Loading();
                                                                    }
                                                                  },
                                                                );
                                                              });
                                                        },
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                alignment: Alignment.center,
                                                constraints:
                                                    const BoxConstraints(
                                                        minWidth: 100,
                                                        maxWidth: 200),
                                                child: Text(
                                                  child!.childName,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.black,
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
                                                    const BoxConstraints(
                                                        minWidth: 100,
                                                        maxWidth: 200),
                                                child: Text(
                                                  feePayment
                                                      .feePaymentAmountPaid,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                                    const BoxConstraints(
                                                        minWidth: 100,
                                                        maxWidth: 200),
                                                child: Text(
                                                  convertTimeToDateWithStringMonth(
                                                      feePayment
                                                          .feePaymentDate),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.normal,
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
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Colors.green[500],
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          10)),
                                                        ),
                                                        padding:
                                                            const EdgeInsets.all(5),
                                                        child:  Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            screenSize.width < 1300 ? Container() : const Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                        ),
                                                        screenSize.width < 1300 ? Container() : const SizedBox(
                                                          width: 10,
                                                        ),
                                                        const Text(
                                                          'Paid',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        )
                                                          ],
                                                        )),
                                                  ),
                                                  Expanded(
                                                      flex: 1,
                                                      child: IconButton(
                                                        icon: const Icon(Icons
                                                            .arrow_forward_ios),
                                                        onPressed: () {
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return StreamBuilder<
                                                                    feePaymentModel>(
                                                                  stream: feeDatabase()
                                                                      .feePaymentData(
                                                                          feePayment
                                                                              .feePaymentId),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    if (snapshot
                                                                        .hasData) {
                                                                      return AlertDialog(
                                                                        scrollable:
                                                                            true,
                                                                        title:
                                                                            const Padding(
                                                                          padding:
                                                                              EdgeInsets.all(10.0),
                                                                          child:
                                                                              Text('Fee Payment Confirmation'),
                                                                        ),
                                                                        content:
                                                                            Padding(
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              10),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: <Widget>[
                                                                              const SizedBox(height: 20),
                                                                              const Text(
                                                                                'Payment Date',
                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                              ),
                                                                              const SizedBox(height: 5),
                                                                              Text('${convertTimeToDateWithStringMonth(feePayment.feePaymentDate)}'),
                                                                              const SizedBox(height: 10),
                                                                              const Text(
                                                                                'Payment Proof Image',
                                                                                style: TextStyle(fontWeight: FontWeight.bold),
                                                                              ),
                                                                              const SizedBox(height: 10),
                                                                              ImageNetwork(
                                                                                image: feePayment.feePaymentProofImg,
                                                                                fullScreen: true,
                                                                                height: 600,
                                                                                width: 400,
                                                                                borderRadius: BorderRadius.zero,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    } else {
                                                                      return const Loading();
                                                                    }
                                                                  },
                                                                );
                                                              });
                                                        },
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        )),
                        );
                      } else {
                        return const Loading();
                      }
                    });
              } else {
                return const Loading();
              }
            },
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
