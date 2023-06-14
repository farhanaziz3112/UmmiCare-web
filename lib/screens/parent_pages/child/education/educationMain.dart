import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/models/educationmodel.dart';
import 'package:ummicare/screens/parent_pages/child/education/addNewEduCalendar.dart';
import 'package:ummicare/services/database.dart';

import '../../../../services/eduDatabase.dart';

class educationMain extends StatefulWidget {
  const educationMain({super.key, required this.childId});
  final String childId;

  @override
  State<educationMain> createState() => _educationMainState();
}

class _educationMainState extends State<educationMain> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<EducationModel>>(
      stream: EduDatabaseService(childId: widget.childId).educationData,
      builder: (context, snapshot) {
        final eduData = snapshot.data;
        if (eduData!.isNotEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Education",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Education",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: true,
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
            ),
            body: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff8290F0)),
                child: Text(
                  'Register New Education Module',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context, 
                    MaterialPageRoute(
                      builder: (context) => addNewEduCalendar(childId: widget.childId),) 
                    );
                },
              )
            )
          );
        }
      }
    );
  }
}
