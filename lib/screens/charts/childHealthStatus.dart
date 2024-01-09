import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/shared/function.dart';

class childHealthStatus extends StatefulWidget {
  const childHealthStatus({super.key, required this.parentId});
  final String parentId;

  @override
  State<childHealthStatus> createState() => _childHealthStatusState();
}

class _childHealthStatusState extends State<childHealthStatus> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<childModel>>(
      stream: parentDatabase(parentId: widget.parentId).allChildData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<childModel>? childList = snapshot.data;
          return SfCartesianChart(
              title: ChartTitle(
                  text: 'Number of Childs Based On Health Status',
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(minimum: 0, maximum: 10, interval: 1),
              tooltipBehavior: _tooltip,
              series: <CartesianSeries<StatusData, String>>[
                BarSeries<StatusData, String>(
                  dataSource: getStatusData(childList!),
                  pointColorMapper: (StatusData data, _) => data.color,
                  xValueMapper: (StatusData data, _) => data.x,
                  yValueMapper: (StatusData data, _) => data.y,
                )
              ]);
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

List<StatusData> getStatusData(List<childModel> childList) {
  int active = getNoOfChildHealthStatus(childList, true);
  int inactive = getNoOfChildHealthStatus(childList, false);

  return <StatusData>[
    StatusData('Inactive', inactive, Colors.red),
    StatusData('Active', active, Colors.green),
  ];
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
