import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/services/adminDatabase.dart';

class staffTile extends StatefulWidget {
  const staffTile({super.key, required this.staffDetail});
  final staffUserModel staffDetail;

  @override
  State<staffTile> createState() => _staffTileState();
}

class _staffTileState extends State<staffTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<staffUserModel>(
      stream: adminDatabase().staffData(widget.staffDetail.staffId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          staffUserModel? staffData = snapshot.data;
          if (staffData!.staffUserType == 'advisor') {
            if (staffData.isVerified == 'false') {
              return InkWell(
                onTap: (() {
                  var id = staffData.staffId;
                  context.go('/admin/advisor/pending/${id}');
                }),
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
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffEmail,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffFirstName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffLastName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffId,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Pending',
                              style: TextStyle(
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
            } else if (staffData.isVerified == 'rejected') {
              return InkWell(
                onTap: (() {
                  var id = staffData.staffId;
                  context.go('/admin/advisor/rejected/${id}');
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    color: const Color(0xff8290F0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffEmail,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffFirstName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffLastName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffId,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Rejected',
                              style: TextStyle(
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
              return InkWell(
                onTap: (() {
                  var id = staffData.staffId;
                  context.go('/admin/advisor/verified/${id}');
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    color: const Color(0xff8290F0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffEmail,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffFirstName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffLastName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffId,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Verified',
                              style: TextStyle(
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
            }
          } else if (staffData.staffUserType == 'teacher') {
            if (staffData.isVerified == 'false') {
              return InkWell(
                onTap: (() {
                  var id = staffData.staffId;
                  context.go('/admin/teacher/pending/${id}');
                }),
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
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffEmail,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffFirstName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffLastName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffId,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Pending',
                              style: TextStyle(
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
            } else if (staffData.isVerified == 'rejected') {
              return InkWell(
                onTap: (() {
                  var id = staffData.staffId;
                  context.go('/admin/teacher/rejected/${id}');
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    color: const Color(0xff8290F0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffEmail,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffFirstName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffLastName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffId,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Rejected',
                              style: TextStyle(
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
              return InkWell(
                onTap: (() {
                  var id = staffData.staffId;
                  context.go('/admin/teacher/verified/${id}');
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    color: const Color(0xff8290F0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffEmail,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffFirstName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffLastName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: Text(
                              staffData.staffId,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 15),
                            ),
                          ),
                          Expanded(flex: 1, child: Container()),
                          Container(
                            alignment: Alignment.centerLeft,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Verified',
                              style: TextStyle(
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
            }
          } else {
            if (staffData.isVerified == 'false') {
            return InkWell(
              onTap: (() {
                var id = staffData.staffId;
                context.go('/admin/medicalstaff/pending/${id}');
              }),
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
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            staffData.staffEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            staffData.staffFirstName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            staffData.staffLastName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            staffData.staffId,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: const Text(
                            'Pending',
                            style: TextStyle(
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
          } else if (staffData.isVerified == 'rejected') {
            return InkWell(
              onTap: (() {
                var id = staffData.staffId;
                context.go('/admin/medicalstaff/rejected/${id}');
              }),
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: const Color(0xff8290F0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            staffData.staffEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            staffData.staffFirstName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            staffData.staffLastName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            staffData.staffId,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: const Text(
                            'Rejected',
                            style: TextStyle(
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
            return InkWell(
              onTap: (() {
                var id = staffData.staffId;
                context.go('/admin/medicalstaff/verified/${id}');
              }),
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Card(
                  margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: const Color(0xff8290F0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            staffData.staffEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            staffData.staffFirstName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            staffData.staffLastName,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: Text(
                            staffData.staffId,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Container(
                          alignment: Alignment.centerLeft,
                          constraints: const BoxConstraints(
                              minWidth: 100, maxWidth: 200),
                          child: const Text(
                            'Verified',
                            style: TextStyle(
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
          }
          }
        } else {
          return Container();
        }
      }),
    );
  }
}
