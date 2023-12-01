import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/screens/adminPages/teacher/school/class/classTile.dart';

class classList extends StatefulWidget {
  const classList({super.key});

  @override
  State<classList> createState() => _classListState();
}

class _classListState extends State<classList> {
  @override
  Widget build(BuildContext context) {
    final classList = Provider.of<List<classModel>>(context);

    if (classList.isEmpty) {
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
        itemCount: classList.length,
        itemBuilder: ((context, index) {
          return classTile(
            classDetail: classList[index],
          );
        }),
      );
    }
  }
}