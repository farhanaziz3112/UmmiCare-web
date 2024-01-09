import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/studentAttendanceDatabase.dart';
import 'package:ummicare/shared/function.dart';

class allStudentsAttendacePercentage extends StatefulWidget {
  const allStudentsAttendacePercentage({super.key, required this.teacherId});
  final String teacherId;

  @override
  State<allStudentsAttendacePercentage> createState() =>
      _allStudentsAttendacePercentageState();
}

class _allStudentsAttendacePercentageState
    extends State<allStudentsAttendacePercentage> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<academicCalendarModel>>(
      stream: academicCalendarDatabase()
          .allAcademicCalendarDataWithTeacherId(widget.teacherId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<academicCalendarModel>? academicCalendar = snapshot.data;
          return StreamBuilder<List<studentAttendanceModel>>(
            stream: studentAttendanceDatabase().allStudentAttendance(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<studentAttendanceModel>? studentAttendance = snapshot.data;
                return SfCircularChart(
                  title: ChartTitle(
                      text: 'Students Attendance Percentage',
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20)),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    PieSeries<AttendanceData, String>(
                        dataSource: getAttendanceData(
                            academicCalendar!, studentAttendance!),
                        radius: '100%',
                        pointColorMapper: (AttendanceData data, _) =>
                            data.color,
                        xValueMapper: (AttendanceData data, _) => data.x,
                        yValueMapper: (AttendanceData data, _) => data.y,
                        dataLabelSettings: const DataLabelSettings(
                            // Renders the data label
                            isVisible: true,
                            textStyle:
                                TextStyle(fontSize: 20, color: Colors.white)))
                  ],
                );
              } else {
                return Container();
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class AttendanceData {
  AttendanceData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

List<AttendanceData> getAttendanceData(
    List<academicCalendarModel> academicCalendar,
    List<studentAttendanceModel> attendanceList) {
  int totalPresent = getNoOfStudentAttendanceBasedOnAcademicCalendar(
      attendanceList, academicCalendar, 'present');
  int totalAbsent = getNoOfStudentAttendanceBasedOnAcademicCalendar(
      attendanceList, academicCalendar, 'absent');

  return <AttendanceData>[
    AttendanceData('Absent', getPercentage(totalAbsent, totalAbsent + totalPresent), Colors.red[800]!),
    AttendanceData('Present', getPercentage(totalPresent, totalPresent + totalAbsent), Colors.green[800]!),
  ];
}

double getPercentage(int subject, int total) {
  return double.parse(((subject / total) * 100).toStringAsFixed(2));
}

