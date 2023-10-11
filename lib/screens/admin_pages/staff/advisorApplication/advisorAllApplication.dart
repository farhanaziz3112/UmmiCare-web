import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffapplicationmodel.dart';
import 'package:ummicare/screens/admin_pages/staff/advisorApplication/advisorPendingApplication.dart';
import 'package:ummicare/services/staffApplicationDatabaseService.dart';

class advisorAllApplication extends StatefulWidget {
  const advisorAllApplication({super.key});

  @override
  State<advisorAllApplication> createState() => _advisorAllApplicationState();
}

class _advisorAllApplicationState extends State<advisorAllApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Advisor Application",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                OutlinedButton.icon(
                  icon: Icon(
                    Icons.schedule,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      side: BorderSide(color: Colors.black, width: 0.4),
                      backgroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(80),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.fromLTRB(15, 0, 0, 0)),
                  onPressed: () {},
                  label: Row(
                    children: [
                      Text(
                        'Pending Application',
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                      Expanded(child: SizedBox(width: 0.0)),
                      StreamBuilder<List<StaffApplicationModel>>(
                          stream: staffApplicationDatabaseService()
                              .allAdvisorPendingApplications,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                '${snapshot.data!.length}',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          }),
                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        advisorPendingApplication()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                OutlinedButton.icon(
                  icon: Icon(
                    Icons.done,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  style: OutlinedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 255, 255),
                      side: BorderSide(color: Colors.black, width: 0.4),
                      backgroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(80),
                      alignment: Alignment.centerLeft),
                  onPressed: () {},
                  label: Text(
                    'Passed Application',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                OutlinedButton.icon(
                  icon: Icon(
                    Icons.close,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  style: OutlinedButton.styleFrom(
                      primary: Color.fromARGB(255, 255, 255, 255),
                      side: BorderSide(color: Colors.black, width: 0.4),
                      backgroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(80),
                      alignment: Alignment.centerLeft),
                  onPressed: () {},
                  label: Text(
                    'Rejected Application',
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
