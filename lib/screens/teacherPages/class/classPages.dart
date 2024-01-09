import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/teacherPages/class/classProfile.dart';
import 'package:ummicare/screens/teacherPages/class/exam/examProfile.dart';
import 'package:ummicare/screens/teacherPages/class/exam/examSchedule.dart';
import 'package:ummicare/screens/teacherPages/class/exam/addNewExam.dart';
import 'package:ummicare/screens/teacherPages/class/exam/examMain.dart';
import 'package:ummicare/screens/teacherPages/class/exam/examSubject.dart';
import 'package:ummicare/screens/teacherPages/class/fee/feeMain.dart';
import 'package:ummicare/screens/teacherPages/class/fee/studentFeePayment.dart';
import 'package:ummicare/screens/teacherPages/class/registerNewClass.dart';
import 'package:ummicare/screens/teacherPages/class/attendance/studentAttendance.dart';
import 'package:ummicare/screens/teacherPages/class/student/studentMain.dart';
import 'package:ummicare/screens/teacherPages/class/student/studentProfile.dart';
import 'package:ummicare/screens/teacherPages/teacherLeftPane.dart';
import 'package:ummicare/screens/teacherPages/teacherMainPane.dart';
import 'package:ummicare/screens/teacherPages/teacherMenu.dart';
import 'package:ummicare/services/teacherDatabase.dart';

class classPages extends StatefulWidget {
  const classPages(
      {super.key,
      required this.currentPage,
      required this.academicCalendarId,
      required this.studentId,
      required this.feeId,
      required this.examId,
      required this.subjectId});
  final int currentPage;
  final String academicCalendarId;
  final String studentId;
  final String feeId;
  final String examId;
  final String subjectId;

  @override
  State<classPages> createState() => _classPagesState();
}

class _classPagesState extends State<classPages> {
  bool viewMenu = false;
  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);
    var screenSize = MediaQuery.of(context).size;
    int page = widget.currentPage;

    final pages = [
      registerNewClass(),
      classProfile(
        academicCalendarId: widget.academicCalendarId,
      ),
      studentMain(academicCalendarId: widget.academicCalendarId),
      studentProfile(studentId: widget.studentId),
      studentAttendance(academicCalendarId: widget.academicCalendarId),
      feeMain(academicCalendarId: widget.academicCalendarId),
      studentFeePayment(
          academicCalendarId: widget.academicCalendarId, feeId: widget.feeId),
      examMain(academicCalendarId: widget.academicCalendarId),
      addNewExam(
        academicCalendarId: widget.academicCalendarId,
      ),
      examProfile(
        examId: widget.examId,
        academicCalendarId: widget.academicCalendarId,
      ),
      examSchedule(
        academicCalendarId: widget.academicCalendarId,
        examId: widget.examId,
      ),
      examSubject(
          academicCalendarId: widget.academicCalendarId,
          subjectId: widget.subjectId,
          examId: widget.examId)
    ];

    if (screenSize.width < 1300) {
      return Scaffold(
          appBar: AppBar(
            title: const Text(
              "UmmiCare",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: false,
            backgroundColor: const Color(0xff71CBCA),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30.0,
                ),
                onPressed: () {
                  setState(() {
                    viewMenu = !viewMenu;
                  });
                },
              ),
              SizedBox(width: 10),
              StreamBuilder<teacherModel>(
                  stream: teacherDatabase(teacherId: user!.userId).teacherData,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      teacherModel? teacher = snapshot.data;
                      return ImageNetwork(
                          image: teacher!.teacherProfileImg,
                          height: 40,
                          width: 40,
                          borderRadius: BorderRadius.circular(70));
                    } else {
                      return Container();
                    }
                  }),
              SizedBox(width: 10)
            ],
          ),
          body: viewMenu
              ? Column(
                  children: <Widget>[
                    teacherMenu(selected: 1),
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 80),
                            child: pages[page]))
                  ],
                )
              : Column(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 80),
                            child: pages[page]))
                  ],
                ));
    } else {
      return Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                width: 300,
                color: const Color(0xff71CBCA),
                child: teacherLeftPane(selected: 1)),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 70, vertical: 80),
                    child: pages[page]))
          ],
        ),
      );
    }
  }
}

// return Scaffold(
//       body: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Container(
//               width: 300,
//               color: const Color(0xff71CBCA),
//               child: const teacherLeftPane(selected: 1)),
          // Expanded(
          //     child: Container(
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
          //         child: pages[page])),
//         ],
//       ),
//     );
