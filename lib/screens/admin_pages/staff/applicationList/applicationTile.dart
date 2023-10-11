import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffapplicationmodel.dart';
import 'package:ummicare/screens/admin_pages/staff/pendingApplicationPage.dart';
import 'package:ummicare/services/staffApplicationDatabaseService.dart';
import 'package:ummicare/shared/function.dart';

class applicationTile extends StatefulWidget {
  const applicationTile(
      {super.key, required this.applicationDetail, required this.colorIndex});

  final StaffApplicationModel applicationDetail;
  final int colorIndex;

  @override
  State<applicationTile> createState() => _applicationTileState();
}

class _applicationTileState extends State<applicationTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StaffApplicationModel>(
      stream: staffApplicationDatabaseService()
          .advisorPendingApplication(widget.applicationDetail.applicationId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          StaffApplicationModel? application = snapshot.data;
          if (widget.colorIndex == 0) {
            return InkWell(
              onTap: (() {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => applicationPage(applicationId: application.applicationId)
                  )
                );
              }),
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: Color(0xff71CBCA),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.fromLTRB(25, 10, 10, 10),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${application?.email}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "${application?.fullName}",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Submitted on " + convertTimeToDate(application!.submissionDate),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[900],
                            fontStyle: FontStyle.italic
                          ),
                        )
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            );
          } else if (widget.colorIndex == 1) {
            return InkWell(
              onTap: (() {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => applicationPage(applicationId: application.applicationId)
                  )
                );
              }),
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: Color(0xffF29180),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.fromLTRB(25, 10, 10, 10),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${application?.email}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "${application?.fullName}",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Submitted on " + convertTimeToDate(application!.submissionDate),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[900],
                            fontStyle: FontStyle.italic
                          ),
                        )
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            );
          } else {
            return InkWell(
              onTap: (() {
                Navigator.push(
                  context, MaterialPageRoute(
                    builder: (context) => applicationPage(applicationId: application.applicationId)
                  )
                );
              }),
              child: Padding(
                padding: const EdgeInsets.only(top: 3.0),
                child: Card(
                  margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  color: Color(0xff8290F0),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.fromLTRB(25, 10, 10, 10),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${application?.email}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          "${application?.fullName}",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Submitted on " + convertTimeToDate(application!.submissionDate),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey[900],
                            fontStyle: FontStyle.italic
                          ),
                        )
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
              ),
            );
          }
        } else {
          return Container();
        }
      } ),
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
