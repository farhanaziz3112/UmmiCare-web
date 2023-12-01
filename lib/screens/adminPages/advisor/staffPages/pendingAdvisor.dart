import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/screens/adminPages/staffList/staffList.dart';
import 'package:ummicare/services/adminDatabase.dart';

class pendingAdvisor extends StatefulWidget {
  const pendingAdvisor({super.key});

  @override
  State<pendingAdvisor> createState() => _pendingAdvisorState();
}

class _pendingAdvisorState extends State<pendingAdvisor> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<staffUserModel>>.value(
      initialData: [],
      value: adminDatabase().allStaffData('false', 'advisor'),
      child: Container(
          alignment: Alignment.topLeft,
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      text: 'Advisor',
                      style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go('/admin/advisor');
                        }),
                ),
                const SizedBox(width: 10),
                const Text('>'),
                const SizedBox(width: 10),
                RichText(
                  text: const TextSpan(
                    text: 'Pending Advisor',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Pending Advisor',
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
                'All the pending advisor application that were not verified or rejected yet.',
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
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: const Text(
                        'Email',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: const Text(
                        'First Name',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: const Text(
                        'Last Name',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: const Text(
                        'User Id',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: const Text(
                        'Status',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15),
                      ),
                    ),
                  ),
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
