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
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                            staffData.staffEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                    ],
                  ),
                ),
              );
            } else if (staffData.isVerified == 'rejected') {
              return InkWell(
                onTap: (() {
                  var id = staffData.staffId;
                  context.go('/admin/advisor/rejected/${id}');
                }),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                            staffData.staffEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return InkWell(
                onTap: (() {
                  var id = staffData.staffId;
                  context.go('/admin/advisor/verified/${id}');
                }),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                            staffData.staffEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                    ],
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
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                            staffData.staffEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                    ],
                  ),
                ),
              );
            } else if (staffData.isVerified == 'rejected') {
              return InkWell(
                onTap: (() {
                  var id = staffData.staffId;
                  context.go('/admin/teacher/rejected/${id}');
                }),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                            staffData.staffEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return InkWell(
                onTap: (() {
                  var id = staffData.staffId;
                  context.go('/admin/teacher/verified/${id}');
                }),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                            staffData.staffEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                    ],
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
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                            staffData.staffEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                    ],
                  ),
                ),
              );
            } else if (staffData.isVerified == 'rejected') {
              return InkWell(
                onTap: (() {
                  var id = staffData.staffId;
                  context.go('/admin/medicalstaff/rejected/${id}');
                }),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                            staffData.staffEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return InkWell(
                onTap: (() {
                  var id = staffData.staffId;
                  context.go('/admin/medicalstaff/verified/${id}');
                }),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
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
                        offset:
                            const Offset(0, 3), // changes position of shadow
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
                            staffData.staffEmail,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                      Expanded(flex: 1, child: Container()),
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
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
                      ),
                    ],
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
