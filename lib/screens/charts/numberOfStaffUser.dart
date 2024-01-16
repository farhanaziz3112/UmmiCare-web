import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/services/adminDatabase.dart';
import 'package:ummicare/services/staffDatabase.dart';
import 'package:ummicare/shared/function.dart';

class numberOfStaffUser extends StatefulWidget {
  const numberOfStaffUser({super.key});

  @override
  State<numberOfStaffUser> createState() => _numberOfStaffUserState();
}

class _numberOfStaffUserState extends State<numberOfStaffUser> {
  late TooltipBehavior _tooltip;

  @override
  void initState() {
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<staffUserModel>>(
      stream: adminDatabase().allVerifiedStaffData('true'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<staffUserModel>? staffs = snapshot.data;
          return SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(minimum: 0, maximum: staffs!.length.toDouble() + 3, interval: 1),
              tooltipBehavior: _tooltip,
              series: <CartesianSeries<StaffData, String>>[
                ColumnSeries<StaffData, String>(
                    dataSource: getStaffData(staffs),
                    pointColorMapper: (StaffData data, _) => data.color,
                    xValueMapper: (StaffData sales, _) =>
                        sales.userType as String,
                    yValueMapper: (StaffData sales, _) => sales.total,
                    name: 'Current Total'),
              ]);
        } else {
          return Container();
        }
      },
    );
  }
}

class StaffData {
  StaffData(this.userType, this.total, this.color);
  final String userType;
  final int total;
  final Color color;
}

List<StaffData> getStaffData(List<staffUserModel> staffs) {
  int advisor = getTotalUserType(staffs, 'advisor');
  int teacher = getTotalUserType(staffs, 'teacher');
  int medicalstaff = getTotalUserType(staffs, 'medicalstaff');
  int admin = getTotalUserType(staffs, 'admin');

  return <StaffData>[
    StaffData('Advisor', advisor, Colors.purple[800]!),
    StaffData('Teacher', teacher, Colors.green[800]!),
    StaffData('Medical Staff', medicalstaff, Colors.red[800]!),
    StaffData('Admin', admin, Colors.blue[800]!),
    StaffData('Total', admin+medicalstaff+teacher+advisor, Colors.orange[800]!),
  ];
}
