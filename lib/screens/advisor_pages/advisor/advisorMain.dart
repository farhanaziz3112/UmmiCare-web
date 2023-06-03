import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class advisorMain extends StatefulWidget {
  const advisorMain({super.key});

  @override
  State<advisorMain> createState() => _advisorMainState();
}

class _advisorMainState extends State<advisorMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Advisor main page",
          style: TextStyle(
            color: Colors.black,
            fontSize: 45,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );;
  }
}