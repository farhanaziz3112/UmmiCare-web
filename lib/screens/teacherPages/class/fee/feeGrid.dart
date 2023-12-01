import 'package:flutter/material.dart';
import 'package:ummicare/models/feeModel.dart';
import 'package:ummicare/screens/teacherPages/class/fee/feeTile.dart';

class feeGrid extends StatefulWidget {
  const feeGrid({super.key, required this.feeList});
  final List<feeModel>? feeList;

  @override
  State<feeGrid> createState() => _feeGridState();
}

class _feeGridState extends State<feeGrid> {
  @override
  Widget build(BuildContext context) {
    if (widget.feeList!.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: const Center(
          child: Text(
            'The list is empty.',
          ),
        ),
      );
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, childAspectRatio: (0.6)),
        itemCount: widget.feeList!.length,
        itemBuilder: ((context, index) {
          return feeTile(fee: widget.feeList![index]);
        }),
      );
    }
  }
}
