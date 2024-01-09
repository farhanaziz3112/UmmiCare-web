import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/studentAttendanceModel.dart';
import 'package:ummicare/services/studentAttendanceDatabase.dart';
import 'package:ummicare/shared/function.dart';

class studentAttendancePercentage extends StatefulWidget {
  const studentAttendancePercentage(
      {super.key, required this.academicCalendarId, required this.studentId});
  final String academicCalendarId;
  final String studentId;

  @override
  State<studentAttendancePercentage> createState() =>
      _studentAttendancePercentageState();
}

class _studentAttendancePercentageState
    extends State<studentAttendancePercentage> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<studentAttendanceModel>>(
        stream: studentAttendanceDatabase().allStudentAttendanceWithStudentId(widget.studentId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<studentAttendanceModel>? attendanceList = snapshot.data;
            return SfCircularChart(
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                PieSeries<AttendanceData, String>(
                    dataSource: getAttendanceData(attendanceList!),
                    radius: '100%',
                    pointColorMapper: (AttendanceData data, _) => data.color,
                    xValueMapper: (AttendanceData data, _) => data.x,
                    yValueMapper: (AttendanceData data, _) => data.y,
                    dataLabelSettings: const DataLabelSettings(
                        // Renders the data label
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 15, color: Colors.white)))
              ],
            );
          } else {
            return Container();
          }
        });
  }
}

class AttendanceData {
  AttendanceData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

List<AttendanceData> getAttendanceData(List<studentAttendanceModel> attendanceList) {
  int present = getNoOfAttendanceStatus(attendanceList, 'present');
  int absent = getNoOfAttendanceStatus(attendanceList, 'absent');

  return <AttendanceData>[
    AttendanceData('Present', getPercentage(present, present+absent), Colors.green[800]!),
    AttendanceData('Absent', getPercentage(absent, present+absent), Colors.red[800]!)
  ];
}

double getPercentage(int subject, int total) {
  return double.parse(((subject / total) * 100).toStringAsFixed(2));
}
