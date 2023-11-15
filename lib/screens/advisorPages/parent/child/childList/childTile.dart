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
      stream: childDatabase(
              childId: widget.childDetail.childId)
          .childData,
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          childModel? child = snapshot.data;
          if (widget.childColorIndex == 0) {
            return InkWell(
              onTap: () {
                context.go('/advisor/parent/${child.parentId}/${child.childId}');
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  alignment: Alignment.center,
                  height: double.maxFinite,
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 50),
                  decoration: BoxDecoration(
                    color: const Color(0xffF29180),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ImageNetwork(
                            image: child!.childProfileImg,
                            height: 70,
                            width: 70,
                            borderRadius: BorderRadius.circular(70)),
                        const SizedBox(height: 20),
                        const Text(
                          'Full Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(child.childName),
                        const SizedBox(height: 10),
                        const Text(
                          'First Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(child.childFirstname),
                        const SizedBox(height: 10),
                        const Text(
                          'Last Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(child.childLastname),
                        const SizedBox(height: 10),
                        const Text(
                          'Current Age',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text((child.childCurrentAge).toString()),
                        const SizedBox(height: 10),
                        const Text(
                          'Age Category',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(child.childAgeCategory),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (widget.childColorIndex == 1) {
            return InkWell(
              onTap: () {
                context.go('/advisor/parent/${child.parentId}/${child.childId}');
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 50),
                  decoration: BoxDecoration(
                    color: const Color(0xff71CBCA),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ImageNetwork(
                            image: child!.childProfileImg,
                            height: 70,
                            width: 70,
                            borderRadius: BorderRadius.circular(70)),
                        const SizedBox(height: 20),
                        const Text(
                          'Full Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(child.childName),
                        const SizedBox(height: 10),
                        const Text(
                          'First Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(child.childFirstname),
                        const SizedBox(height: 10),
                        const Text(
                          'Last Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(child.childLastname),
                        const SizedBox(height: 10),
                        const Text(
                          'Current Age',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text((child.childCurrentAge).toString()),
                        const SizedBox(height: 10),
                        const Text(
                          'Age Category',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(child.childAgeCategory),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return InkWell(
              onTap: () {
                context.go('/advisor/parent/${child.parentId}/${child.childId}');
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 50),
                  decoration: BoxDecoration(
                    color: const Color(0xff8290F0),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ImageNetwork(
                            image: child!.childProfileImg,
                            height: 70,
                            width: 70,
                            borderRadius: BorderRadius.circular(70)),
                        const SizedBox(height: 20),
                        const Text(
                          'Full Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(child.childName),
                        const SizedBox(height: 10),
                        const Text(
                          'First Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(child.childFirstname),
                        const SizedBox(height: 10),
                        const Text(
                          'Last Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(child.childLastname),
                        const SizedBox(height: 10),
                        const Text(
                          'Current Age',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text((child.childCurrentAge).toString()),
                        const SizedBox(height: 10),
                        const Text(
                          'Age Category',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(child.childAgeCategory),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        } else {
          return Container();
        }
      }),
    );
  }
}
