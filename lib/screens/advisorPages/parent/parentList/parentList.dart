import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/screens/advisorPages/parent/parentList/parentTile.dart';
import 'package:ummicare/shared/constant.dart';

class parentList extends StatefulWidget {
  const parentList({super.key});

  @override
  State<parentList> createState() => _parentListState();
}

class _parentListState extends State<parentList> {
  @override
  Widget build(BuildContext context) {
    final parentList = Provider.of<List<parentModel>>(context);

    if (parentList.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: Center(child: noData('Oops! Nothing here...')),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: parentList.length,
        itemBuilder: ((context, index) {
          return parentTile(
            parentDetail: parentList[index],
          );
        }),
      );
    }
  }
}
