import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ummicare/models/childmodel.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/screens/parent_pages/child/childprofile/childProfile.dart';
import 'package:ummicare/services/database.dart';
import 'package:ummicare/shared/loading.dart';

class childTile extends StatefulWidget {
  const childTile(
      {super.key, required this.childDetail, required this.childColorIndex});
  final ChildModel childDetail;
  final int childColorIndex;

  @override
  State<childTile> createState() => _childTileState();
}

class _childTileState extends State<childTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChildModel>(
      stream: DatabaseService(userId: widget.childDetail.childId).childData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          ChildModel? child = snapshot.data;
          if (widget.childColorIndex == 0) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          childProfile(childId: child.childId)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: Color(0xff71CBCA),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(child!.childProfileImg),
                    ),
                    title: Text(child.childName),
                    subtitle: Text(child.childId),
                  ),
                ),
              ),
            );
          } else if (widget.childColorIndex == 1) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          childProfile(childId: child.childId)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: Color(0xffF29180),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(child!.childProfileImg),
                    ),
                    title: Text(child.childName),
                    subtitle: Text(child.childId),
                  ),
                ),
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          childProfile(childId: child.childId)),
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: Color(0xff8290F0),
                  child: ListTile(
                    title: Text(child!.childName),
                    subtitle: Text(child.childId),
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(child.childProfileImg),
                    ),
                  ),
                ),
              ),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }
}
