import 'package:flutter/material.dart';
import 'package:ummicare/services/auth.dart';

class userNotVerified extends StatefulWidget {
  const userNotVerified({super.key});

  @override
  State<userNotVerified> createState() => _userNotVerifiedState();
}

class _userNotVerifiedState extends State<userNotVerified> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'User Verification',
          style: TextStyle(
              color: Colors.white, fontSize: 25),
        ),
        elevation: 3,
        iconTheme: const IconThemeData(color: Colors.white),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xfff29180),
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Column(
          children: <Widget>[
            const Text(
              'Oops! Your account is not verified. Please contact the administrator.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff71cbca),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: const Text(
                'Exit',
                style: TextStyle(
                  color: Colors.white
                ),),
              onPressed: () async {
                _auth.signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
