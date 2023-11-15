import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/services/parentDatabase.dart';

class parentSettings extends StatefulWidget {
  const parentSettings({super.key, required this.parentId});
  final String parentId;

  @override
  State<parentSettings> createState() => _parentSettingsState();
}

class _parentSettingsState extends State<parentSettings> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<parentModel>(
      stream: parentDatabase(parentId: widget.parentId).parentData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          parentModel? parent = snapshot.data;
          return SingleChildScrollView(
            child: Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            text: 'Parent',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/advisor/parent');
                              }),
                      ),
                      const SizedBox(width: 10),
                      const Text('>'),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          text: parent!.parentFirstName,
                          style: const TextStyle(color: Colors.grey, decoration: TextDecoration.underline),
                          recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/advisor/parent/${parent.parentId}');
                              },
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('>'),
                      const SizedBox(width: 10),
                      RichText(
                        text: const TextSpan(
                          text: 'Settings',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      parent.parentFullName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 45.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      parent.parentEmail,
                      style: const TextStyle(
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
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}