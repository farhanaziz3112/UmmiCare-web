import 'package:flutter/material.dart';
import 'package:ummicare/models/examinationModel.dart';
import 'package:ummicare/screens/teacherPages/class/exam/examTile.dart';

class examList extends StatefulWidget {
  const examList({super.key, required this.examModelList});
  final List<examModel>? examModelList;

  @override
  State<examList> createState() => _examListState();
}

class _examListState extends State<examList> {
  @override
  Widget build(BuildContext context) {
    if (widget.examModelList!.isEmpty) {
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
        itemCount: widget.examModelList!.length,
        itemBuilder: ((context, index) {
          return examTile(
              examId: widget.examModelList![index].examId);
        }),
      );
    }
  }
}