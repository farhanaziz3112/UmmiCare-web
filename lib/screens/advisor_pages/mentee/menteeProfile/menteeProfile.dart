import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class menteeProfile extends StatefulWidget {
  const menteeProfile({super.key});

  @override
  State<menteeProfile> createState() => _menteeProfileState();
}

class _menteeProfileState extends State<menteeProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Mentee profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffe1eef5),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(primary: Colors.blue),
            onPressed: () {
              Navigator.of(context).pushNamed('/advisor/mentee/childprogress');
            },
            child: Text('Child progress'),
          ),
        ],
      )
    )
    );
  }
}

