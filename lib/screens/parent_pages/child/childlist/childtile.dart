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
                padding: const EdgeInsets.only(top: 3.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: Color(0xff71CBCA),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(child!.childProfileImg),
                    ),
                    title: Text(child.childName),
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
                padding: const EdgeInsets.only(top: 3.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: Color(0xffF29180),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    leading: CircleAvatar(
                      radius: 25.0,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(child!.childProfileImg),
                    ),
                    title: Text(child.childName),
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
                padding: const EdgeInsets.only(top: 3.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: Color(0xff8290F0),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    title: Text(child!.childName),
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
