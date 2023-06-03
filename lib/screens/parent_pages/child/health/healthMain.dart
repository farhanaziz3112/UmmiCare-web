import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class healthMain extends StatefulWidget {
  const healthMain({super.key});

  @override
  State<healthMain> createState() => _healthMainState();
}

class _healthMainState extends State<healthMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Health",
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
                Navigator.of(context).pushNamed('/parent/child/childprofile/health/addnewvaccineappointment');
              },
              child: Text('Add new vaccine appointment'),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                Navigator.of(context).pushNamed('/parent/child/childprofile/health/editchildhealth');
              },
              child: Text('Edit child health'),
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                Navigator.of(context).pushNamed('/parent/child/childprofile/health/vaccinationcalendar');
              },
              child: Text('Vaccination calendar'),
            ),
          ],
        ),
      ),
    );
  }
}