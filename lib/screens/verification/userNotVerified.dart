import 'package:flutter/foundation.dart';
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
        title: Text(
          'User Verification',
          style: TextStyle(
              color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        elevation: 3,
        iconTheme: IconThemeData(color: Colors.black),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Column(
          children: <Widget>[
            Text(
              'Oops! Your account is not verified. Please contact the administrator.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff8290F0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: Text(
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
