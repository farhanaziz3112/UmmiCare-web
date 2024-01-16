import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_network/image_network.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/services/childDatabase.dart';

class childTile extends StatefulWidget {
  const childTile(
      {super.key, required this.childDetail, required this.childColorIndex});
  final childModel childDetail;
  final int childColorIndex;

  @override
  State<childTile> createState() => _childTileState();
}

class _childTileState extends State<childTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<childModel>(
      stream: childDatabase(childId: widget.childDetail.childId).childData,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          childModel? child = snapshot.data;
          return InkWell(
            onTap: () {
              var parentId = child.parentId;
              var childId = child.childId;
              context.go('/advisor/parent/${parentId}/${childId}');
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: BoxDecoration(
                  color: widget.childColorIndex == 0
                      ? const Color(0xffF29180)
                      : widget.childColorIndex == 1
                          ? const Color(0xff71CBCA)
                          : const Color(0xff8290F0),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ImageNetwork(
                        image: child!.childProfileImg,
                        height: 100,
                        width: 100,
                        borderRadius: BorderRadius.circular(70)),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(child.childName, style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17
                        ),),
                        Text(child.childFirstname, style: const TextStyle(
                          fontSize: 15
                        ),)
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
