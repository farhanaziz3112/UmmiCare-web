import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/screens/adminPages/teacher/school/schoolTile.dart';
import 'package:ummicare/shared/constant.dart';

class schoolList extends StatefulWidget {
  const schoolList({super.key});

  @override
  State<schoolList> createState() => _schoolListState();
}

class _schoolListState extends State<schoolList> {
  @override
  Widget build(BuildContext context) {
    final schoolList = Provider.of<List<schoolModel>>(context);

    if (schoolList.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: Center(child: noData('Oops! Nothing here...')),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: schoolList.length,
        itemBuilder: ((context, index) {
          return schoolTile(schoolDetail: schoolList[index]);
        }),
      );
    }
  }
}
