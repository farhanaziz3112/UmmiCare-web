import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class childProfile extends StatefulWidget {
  const childProfile({super.key});

  @override
  State<childProfile> createState() => _childProfileState();
}

class _childProfileState extends State<childProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Child Profile",
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
                Navigator.of(context).pushNamed('/parent/child/childprofile/editchildprofile');
              },
              child: Text('Edit child profile'),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                Navigator.of(context).pushNamed('/parent/child/childprofile/childstory');
              },
              child: Text('Child story'),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                Navigator.of(context).pushNamed('/parent/child/childprofile/addnewchildstory');
              },
              child: Text('Add new child story'),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                Navigator.of(context).pushNamed('/parent/child/childprofile/education');
              },
              child: Text('Education'),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                Navigator.of(context).pushNamed('/parent/child/childprofile/health');
              },
              child: Text('Health'),
            ),
          ],
        ),
      ),
    );
  }
}