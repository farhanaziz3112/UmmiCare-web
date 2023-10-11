import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/screens/admin_pages/staff/advisorApplication/advisorAllApplication.dart';
import 'package:ummicare/screens/admin_pages/staff/medicalStaffApplication/medicalStaffAllApplication.dart';
import 'package:ummicare/screens/admin_pages/staff/teacherApplication/teacherAllApplication.dart';

class advisorMain_admin extends StatefulWidget {
  const advisorMain_admin({super.key});

  @override
  State<advisorMain_admin> createState() => _advisorMain_adminState();
}

class _advisorMain_adminState extends State<advisorMain_admin> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            Text(
              'Staff Application',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black),
            ),
            SizedBox(
              height: 15.0,
            ),
            OutlinedButton.icon(
              icon: Icon(
                Icons.support_agent,
                size: 30.0,
                color: Colors.black,
              ),
              style: OutlinedButton.styleFrom(
                primary: Color.fromARGB(255, 255, 255, 255),
                backgroundColor: Color(0xff71CBCA),
                minimumSize: const Size.fromHeight(80),
                alignment: Alignment.centerLeft,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => advisorAllApplication())));
              },
              label: Text(
                'Advisor',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            OutlinedButton.icon(
              icon: Icon(
                Icons.school,
                size: 30.0,
                color: Colors.black,
              ),
              style: OutlinedButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: Color(0xff8290F0),
                  minimumSize: const Size.fromHeight(80),
                  alignment: Alignment.centerLeft),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => teacherAllApplication())));
              },
              label: Text(
                'Teacher',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            OutlinedButton.icon(
              icon: Icon(
                Icons.health_and_safety,
                size: 30.0,
                color: Colors.black,
              ),
              style: OutlinedButton.styleFrom(
                  primary: Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: Color(0xffF29180),
                  minimumSize: const Size.fromHeight(80),
                  alignment: Alignment.centerLeft),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => medicalStaffAllApplication())));
              },
              label: Text(
                'Medical Staff',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
          ],
        ));
  }
}
