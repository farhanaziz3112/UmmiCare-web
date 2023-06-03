import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ummicare/models/childmodel.dart';
import 'package:flutter/material.dart';

class childTile extends StatelessWidget {
  const childTile({super.key, required this.childDetail, required this.childColorIndex});
  final ChildModel childDetail;
  final int childColorIndex;

  @override
  Widget build(BuildContext context) {

    if (childColorIndex == 0) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          color: Color(0xff71CBCA),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.grey[300],
            ),
            title: Text('${childDetail.childFirstname} ${childDetail.childLastname}'),
            subtitle: Text('${childDetail.childId}'),
          ),
        ),
      );
    } else if(childColorIndex == 1) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          color: Color(0xffF29180),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.grey[300],
            ),
            title: Text('${childDetail.childFirstname} ${childDetail.childLastname}'),
            subtitle: Text('${childDetail.childId}'),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
          color: Color(0xff8290F0),
          child: ListTile(
            leading: CircleAvatar(
              radius: 25.0,
              backgroundColor: Colors.grey[300],
            ),
            title: Text('${childDetail.childFirstname} ${childDetail.childLastname}'),
            subtitle: Text('${childDetail.childId}'),
          ),
        ),
      );
    }

  }
}
