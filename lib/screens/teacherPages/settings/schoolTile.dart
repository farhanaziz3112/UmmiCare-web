import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';

class schoolTile extends StatefulWidget {
  const schoolTile({super.key, required this.schoolDetail});
  final schoolModel schoolDetail;

  @override
  State<schoolTile> createState() => _schoolTileState();
}

class _schoolTileState extends State<schoolTile> {
  //AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder<schoolModel>(
      stream: schoolDatabase().schoolData(widget.schoolDetail.schoolId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          schoolModel? school = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: InkWell(
              onTap: (() {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      title: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                        child: Row(
                          children: [
                            const Icon(Icons.school),
                            const SizedBox(width: 10),
                            Text(school.schoolName),
                          ],
                        ),
                      ),
                      content: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'School Name',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                school.schoolName,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'School Email',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                school.schoolEmail,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'School Address',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                school.schoolAddress,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'School Contact Number',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                school.schoolPhoneNumber,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'REMINDER: Make sure you choose the right school before proceed to register!',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF29180),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancel",
                              style: TextStyle(color: Colors.white)),
                        ),
                        StreamBuilder<teacherModel>(
                            stream: teacherDatabase(teacherId: user!.userId)
                                .teacherData,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                teacherModel? teacher = snapshot.data;
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff8290F0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            scrollable: true,
                                            title: const Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                  'Registration Confirmation'),
                                            ),
                                            content: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Row(
                                                children: [
                                                  const Text(
                                                      'Are you sure you want to register with '),
                                                  Text(
                                                    '${school.schoolName}?',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xffF29180),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text("Cancel",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color(0xff8290F0),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                ),
                                                onPressed: () {
                                                  teacherDatabase(
                                                          teacherId: teacher!
                                                              .teacherId)
                                                      .updateTeacherData(
                                                          teacher.teacherId,
                                                          teacher
                                                              .teacherCreatedDate,
                                                          teacher
                                                              .teacherFullName,
                                                          teacher
                                                              .teacherFirstName,
                                                          teacher
                                                              .teacherLastName,
                                                          teacher.teacherEmail,
                                                          teacher
                                                              .teacherPhoneNumber,
                                                          teacher
                                                              .teacherProfileImg,
                                                          school.schoolId);
                                                  context.go(
                                                      '/teacher/settings/schoolregistration');
                                                },
                                                child: const Text("Confirm",
                                                    style: TextStyle(
                                                        color: Colors.white)),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                  child: const Text("Register",
                                      style: TextStyle(color: Colors.white)),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ],
                    );
                  },
                );
              }),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
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
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
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
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
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
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
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
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
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
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
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
