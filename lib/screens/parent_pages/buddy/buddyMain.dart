import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class buddyMain extends StatefulWidget {
  const buddyMain({super.key});

  @override
  State<buddyMain> createState() => _buddyMainState();
}

class _buddyMainState extends State<buddyMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Buddy main page",
          style: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}