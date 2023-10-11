import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffapplicationmodel.dart';
import 'package:ummicare/screens/admin_pages/staff/applicationList/applicationTile.dart';

class applicationList extends StatefulWidget {
  const applicationList({super.key});

  @override
  State<applicationList> createState() => _applicationListState();
}

class _applicationListState extends State<applicationList> {
  @override
  Widget build(BuildContext context) {
    final applicationList = Provider.of<List<StaffApplicationModel>>(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: applicationList.length,
      itemBuilder: ((context, index) {
        return applicationTile(
          applicationDetail: applicationList[index],
          colorIndex: (index % 3),
        );
      }),
    );
  }
}
