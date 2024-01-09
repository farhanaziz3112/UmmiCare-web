import 'package:flutter/material.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/screens/teacherPages/student/searchedStudentTile.dart';

class searchedStudentList extends StatefulWidget {
  const searchedStudentList({super.key, required this.childs});
  final List<childModel> childs;

  @override
  State<searchedStudentList> createState() => _searchedStudentListState();
}

class _searchedStudentListState extends State<searchedStudentList> {
  @override
  Widget build(BuildContext context) {
    if (widget.childs!.isEmpty) {
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
        itemCount: widget.childs.length,
        itemBuilder: ((context, index) {
          return searchedStudentTile(
            childId: widget.childs[index].childId
          );
        }),
      );
    }
  }
}