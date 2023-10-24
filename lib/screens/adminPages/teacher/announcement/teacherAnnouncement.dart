import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class teacherAnnouncement extends StatefulWidget {
  const teacherAnnouncement({super.key});

  @override
  State<teacherAnnouncement> createState() => _teacherAnnouncementState();
}

class _teacherAnnouncementState extends State<teacherAnnouncement> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  text: 'Announcement',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Announcement',
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
              'Announcement to publish to all teacher user.',
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