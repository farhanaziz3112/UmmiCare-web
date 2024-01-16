import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/screens/adminPages/staffList/staffTile.dart';
import 'package:ummicare/shared/constant.dart';

class staffList extends StatefulWidget {
  const staffList({super.key});

  @override
  State<staffList> createState() => _staffListState();
}

class _staffListState extends State<staffList> {
  @override
  Widget build(BuildContext context) {
    final staffList = Provider.of<List<staffUserModel>>(context);

    if (staffList.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: Center(
          child: noData('Oops! Nothing here...')
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: staffList.length,
        itemBuilder: ((context, index) {
          return staffTile(
            staffDetail: staffList[index],
          );
        }),
      );
    }
  }
}
