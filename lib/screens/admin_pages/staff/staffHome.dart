import 'package:flutter/src/widgets/framework.dart';
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
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: <Widget>[
            const Text(
              'Staff Application',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 15.0,
            ),
            OutlinedButton.icon(
              icon: const Icon(
                Icons.support_agent,
                size: 30.0,
                color: Colors.black,
              ),
              style: OutlinedButton.styleFrom(
                  primary: const Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: const Color(0xff71CBCA),
                  minimumSize: const Size.fromHeight(80),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const advisorAllApplication())));
              },
              label: const Text(
                'Advisor',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            OutlinedButton.icon(
              icon: const Icon(
                Icons.school,
                size: 30.0,
                color: Colors.black,
              ),
              style: OutlinedButton.styleFrom(
                  primary: const Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: const Color(0xff8290F0),
                  minimumSize: const Size.fromHeight(80),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const teacherAllApplication())));
              },
              label: const Text(
                'Teacher',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            OutlinedButton.icon(
              icon: const Icon(
                Icons.health_and_safety,
                size: 30.0,
                color: Colors.black,
              ),
              style: OutlinedButton.styleFrom(
                  primary: const Color.fromARGB(255, 255, 255, 255),
                  backgroundColor: const Color(0xffF29180),
                  minimumSize: const Size.fromHeight(80),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const medicalStaffAllApplication())));
              },
              label: const Text(
                'Medical Staff',
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
          ],
        ));
  }
}
