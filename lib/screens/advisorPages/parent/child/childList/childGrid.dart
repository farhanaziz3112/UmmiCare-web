import 'package:flutter/material.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/screens/advisorPages/parent/child/childList/childTile.dart';
import 'package:ummicare/services/parentDatabase.dart';

class childGrid extends StatefulWidget {
  const childGrid({super.key, required this.parentId});
  final String parentId;

  @override
  State<childGrid> createState() => _childGridState();
}

class _childGridState extends State<childGrid> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return StreamBuilder<List<childModel>>(
      stream: parentDatabase(parentId: widget.parentId).allChildData,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          List<childModel>? children = snapshot.data;
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1400 <= screenSize.width &&
                        screenSize.width < 1700
                    ? 3
                    : 1300 <= screenSize.width && screenSize.width < 1400
                        ? 2
                        : 1000 <= screenSize.width && screenSize.width < 1300
                            ? 3
                            : screenSize.width < 1000
                                ? 2
                                : 4,
                childAspectRatio: (1400 <= screenSize.width &&
                        screenSize.width < 1700
                    ? 0.7
                    : 1300 <= screenSize.width && screenSize.width < 1400
                        ? 1
                        : 1000 <= screenSize.width && screenSize.width < 1300
                            ? 0.6
                            : screenSize.width < 1000
                                ? 0.8
                                : 0.7)),
            itemCount: children!.length,
            itemBuilder: ((context, index) {
              return childTile(
                childDetail: children[index],
                childColorIndex: (index % 3),
              );
            }),
          );
        } else {
          return Container(
            padding: const EdgeInsets.only(top: 50),
            child: const Center(
              child: Text(
                'The list is empty.',
              ),
            ),
          );
        }
      }),
    );
  }
}
