import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';

class noOfStudentsBasedOnClassYear extends StatefulWidget {
  const noOfStudentsBasedOnClassYear({super.key, required this.teacherId});
  final String teacherId;

  @override
  State<noOfStudentsBasedOnClassYear> createState() =>
      _noOfStudentsBasedOnClassYearState();
}

class _noOfStudentsBasedOnClassYearState
    extends State<noOfStudentsBasedOnClassYear> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<academicCalendarModel>>(
      stream: academicCalendarDatabase()
          .allAcademicCalendarDataWithTeacherId(widget.teacherId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<academicCalendarModel>? academicCalendarList = snapshot.data;
          return StreamBuilder<List<classModel>>(
              stream: schoolDatabase().allclassData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<classModel>? classList = snapshot.data;
                  return SfCartesianChart(
                      title: ChartTitle(
                          text: 'Number of Students Per Class',
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis:
                          NumericAxis(minimum: 0, maximum: 30, interval: 5),
                      tooltipBehavior: _tooltip,
                      series: getData(
                          widget.teacherId, academicCalendarList!, classList!));
                } else {
                  return Container();
                }
              });
        } else {
          return Container();
        }
      },
    );
  }
}

List<CartesianSeries<ClassData, String>> getData(
    String teacherId,
    List<academicCalendarModel> academicCalendarList,
    List<classModel> classList) {
  final chartData = <ClassData>[];
  for (int i = 0; i < academicCalendarList.length; i++) {
    String className = '';
    for (int j = 0; j < classList.length; j++) {
      if (academicCalendarList[i].classId == classList[j].classId) {
        className = '${classList[j].classYear} - ${classList[j].className}';
      }
    }
    chartData.add(ClassData(className,
        int.parse(academicCalendarList[i].noOfStudent), Colors.grey));
  }
  List<CartesianSeries<ClassData, String>> finalList = [];

  finalList.add(ColumnSeries<ClassData, String>(
      dataSource: chartData,
      xValueMapper: (ClassData sales, _) => sales.x as String,
      yValueMapper: (ClassData sales, _) => sales.studentTotal,
      name: ''));

  return finalList;
}

class ClassData {
  ClassData(this.x, this.studentTotal, this.color);
  final String x;
  final int studentTotal;
  final Color color;
}
