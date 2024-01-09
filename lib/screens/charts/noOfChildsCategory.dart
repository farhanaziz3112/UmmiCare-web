import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/services/adminDatabase.dart';
import 'package:ummicare/shared/function.dart';

class noOfChildsCategory extends StatefulWidget {
  const noOfChildsCategory({super.key});

  @override
  State<noOfChildsCategory> createState() => _noOfChildsCategoryState();
}

class _noOfChildsCategoryState extends State<noOfChildsCategory> {
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
              text: 'Number of Childs For Each Age Category',
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
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
                    textStyle: TextStyle(
                      fontSize: 20
                    )))
          ],
        );
        } else {
          return Container();
        }
      }
    );
  }
}

class CategoryData {
  CategoryData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}

List<CategoryData> getCategoryData(List<childModel> childList) {
  int category1 = getNoOfChildCategory(childList, 'Newborn to 3 years old');
  int category2 = getNoOfChildCategory(childList, '3 to 6 years old');
  int category3 = getNoOfChildCategory(childList, '7 to 12 years old');

  return <CategoryData>[
    CategoryData('Newborn to 3 years old', category1, const Color(0xff71CBCA)),
    CategoryData('3 to 6 years old', category2, const Color(0xffF29180)),
    CategoryData('7 to 12 years old', category3, const Color(0xff8290F0))
  ];
}
