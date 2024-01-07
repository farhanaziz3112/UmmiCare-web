import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class adminVersion extends StatefulWidget {
  const adminVersion({super.key});

  @override
  State<adminVersion> createState() => _adminVersionState();
}

class _adminVersionState extends State<adminVersion> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        child: Column(children: <Widget>[
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                    text: 'Settings',
                    style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        context.go('/admin/settings');
                      }),
              ),
              const SizedBox(width: 10),
              const Text('>'),
              const SizedBox(width: 10),
              RichText(
                text: const TextSpan(
                  text: 'Version',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Version',
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
              'You can see all the system\'s version.',
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
          Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(),
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
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Version 1.0.0',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            'The first version of the app is out! Our first launch comes with web application (Staff User) and mobile application (Parent User). Multiple modules such as Health module and Education module will be available.')
                      ],
                    ),
                  )),
              Expanded(flex: 1, child: Container())
            ],
          )
        ]));
  }
}
