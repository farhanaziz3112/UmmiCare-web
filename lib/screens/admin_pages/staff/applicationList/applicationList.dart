import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/screens/admin_pages/staff/applicationList/applicationTile.dart';

class applicationList extends StatefulWidget {
  const applicationList({super.key});

  @override
  State<applicationList> createState() => _applicationListState();
}

class _applicationListState extends State<applicationList> {
  @override
  Widget build(BuildContext context) {
    final staffList = Provider.of<List<staffUserModel>>(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: staffList.length,
      itemBuilder: ((context, index) {
        return applicationTile(
          staffDetail: staffList[index],
          colorIndex: (index % 3),
        );
      }),
    );
  }
}
