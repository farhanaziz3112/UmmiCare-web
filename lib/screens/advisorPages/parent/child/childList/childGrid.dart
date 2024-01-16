import 'package:flutter/material.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/screens/advisorPages/parent/child/childList/childTile.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class childGrid extends StatefulWidget {
  const childGrid({super.key, required this.parentId});
  final String parentId;

  @override
  State<childGrid> createState() => _childGridState();
}

class _childGridState extends State<childGrid> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<childModel>>(
      stream: parentDatabase(parentId: widget.parentId).allChildData,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<childModel>? children = snapshot.data;
          if (children!.isEmpty) {
            return Container(
              padding: const EdgeInsets.only(top: 50),
              child: Center(
                  child: noData('Oops! There is no children at the moment...')),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: children.length,
              itemBuilder: ((context, index) {
                return childTile(
                    childDetail: children[index], childColorIndex: (index % 3));
              }),
            );
          }
        } else {
          return Container(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
                child: noData('Oops! There is no children at the moment...')),
          );
        }
      }),
    );
  }
}
