import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/screens/adminPages/teacher/school/schoolList.dart';
import 'package:ummicare/services/schoolDatabase.dart';

class schoolMain extends StatefulWidget {
  const schoolMain({super.key});

  @override
  State<schoolMain> createState() => _schoolMainState();
}

class _schoolMainState extends State<schoolMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                        text: 'School',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'School Management',
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
                    'Register and manage school data.',
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
                  alignment: Alignment.topLeft,
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.add_circle,
                      size: 24.0,
                      color: Colors.white,
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: const Color(0xffF29180),
                      fixedSize: const Size(250, 50),
                      alignment: Alignment.center,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide.none),
                    ),
                    onPressed: () {
                      context.go('/admin/teacher/school/addschool');
                    },
                    label: const Text(
                      'Add New School',
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  //padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
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
                            'Name',
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
                            'Address',
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
                            'Contact Number',
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
                            'School ID',
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                StreamProvider<List<schoolModel>>.value(
                  initialData: [],
                  value: schoolDatabase().allSchoolData,
                  child: schoolList(),
                )
              ]),
        ));
  }
}
