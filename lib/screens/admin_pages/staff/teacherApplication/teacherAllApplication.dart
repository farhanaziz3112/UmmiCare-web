import 'package:flutter/material.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/screens/admin_pages/staff/teacherApplication/teacherPassedApplication.dart';
import 'package:ummicare/screens/admin_pages/staff/teacherApplication/teacherPendingApplication.dart';
import 'package:ummicare/screens/admin_pages/staff/teacherApplication/teacherRejectedApplication.dart';
import 'package:ummicare/services/adminDatabase.dart';

class teacherAllApplication extends StatefulWidget {
  const teacherAllApplication({super.key});

  @override
  State<teacherAllApplication> createState() => _teacherAllApplicationState();
}

class _teacherAllApplicationState extends State<teacherAllApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Teacher Application",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 3,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                              adminDatabase().allStaffData('false', 'teacher'),
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
                                        const teacherPendingApplication()));
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
                              .allStaffData('rejected', 'teacher'),
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
                                        const teacherRejectedApplication()));
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
                              adminDatabase().allStaffData('true', 'teacher'),
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
                                        const teacherPassedApplication()));
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