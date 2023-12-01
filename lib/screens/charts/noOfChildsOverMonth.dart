import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/services/adminDatabase.dart';
import 'package:ummicare/shared/function.dart';

class noOfChildsOverMonth extends StatefulWidget {
  const noOfChildsOverMonth({super.key});

  @override
  State<noOfChildsOverMonth> createState() => _noOfChildsOverMonthState();
}

class _noOfChildsOverMonthState extends State<noOfChildsOverMonth> {

  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeNow = DateTime.now();
    return StreamBuilder<List<childModel>>(
      stream: adminDatabase().allChildData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<childModel>? childList = snapshot.data;
          return SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(
              text: 'Number of New Childs Registered Over Month in ${timeNow.year}',
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold
              )),
            // Enable legend
            //legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: _tooltipBehavior,
            series: <LineSeries<ChildPerMonth, String>>[
              LineSeries<ChildPerMonth, String>(
                  // Bind data source
                  dataSource: getChildPerMonthsList(childList!),
                  xValueMapper: (ChildPerMonth Childs, _) => Childs.month,
                  yValueMapper: (ChildPerMonth Childs, _) => Childs.total),
            ]);        
        } else {
          return Container(
            child: const Center(
              child: Text('No data'),
            ),
          );
        }
      }
    );
  }
}

class ChildPerMonth {
  ChildPerMonth(this.month, this.total);
  final String month;
  final int total;
}

ChildPerMonth getChildPerMonth(List<childModel> childList, int month, int year) {
  int total = 0;
  for (int i = 0; i < childList.length; i++) {
    DateTime temp = convertTimeToDate(childList[i].childCreatedDate);
    if (temp.month == month && temp.year == year) {
      total = total + 1;
    }
  }
  return ChildPerMonth(monthToString(month), total);
} 

List<ChildPerMonth> getChildPerMonthsList(List<childModel> childList) {
  DateTime timeNow = DateTime.now();
  List<ChildPerMonth> ChildPerMonthList = [];
  for (int i = 1; i < timeNow.month; i++) {
    ChildPerMonth childPerMonth = getChildPerMonth(childList, i, timeNow.year);
    ChildPerMonthList.add(childPerMonth);
  }
  return ChildPerMonthList;
}