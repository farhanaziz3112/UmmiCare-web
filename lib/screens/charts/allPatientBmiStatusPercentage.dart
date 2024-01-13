import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/healthmodel.dart';
import 'package:ummicare/models/patientModel.dart';
import 'package:ummicare/services/healthDatabase.dart';
import 'package:ummicare/services/patientDatabase.dart';

class allPatientBmiStatusPercentage extends StatefulWidget {
  const allPatientBmiStatusPercentage({super.key, required this.clinicId});
  final String clinicId;

  @override
  State<allPatientBmiStatusPercentage> createState() =>
      _allPatientBmiStatusPercentageState();
}

class _allPatientBmiStatusPercentageState
    extends State<allPatientBmiStatusPercentage> {
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
          return StreamBuilder<List<BmiModel>>(
            stream: HealthDatabaseService().allBmiData(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                List<BmiModel>? bmi = snapshot.data;
                return SfCircularChart(
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    PieSeries<BmiData, String>(
                      dataSource: getBmiData(patient!, bmi!),
                      radius: '100%',
                      pointColorMapper: (BmiData data, _) =>
                          data.color,
                      xValueMapper: (BmiData data, _) => data.status,
                      yValueMapper: (BmiData data, _) => data.data,
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

class BmiData {
  BmiData(this.status, this.data, this.color);
  final String status;
  final double data;
  final Color color;
}

List<BmiData> getBmiData(List<patientModel> patient, List<BmiModel> bmi) {
  List<double> bmiData = [];
  for (int i = 0; i < patient.length; i++) {
    DateTime? date;
    double bmi2 = 0;
    for (int j = 0; j < bmi.length; j++) {
      if (patient[i].healthId == bmi[j].healthId) {
        if (date == null || date.isBefore(bmi[j].createdAt)) {
          date = bmi[j].createdAt;
          bmi2 = bmi[j].bmiData;
        }
      }
    }
    bmiData.add(bmi2);
  }

  int total = 0;
  int total1 = 0;
  int total2 = 0;
  int total3 = 0;
  int total4 = 0;
  int total5 = 0;
  int total6 = 0;
  int total7 = 0;
  int total8 = 0;
  int total9 = 0;
  for (int i = 0; i < bmiData.length; i++) {
    if (bmiData[i] < 16) {
      total1 = total1 + 1;
      total = total + 1;
    } else if (bmiData[i] < 17) {
      total2 = total2 + 1;
      total = total + 1;
    } else if (bmiData[i] < 18.5) {
      total3 = total3 + 1;
      total = total + 1;
    } else if (bmiData[i] < 25) {
      total4 = total4 + 1;
      total = total + 1;
    } else if (bmiData[i] < 30) {
      total5 = total5 + 1;
      total = total + 1;
    } else if (bmiData[i] < 35) {
      total6 = total6 + 1;
      total = total + 1;
    } else if (bmiData[i] < 40) {
      total7 = total7 + 1;
      total = total + 1;
    } else if (bmiData[i] >= 40) {
      total8 = total8 + 1;
      total = total + 1;
    } else {
      total9 = total9 + 1;
      total = total + 1;
    }
  }

  List<BmiData> filteredData = [
    if (total1 > 0)
      BmiData('Severe Thinness', getPercentage(total1, total), Colors.blue[800]!),
    if (total2 > 0)
      BmiData('Moderate Thinness', getPercentage(total2, total), Colors.red[800]!),
    if (total3 > 0)
      BmiData('Mild Thinness', getPercentage(total3, total), Colors.green[800]!),
    if (total4 > 0)
      BmiData('Normal', getPercentage(total4, total), Colors.orange[800]!),
    if (total5 > 0)
      BmiData('Overweight', getPercentage(total5, total), Colors.lightBlue[800]!),
    if (total6 > 0)
      BmiData('Obese Class I', getPercentage(total6, total), Colors.purple[800]!),
    if (total7 > 0)
      BmiData('Obese Class II', getPercentage(total7, total), Colors.yellow[800]!),
    if (total8 > 0)
      BmiData('Obese Class III', getPercentage(total8, total), Colors.pink[800]!),
    if (total9 > 0)
      BmiData('No Status', getPercentage(total9, total), Colors.grey),
  ];

  return filteredData;
}

double getPercentage(int subject, int total) {
  return double.parse(((subject / total) * 100).toStringAsFixed(2));
}
