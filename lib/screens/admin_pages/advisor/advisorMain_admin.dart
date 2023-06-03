import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class advisorMain_admin extends StatefulWidget {
  const advisorMain_admin({super.key});

  @override
  State<advisorMain_admin> createState() => _advisorMain_adminState();
}

class _advisorMain_adminState extends State<advisorMain_admin> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(primary: Colors.blue),
            onPressed: () {
              Navigator.of(context).pushNamed('/admin/advisor/advisorprofile');
            },
            child: Text('Advisor profile'),
          ),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.blue),
            onPressed: () {
              Navigator.of(context).pushNamed('/admin/advisor/registeradvisor');
            },
            child: Text('Register new advisor profile'),
          ),
        ],
      )
    );
  }
}