import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/feeModel.dart';
import 'package:ummicare/services/feeDatabase.dart';
import 'package:ummicare/shared/function.dart';

class feeTile extends StatefulWidget {
  const feeTile({super.key, required this.fee});
  final feeModel fee;

  @override
  State<feeTile> createState() => _feeTileState();
}

class _feeTileState extends State<feeTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<feeModel>(
      stream: feeDatabase().feeData(widget.fee.feeId),
      builder: ((contextt, snapshot) {
        if (snapshot.hasData) {
          feeModel? fee = snapshot.data;
          return InkWell(
            onTap: () {
              context.go(
                  '/teacher/class/${fee.academicCalendarId}/fee/${fee.feeId}');
            },
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      fee!.feeTitle,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Fee Amount',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text('RM ${fee.feeAmount}'),
                    const SizedBox(height: 10),
                    const Text(
                      'Fee Description',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(fee.feeDescription),
                    const SizedBox(height: 10),
                    const Text(
                      'Fee Deadline',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(convertTimeToDateString(fee.feeDeadline)),
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
