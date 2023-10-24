import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/screens/adminPages/staffList/staffList.dart';
import 'package:ummicare/services/adminDatabase.dart';

class rejectedTeacher extends StatefulWidget {
  const rejectedTeacher({super.key});

  @override
  State<rejectedTeacher> createState() => _rejectedTeacherState();
}

class _rejectedTeacherState extends State<rejectedTeacher> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<staffUserModel>>.value(
      initialData: [],
      value: adminDatabase().allStaffData('rejected', 'teacher'),
      child: Container(
          alignment: Alignment.topLeft,
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      text: 'Teacher',
                      style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go('/admin/teacher');
                        }),
                ),
                const SizedBox(width: 10),
                const Text('>'),
                const SizedBox(width: 10),
                RichText(
                  text: const TextSpan(
                    text: 'Rejected Teacher',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Rejected Teacher',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'All the teacher application that has been rejected by the administrator.',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: const Text(
                      'Email',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: const Text(
                      'First Name',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: const Text(
                      'Last Name',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: const Text(
                      'User Id',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: const Text(
                      'Status',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: const staffList(),
            )
          ])),
    );
  }
}