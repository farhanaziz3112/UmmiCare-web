import 'package:flutter/material.dart';

class medicalStaffAllApplication extends StatefulWidget {
  const medicalStaffAllApplication({super.key});

  @override
  State<medicalStaffAllApplication> createState() => _medicalStaffAllApplicationState();
}

class _medicalStaffAllApplicationState extends State<medicalStaffAllApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Medical Staff Application",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
            child: Column(
              children: <Widget> [
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}