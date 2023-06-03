import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class menteeMain extends StatefulWidget {
  const menteeMain({super.key});

  @override
  State<menteeMain> createState() => _menteeMainState();
}

class _menteeMainState extends State<menteeMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
          TextButton(
            style: TextButton.styleFrom(primary: Colors.blue),
            onPressed: () {
              Navigator.of(context).pushNamed('/advisor/mentee/menteeprofile');
            },
            child: Text('Mentee profile'),
          ),
          TextButton(
            style: TextButton.styleFrom(primary: Colors.blue),
            onPressed: () {
              Navigator.of(context).pushNamed('/advisor/mentee/chattingadvisor');
            },
            child: Text('Advisory chatting page'),
          ),
        ],
      )
    );
  }
}