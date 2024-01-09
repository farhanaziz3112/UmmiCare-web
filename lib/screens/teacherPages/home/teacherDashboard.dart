import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/charts/allStudentsAttendancePercentage.dart';
import 'package:ummicare/screens/charts/allStudentsStatusPercentage.dart';
import 'package:ummicare/screens/charts/noOfStudentsPerClass.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/services/studentAttendanceDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';
import 'package:ummicare/shared/function.dart';

class teacherDashboard extends StatefulWidget {
  const teacherDashboard({super.key});

  @override
  State<teacherDashboard> createState() => _teacherDashboardState();
}

class _teacherDashboardState extends State<teacherDashboard> {
  AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder<teacherModel>(
      stream: teacherDatabase(teacherId: user!.userId).teacherData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          teacherModel? teacher = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome, ${teacher!.teacherFullName}!',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 50.0,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Last login: ${_auth.getUserLastSignedIn()}',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 1.0,
                    width: double.infinity,
                    color: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Class and Student Statistics',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
                        fontFamily: 'Comfortaa',
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: 50),
                noOfStudentsBasedOnClassYear(teacherId: teacher.teacherId),
                const SizedBox(height: 50),
                StreamBuilder<List<academicCalendarModel>>(
                    stream: academicCalendarDatabase()
                        .allAcademicCalendarDataWithTeacherId(
                            teacher.teacherId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<academicCalendarModel>? academicCalendar =
                            snapshot.data;
                        return StreamBuilder<List<studentModel>>(
                          stream: studentDatabase().allStudents(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<studentModel>? students = snapshot.data;
                              return SizedBox(
                                height: 450,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            allStudentsStatusPercentage(
                                                teacherId: teacher.teacherId),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Active Student: ${getNoOfStudentStatusBasedOnAcademicCalendar(students!, academicCalendar!, 'active')}',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              'Inactive Student: ${getNoOfStudentStatusBasedOnAcademicCalendar(students, academicCalendar, 'inactive')}',
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 1,
                                              blurRadius: 5,
                                              offset: const Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: StreamBuilder<
                                                List<studentAttendanceModel>>(
                                            stream: studentAttendanceDatabase()
                                                .allStudentAttendance(),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                List<studentAttendanceModel>?
                                                    attendanceList =
                                                    snapshot.data;
                                                int totalPresent =
                                                    getNoOfStudentAttendanceBasedOnAcademicCalendar(
                                                        attendanceList!,
                                                        academicCalendar,
                                                        'present');
                                                int totalAbsent =
                                                    getNoOfStudentAttendanceBasedOnAcademicCalendar(
                                                        attendanceList,
                                                        academicCalendar,
                                                        'absent');
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    allStudentsAttendacePercentage(
                                                        teacherId:
                                                            teacher.teacherId),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      'Present: ${getPercentageFromInt(totalPresent, totalPresent + totalAbsent)}%',
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      'Absent: ${getPercentageFromInt(totalAbsent, totalPresent + totalAbsent)}%',
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        );
                      } else {
                        return Container();
                      }
                    }),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
