import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/screens/parent_pages/child/childlist/childtile.dart';

import '../../../../models/childmodel.dart';

class childList extends StatefulWidget {
  const childList({super.key});

  @override
  State<childList> createState() => _childListState();
}

class _childListState extends State<childList> {
  @override
  Widget build(BuildContext context) {
    final childDetails = Provider.of<List<ChildModel>>(context);

    return ListView.builder(
      shrinkWrap: true,
      itemCount: childDetails.length,
      itemBuilder: (context, index) {
        return childTile(
          childDetail: childDetails[index],
          childColorIndex: (index % 3),
          childId: childDetails[index].childId,
        );
      },
    );
  }
}

