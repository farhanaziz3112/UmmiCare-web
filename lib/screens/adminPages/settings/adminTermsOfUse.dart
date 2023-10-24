import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class adminTermsOfUse extends StatefulWidget {
  const adminTermsOfUse({super.key});

  @override
  State<adminTermsOfUse> createState() => _adminTermsOfUseState();
}

class _adminTermsOfUseState extends State<adminTermsOfUse> {
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
                  text: 'Terms of Use',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Terms of Use',
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
              'You can see the system\'s terms of use here.',
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
        ]));
  }
}