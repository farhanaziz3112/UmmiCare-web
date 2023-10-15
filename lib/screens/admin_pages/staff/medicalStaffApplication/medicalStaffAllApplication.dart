import 'package:flutter/material.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/screens/admin_pages/staff/medicalStaffApplication/medicalStaffPassedApplication.dart';
import 'package:ummicare/screens/admin_pages/staff/medicalStaffApplication/medicalStaffPendingApplication.dart';
import 'package:ummicare/screens/admin_pages/staff/medicalStaffApplication/medicalStaffRejectedApplication.dart';
import 'package:ummicare/services/adminDatabase.dart';

class medicalStaffAllApplication extends StatefulWidget {
  const medicalStaffAllApplication({super.key});

  @override
  State<medicalStaffAllApplication> createState() =>
      _medicalStaffAllApplicationState();
}

class _medicalStaffAllApplicationState
    extends State<medicalStaffAllApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Medical Staff Application",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 3,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 15.0,
                ),
                OutlinedButton.icon(
                  icon: const Icon(
                    Icons.schedule,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  style: OutlinedButton.styleFrom(
                      primary: Colors.black,
                      side: const BorderSide(color: Colors.black, width: 0.4),
                      backgroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(80),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () {},
                  label: Row(
                    children: [
                      const Text(
                        'Pending Application',
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                      const Expanded(child: SizedBox(width: 0.0)),
                      StreamBuilder<List<staffUserModel>>(
                          stream:
                              adminDatabase().allStaffData('false', 'medicalStaff'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                '${snapshot.data!.length}',
                                style: TextStyle(
                                    color: Colors.yellow[800],
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const medicalStaffPendingApplication()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                OutlinedButton.icon(
                  icon: const Icon(
                    Icons.done,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      side: const BorderSide(color: Colors.black, width: 0.4),
                      backgroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(80),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () {},
                  label: Row(
                    children: [
                      const Text(
                        'Rejected Application',
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                      const Expanded(child: SizedBox(width: 0.0)),
                      StreamBuilder<List<staffUserModel>>(
                          stream: adminDatabase()
                              .allStaffData('rejected', 'medicalStaff'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                '${snapshot.data!.length}',
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const medicalStaffRejectedApplication()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                OutlinedButton.icon(
                  icon: const Icon(
                    Icons.close,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  style: OutlinedButton.styleFrom(
                      primary: const Color.fromARGB(255, 255, 255, 255),
                      side: const BorderSide(color: Colors.black, width: 0.4),
                      backgroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(80),
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  onPressed: () {},
                  label: Row(
                    children: [
                      const Text(
                        'Passed Application',
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                      const Expanded(child: SizedBox(width: 0.0)),
                      StreamBuilder<List<staffUserModel>>(
                          stream:
                              adminDatabase().allStaffData('true', 'medicalStaff'),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                '${snapshot.data!.length}',
                                style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              );
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                      Container(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_forward,
                            size: 20,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const medicalStaffPassedApplication()));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
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
