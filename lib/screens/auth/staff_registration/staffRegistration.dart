import 'package:flutter/material.dart';
import 'package:ummicare/screens/auth/staff_registration/advisorRegistration.dart';
import 'package:ummicare/screens/auth/staff_registration/medicalStaffRegistration.dart';
import 'package:ummicare/screens/auth/staff_registration/teacherRegistration.dart';

class staffRegistration extends StatefulWidget {
  const staffRegistration({super.key});

  @override
  State<staffRegistration> createState() => _staffRegistrationState();
}

class _staffRegistrationState extends State<staffRegistration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Staff Registration",
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: const Color(0xfff29180),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 700.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20.0,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Choose your registration',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff71cbca),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  minimumSize: const Size.fromHeight(30.0)),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
                child: const Column(
                  children: <Widget>[
                    Icon(
                      Icons.support_agent,
                      size: 50.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Advisor',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const advisorRegistration()));
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff71cbca),
                minimumSize: const Size.fromHeight(30.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
                child: const Column(
                  children: <Widget>[
                    Icon(
                      Icons.school,
                      size: 50.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Teacher',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const teacherRegistration()));
              },
            ),
            const SizedBox(
              height: 15.0,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff71cbca),
                minimumSize: const Size.fromHeight(30.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 0),
                child: const Column(
                  children: <Widget>[
                    Icon(
                      Icons.health_and_safety,
                      size: 50.0,
                      color: Colors.white,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Medical Staff',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w200),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const medicalStaffRegistration()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
