import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/services/schoolDatabase.dart';

class schoolTile extends StatefulWidget {
  const schoolTile({super.key, required this.schoolDetail});
  final schoolModel schoolDetail;

  @override
  State<schoolTile> createState() => _schoolTileState();
}

class _schoolTileState extends State<schoolTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<schoolModel>(
      stream: schoolDatabase().schoolData(widget.schoolDetail.schoolId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          schoolModel? school = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: (() {
                    var id = school.schoolId;
                    context.go('/admin/teacher/school/${id}');
                  }),
              child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      decoration: BoxDecoration(
                        color: const Color(0xff8290F0),
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
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: Text(
                                  school!.schoolName,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: Text(
                                  school.schoolAddress,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: Text(
                                  school.schoolEmail,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: Text(
                                  school.schoolPhoneNumber,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                            Expanded(
                              flex: 2,
                              child: Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints(
                                    minWidth: 100, maxWidth: 200),
                                child: Text(
                                  school.schoolId,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15),
                                ),
                              ),
                            ),
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