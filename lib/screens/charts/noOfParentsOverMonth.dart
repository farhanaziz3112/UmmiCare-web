import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/services/adminDatabase.dart';
import 'package:ummicare/shared/function.dart';

class noOfParentsOverMonth extends StatefulWidget {
  const noOfParentsOverMonth({super.key});

  @override
  State<noOfParentsOverMonth> createState() => _noOfParentsOverMonthState();
}

class _noOfParentsOverMonthState extends State<noOfParentsOverMonth> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime timeNow = DateTime.now();
    return StreamBuilder<List<parentModel>>(
      stream: adminDatabase().allParentData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<parentModel>? parentList = snapshot.data;
          return SfCartesianChart(
            // Initialize category axis
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(
              text: 'New Parents Registered Over Month in ${timeNow.year-1}',
              textStyle: const TextStyle(
                fontSize: 15
              )),
            // Enable legend
            //legend: Legend(isVisible: true),
            // Enable tooltip
            tooltipBehavior: _tooltipBehavior,
            series: <LineSeries<ParentPerMonth, String>>[
              LineSeries<ParentPerMonth, String>(
                  // Bind data source
                  dataSource: getParentPerMonthsList(parentList!),
                  xValueMapper: (ParentPerMonth parents, _) => parents.month,
                  yValueMapper: (ParentPerMonth parents, _) => parents.total),
            ]);        
        } else {
          return Container();
        }
      }
    );
  }
}

class ParentPerMonth {
  ParentPerMonth(this.month, this.total);
  final String month;
  final int total;
}

ParentPerMonth getParentPerMonth(List<parentModel> parentList, int month, int year) {
  int total = 0;
  for (int i = 0; i < parentList.length; i++) {
    DateTime temp = convertTimeToDate(parentList[i].parentCreatedDate);
    if (temp.month == month && temp.year == year) {
      total = total + 1;
    }
  }
  return ParentPerMonth(monthToString(month), total);
} 

List<ParentPerMonth> getParentPerMonthsList(List<parentModel> parentList) {
  DateTime timeNow = DateTime.now();
  List<ParentPerMonth> parentPerMonthList = [];
  for (int i = 1; i < 13; i++) {
    ParentPerMonth parentPerMonth = getParentPerMonth(parentList, i, timeNow.year-1);
    parentPerMonthList.add(parentPerMonth);
  }
  return parentPerMonthList;
}

