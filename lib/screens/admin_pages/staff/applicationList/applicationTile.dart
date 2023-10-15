import 'package:flutter/material.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/screens/admin_pages/staff/applicationPage/passedApplicationPage.dart';
import 'package:ummicare/screens/admin_pages/staff/applicationPage/pendingApplicationPage.dart';
import 'package:ummicare/screens/admin_pages/staff/applicationPage/rejectedApplicationPage.dart';
import 'package:ummicare/services/adminDatabase.dart';

class applicationTile extends StatefulWidget {
  const applicationTile(
      {super.key, required this.staffDetail, required this.colorIndex});

  final staffUserModel staffDetail;
  final int colorIndex;

  @override
  State<applicationTile> createState() => _applicationTileState();
}

class _applicationTileState extends State<applicationTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<staffUserModel>(
      stream: adminDatabase().staffData(widget.staffDetail.staffId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          staffUserModel? staffData = snapshot.data;
          if (staffData!.isVerified == 'false') {
            if (widget.colorIndex == 0) {
              return InkWell(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => pendingApplicationPage(
                              staffId: staffData.staffId)));
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    color: const Color(0xff71CBCA),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staffData.staffEmail,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            staffData.staffFullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 13),
                          )
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              );
            } else if (widget.colorIndex == 1) {
              return InkWell(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => pendingApplicationPage(
                                staffId: staffData.staffId,
                              )));
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    color: const Color(0xffF29180),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staffData.staffEmail,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            staffData.staffFullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 13),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              );
            } else {
              return InkWell(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => pendingApplicationPage(
                                staffId: staffData.staffId,
                              )));
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    color: const Color(0xff8290F0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staffData.staffEmail,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            staffData.staffFullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 13),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              );
            }
          } else if (staffData.isVerified == 'rejected') {
            if (widget.colorIndex == 0) {
              return InkWell(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => rejectedApplicationPage(
                              staffId: staffData.staffId)));
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    color: const Color(0xff71CBCA),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staffData.staffEmail,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            staffData.staffFullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 13),
                          )
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              );
            } else if (widget.colorIndex == 1) {
              return InkWell(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => rejectedApplicationPage(
                                staffId: staffData.staffId,
                              )));
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    color: const Color(0xffF29180),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staffData.staffEmail,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            staffData.staffFullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 13),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              );
            } else {
              return InkWell(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => rejectedApplicationPage(
                                staffId: staffData.staffId,
                              )));
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    color: const Color(0xff8290F0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staffData.staffEmail,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            staffData.staffFullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 13),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              );
            }
          } else if (staffData.isVerified == 'true') {
            if (widget.colorIndex == 0) {
              return InkWell(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => passedApplicationPage(
                              staffId: staffData.staffId)));
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    color: const Color(0xff71CBCA),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staffData.staffEmail,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            staffData.staffFullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 13),
                          )
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              );
            } else if (widget.colorIndex == 1) {
              return InkWell(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => passedApplicationPage(
                                staffId: staffData.staffId,
                              )));
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    color: const Color(0xffF29180),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staffData.staffEmail,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            staffData.staffFullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 13),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              );
            } else {
              return InkWell(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => passedApplicationPage(
                                staffId: staffData.staffId,
                              )));
                }),
                child: Padding(
                  padding: const EdgeInsets.only(top: 3.0),
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    color: const Color(0xff8290F0),
                    child: ListTile(
                      contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            staffData.staffEmail,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            staffData.staffFullName,
                            style: const TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 13),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward),
                    ),
                  ),
                ),
              );
            }
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      }),
    );

    // if (widget.colorIndex == 0) {
    //   return InkWell(
    //     onTap: (() {

    //     }),
    //     child: Padding(
    //       padding: const EdgeInsets.only(top: 3.0),
    //       child: Card(
    //         margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
    //         color: Color(0xff71CBCA),
    //         child: ListTile(
    //           contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    //           title: Text(application.email),
    //           trailing: Icon(Icons.arrow_forward),
    //         ),
    //       ),
    //     ),
    //   );
    // } else if (widget.colorIndex == 1) {
    //   return InkWell(
    //     onTap: (() {

    //     }),
    //     child: Padding(
    //       padding: const EdgeInsets.only(top: 3.0),
    //       child: Card(
    //         margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
    //         color: Color(0xffF29180),
    //         child: ListTile(
    //           contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    //           title: Text(application.email),
    //           trailing: Icon(Icons.arrow_forward),
    //         ),
    //       ),
    //     ),
    //   );
    // } else if (widget.colorIndex == 2) {
    //   return InkWell(
    //     onTap: (() {

    //     }),
    //     child: Padding(
    //       padding: const EdgeInsets.only(top: 3.0),
    //       child: Card(
    //         margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
    //         color: Color(0xff8290F0),
    //         child: ListTile(
    //           contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    //           title: Text(application.email),
    //           trailing: Icon(Icons.arrow_forward),
    //         ),
    //       ),
    //     ),
    //   );
    // } else {
    //   return Container();
    // }
  }
}
