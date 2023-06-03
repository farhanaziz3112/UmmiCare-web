import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class educationMain extends StatefulWidget {
  const educationMain({super.key});

  @override
  State<educationMain> createState() => _educationMainState();
}

class _educationMainState extends State<educationMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Education",
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
                Navigator.of(context).pushNamed('/parent/child/childprofile/education/academiccalendar');
              },
              child: Text('Academic calendar'),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                Navigator.of(context).pushNamed('/parent/child/childprofile/education/addnewexamresult');
              },
              child: Text('Add new exam result'),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                Navigator.of(context).pushNamed('/parent/child/childprofile/education/addnewschoolfee');
              },
              child: Text('Add new fee'),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                Navigator.of(context).pushNamed('/parent/child/childprofile/education/editchildeducation');
              },
              child: Text('Edit child education'),
            ),
          ],
        ),
      ),
    );
  }
}