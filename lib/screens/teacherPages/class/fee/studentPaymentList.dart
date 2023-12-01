import 'package:flutter/material.dart';
import 'package:ummicare/models/feeModel.dart';
import 'package:ummicare/screens/teacherPages/class/fee/studentPaymentTile.dart';

class studentPaymentList extends StatefulWidget {
  const studentPaymentList({super.key, required this.feePaymentList});
  final List<feePaymentModel>? feePaymentList;

  @override
  State<studentPaymentList> createState() => _studentPaymentListState();
}

class _studentPaymentListState extends State<studentPaymentList> {
  @override
  Widget build(BuildContext context) {
    if (widget.feePaymentList!.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: const Center(
          child: Text(
            'The list is empty.',
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.feePaymentList!.length,
        itemBuilder: ((context, index) {
          return studentPaymentTile(feePaymentId: widget.feePaymentList![index].feePaymentId);
        }),
      );
    }
  }
}