import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/studentModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/studentDatabase.dart';

class allStudentsStatusPercentage extends StatefulWidget {
  const allStudentsStatusPercentage({super.key, required this.teacherId});
  final String teacherId;

  @override
  State<allStudentsStatusPercentage> createState() =>
      _allStudentsStatusPercentageState();
}

class _allStudentsStatusPercentageState
    extends State<allStudentsStatusPercentage> {
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
          return StreamBuilder<List<studentModel>>(
            stream: studentDatabase().allStudents(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<studentModel>? students = snapshot.data;
                return SfCircularChart(
                  title: ChartTitle(
                      text: 'Number of Students Based On Status',
                      textStyle: const TextStyle(fontSize: 15)),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    PieSeries<StatusData, String>(
                        dataSource: getStatusData(academicCalendar!, students!),
                        radius: '100%',
                        pointColorMapper: (StatusData data, _) => data.color,
                        xValueMapper: (StatusData data, _) => data.x,
                        yValueMapper: (StatusData data, _) => data.y,
                        dataLabelSettings: const DataLabelSettings(
                            // Renders the data label
                            isVisible: true,
                            textStyle: TextStyle(fontSize: 20, color: Colors.white)))
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

class StatusData {
  StatusData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}

List<StatusData> getStatusData(List<academicCalendarModel> academicCalendar, List<studentModel> studentList) {

  int totalActive = 0;
  int totalInactive = 0;

  for (int i = 0; i < academicCalendar.length; i++) {
    for (int j = 0; j < studentList.length; j++) {
      if (studentList[j].academicCalendarId == academicCalendar[i].academicCalendarId) {
        if (studentList[j].activationStatus == 'active'){
          totalActive = totalActive + 1;
        } else {
          totalInactive = totalInactive + 1;
        }
      }
    }
  }

  return <StatusData>[
    StatusData('Inactive', totalInactive, Colors.red[800]!),
    StatusData('Active', totalActive, Colors.green[800]!),
  ];
}


