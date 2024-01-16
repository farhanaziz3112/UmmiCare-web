import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/services/adminDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';
import 'package:ummicare/shared/function.dart';

class noOfPatientCategory extends StatefulWidget {
  const noOfPatientCategory({super.key, required this.clinicId});
  final String clinicId;

  @override
  State<noOfPatientCategory> createState() =>
      _noOfPatientCategoryState();
}

class _noOfPatientCategoryState
    extends State<noOfPatientCategory> {
  late TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<patientModel>>(
      stream: PatientDatabaseService().allPatientData(widget.clinicId),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          List<patientModel>? patient = snapshot.data;
          return StreamBuilder<List<childModel>>(
            stream: adminDatabase().allChildData,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                List<childModel>? child = snapshot.data;
                return SfCircularChart(
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    PieSeries<CategoryData, String>(
                      dataSource: getBmiData(patient!, child!),
                      radius: '100%',
                      pointColorMapper: (CategoryData data, _) =>
                          data.color,
                      xValueMapper: (CategoryData data, _) => data.x,
                      yValueMapper: (CategoryData data, _) => data.y,
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
        }else{
          return Container();
        }
      },
    );
  }
}

class CategoryData {
  CategoryData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}

List<CategoryData> getBmiData(List<patientModel> patient, List<childModel> child) {
  List<childModel> childList = [];
  for (int i = 0; i < patient.length; i++) {
    for (int j = 0; j < child.length; j++) {
      if (patient[i].healthId == child[j].healthId) {
        childList.add(child[j]);
      }
    }
  }

  int category1 = getNoOfChildCategory(childList, 'Newborn to 3 years old');
  int category2 = getNoOfChildCategory(childList, '3 to 6 years old');
  int category3 = getNoOfChildCategory(childList, '7 to 12 years old');

  return <CategoryData>[
    CategoryData('Newborn to 3 years old', category1, const Color(0xff71CBCA)),
    CategoryData('3 to 6 years old', category2, const Color(0xffF29180)),
    CategoryData('7 to 12 years old', category3, const Color(0xff8290F0))
  ];
}
