import 'package:flutter/material.dart';
import 'package:ummicare/screens/advisorPages/advisorHomeProfile.dart';
import 'package:ummicare/screens/advisorPages/advisorMenu.dart';
import 'package:ummicare/screens/nav/mainNavItem.dart';

class advisorLeftPane extends StatelessWidget {
  const advisorLeftPane({super.key, required this.selected});
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
              SizedBox(height: 50),
              advisorMenu(selected: selected),
              Expanded(child: Container()),
              advisorHomeProfile(),
              SizedBox(height: 50)
            ],
          ),
        ),
      ],
    );
  }
}