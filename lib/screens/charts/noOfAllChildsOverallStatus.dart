import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/services/adminDatabase.dart';
import 'package:ummicare/shared/function.dart';

class noOfAllChildsOverallStatus extends StatefulWidget {
  const noOfAllChildsOverallStatus({super.key});

  @override
  State<noOfAllChildsOverallStatus> createState() =>
      _noOfAllChildsOverallStatusState();
}

class _noOfAllChildsOverallStatusState
    extends State<noOfAllChildsOverallStatus> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<childModel>>(
        stream: adminDatabase().allChildData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<childModel>? childList = snapshot.data;
            return SfCircularChart(
              title: ChartTitle(
                  text: 'Number of Childs For Each Overall Status',
                  textStyle: const TextStyle(fontSize: 15)),
              tooltipBehavior: _tooltipBehavior,
              series: <CircularSeries>[
                PieSeries<CategoryData, String>(
                    dataSource: getCategoryData(childList!),
                    radius: '100%',
                    pointColorMapper: (CategoryData data, _) => data.color,
                    xValueMapper: (CategoryData data, _) => data.x,
                    yValueMapper: (CategoryData data, _) => data.y,
                    dataLabelSettings: const DataLabelSettings(
                        // Renders the data label
                        isVisible: true,
                        textStyle: TextStyle(fontSize: 15)))
              ],
            );
          } else {
            return Container();
          }
        });
  }
}

class CategoryData {
  CategoryData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}

List<CategoryData> getCategoryData(List<childModel> childList) {
  int category1 = getNoOfChildStatus(childList, 'great');
  int category2 = getNoOfChildStatus(childList, 'normal');
  int category3 = getNoOfChildStatus(childList, 'needs attention');

  return <CategoryData>[
    CategoryData('Great', category1, Colors.green[800]!),
    CategoryData('Normal', category2, Colors.yellow[800]!),
    CategoryData('Needs Attention', category3, Colors.red[800]!)
  ];
}
