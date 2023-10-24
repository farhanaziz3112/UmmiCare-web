import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class adminContactUs extends StatefulWidget {
  const adminContactUs({super.key});

  @override
  State<adminContactUs> createState() => _adminContactUsState();
}

class _adminContactUsState extends State<adminContactUs> {
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
                  text: 'Contact Us',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Contact Us',
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
              'Please contact us if there is any problem regarding the system. Our contact detail can be seen as below.',
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