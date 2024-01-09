import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/services/parentDatabase.dart';

class parentTile extends StatefulWidget {
  const parentTile({super.key, required this.parentDetail});
  final parentModel parentDetail;

  @override
  State<parentTile> createState() => _parentTileState();
}

class _parentTileState extends State<parentTile> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    if (screenSize.width < 1600) {
      return StreamBuilder<parentModel>(
        stream:
            parentDatabase(parentId: widget.parentDetail.parentId).parentData,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            parentModel? parent = snapshot.data;
            return InkWell(
              onTap: () {
                var id = parent.parentId;
                context.go('/advisor/parent/${id}');
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: const Color(0xff8290F0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            parent!.parentEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            parent.parentFirstName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            parent.parentLastName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Container();
          }
        }),
      );
    } else {
      return StreamBuilder<parentModel>(
        stream:
            parentDatabase(parentId: widget.parentDetail.parentId).parentData,
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            parentModel? parent = snapshot.data;
            return InkWell(
              onTap: () {
                var id = parent.parentId;
                context.go('/advisor/parent/${id}');
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: const Color(0xff8290F0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            parent!.parentEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            parent.parentFirstName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            parent.parentLastName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            parent.parentId,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.center,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            parent.noOfChild,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
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
}
