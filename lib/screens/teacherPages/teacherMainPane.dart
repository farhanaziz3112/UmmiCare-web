import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/teacherPages/class/classMain.dart';
import 'package:ummicare/screens/teacherPages/home/teacherDashboard.dart';
import 'package:ummicare/screens/teacherPages/settings/teacherSettingsMain.dart';
import 'package:ummicare/screens/teacherPages/student/studentMain.dart';
import 'package:ummicare/services/teacherDatabase.dart';

class teacherMainPane extends StatefulWidget {
  const teacherMainPane({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<teacherMainPane> createState() => _teacherMainPaneState();
}

class _teacherMainPaneState extends State<teacherMainPane> {

  final pages = [
    const teacherDashboard(),
    const classMain(),
    const studentMain(),
    const teacherSettingsMain()
  ];


  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel>(context);
    return StreamProvider<teacherModel?>.value(
      value: teacherDatabase(teacherId: user.userId).teacherData,
      initialData: null,
      catchError: (_, __) {
        return null;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
        child: pages[widget.currentPage],
        alignment: Alignment.topLeft,
      ),
    );
  }
}