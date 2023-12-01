// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class noOfPaidStudents extends StatefulWidget {
//   const noOfPaidStudents({super.key, required this.feeId});
//   final String feeId;

//   @override
//   State<noOfPaidStudents> createState() => _noOfPaidStudentsState();
// }

// class _noOfPaidStudentsState extends State<noOfPaidStudents> {
//   late TooltipBehavior _tooltipBehavior;

//   @override
//   void initState() {
//     _tooltipBehavior = TooltipBehavior(enable: true);
//     super.initState();
//   }

//   // final List<CategoryData> categoryData = [
//   //   CategoryData('Inactive', 2, const Color(0xff71CBCA)),
//   //   CategoryData('Active', 3, const Color(0xffF29180)),
//   // ];
  
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<List<studentModel>>(
//       stream: studentDatabase().allStudentWithAcademicCalendar(widget.academicCalendarId),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           List<studentModel>? studentList = snapshot.data;
//           return SfCircularChart(
//           title: ChartTitle(
//               text: 'Number of Students Based On Status',
//               textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
//           tooltipBehavior: _tooltipBehavior,
//           series: <CircularSeries>[
//             PieSeries<CategoryData, String>(
//                 dataSource: getCategoryData(studentList!),
//                 radius: '100%',
//                 pointColorMapper: (CategoryData data, _) => data.color,
//                 xValueMapper: (CategoryData data, _) => data.x,
//                 yValueMapper: (CategoryData data, _) => data.y,
//                 dataLabelSettings: const DataLabelSettings(
//                     // Renders the data label
//                     isVisible: true,
//                     textStyle: TextStyle(
//                       fontSize: 20
//                     )))
//           ],
//         );
//         } else {
//           return Container();
//         }
//       }
//     );
//   }
// }

// class CategoryData {
//   CategoryData(this.x, this.y, this.color);
//   final String x;
//   final int y;
//   final Color color;
// }

// List<CategoryData> getCategoryData(List<studentModel> studentList) {
//   int category1 = getNoOfStudentStatus(studentList, 'inactive');
//   int category2 = getNoOfStudentStatus(studentList, 'active');

//   return <CategoryData>[
//     CategoryData('Inactive', category1, const Color(0xffF29180)),
//     CategoryData('Active', category2, const Color(0xff8290F0)),
//   ];
// }