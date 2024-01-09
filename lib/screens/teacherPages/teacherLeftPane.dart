import 'package:flutter/material.dart';
import 'package:ummicare/screens/nav/mainNavItem.dart';
import 'package:ummicare/screens/teacherPages/teacherHomeProfile.dart';
import 'package:ummicare/screens/teacherPages/teacherMenu.dart';

class teacherLeftPane extends StatelessWidget {
  const teacherLeftPane({super.key, required this.selected});
  final int selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: const Text(
                  'UmmiCare',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40.0,
                      fontFamily: 'Comfortaa',
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 50),
              teacherMenu(selected: selected),
              Expanded(child: Container()),
              const teacherHomeProfile(),
              const SizedBox(height: 50)
            ],
          ),
        ),
      ],
    );
  }
}