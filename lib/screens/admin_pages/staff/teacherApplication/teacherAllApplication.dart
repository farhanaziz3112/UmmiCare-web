import 'package:flutter/material.dart';

class teacherAllApplication extends StatefulWidget {
  const teacherAllApplication({super.key});

  @override
  State<teacherAllApplication> createState() => _teacherAllApplicationState();
}

class _teacherAllApplicationState extends State<teacherAllApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Teacher Application",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
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