import 'package:community_charts_flutter/community_charts_flutter.dart'
    as charts;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/services/staffDatabase.dart';

class adminMain extends StatefulWidget {
  const adminMain({super.key});

  @override
  State<adminMain> createState() => _adminMainState();
}

class _adminMainState extends State<adminMain> {
  AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    final List<ChartData> chartData = [
      ChartData('David', 25, Color(0xff71CBCA)),
      ChartData('Jack', 34, Color(0xffF29180)),
      ChartData('Others', 52, Color(0xff8290F0))
    ];

    return StreamBuilder<staffUserModel>(
        stream: staffDatabase(staffId: user!.userId).staffData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            staffUserModel? staff = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome, ${staff!.staffFullName}!',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 50.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Last login: ${_auth.getUserLastSignedIn()}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      height: 1.0,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'User Statistics',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'Number of Parent User',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                                child: SimpleTimeSeriesChart.withSampleData(),
                                width: 800,
                                height: 350),
                            const SizedBox(height: 20),
                            Container(
                              width: 800,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              decoration: const BoxDecoration(
                                  color: Color(0xff8290F0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Row(
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.escalator_warning,
                                          size: 50.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'Parent',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            const SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                const Text(
                                                  'Total Parent Registered: 63',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                ),
                                                Expanded(
                                                  child: Container(),
                                                  flex: 1,
                                                ),
                                                const Text(
                                                  'Number of active user: 55',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                ),
                                                Expanded(
                                                  child: Container(),
                                                  flex: 1,
                                                ),
                                                const Text(
                                                  'Number of inactive user: 8',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            const Text(
                              'Number of Child Registered',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                                child: SimpleTimeSeriesChart.withSampleData(),
                                width: 800,
                                height: 350),
                            const SizedBox(height: 20),
                            Container(
                              width: 800,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              decoration: const BoxDecoration(
                                  color: Color(0xff8290F0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Row(
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.child_care_rounded,
                                          size: 50.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'Child',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            const SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                const Text(
                                                  'Total Child Registered: 63',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                ),
                                                Expanded(
                                                  child: Container(),
                                                  flex: 1,
                                                ),
                                                const Text(
                                                  'Number of active user: 55',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                ),
                                                Expanded(
                                                  child: Container(),
                                                  flex: 1,
                                                ),
                                                const Text(
                                                  'Number of inactive user: 8',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Staff Statistics',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'Number of Staff User',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 10),
                            Container(
                              child: SfCircularChart(
                                series: <CircularSeries>[
                                  PieSeries<ChartData, String>(
                                      dataSource: chartData,
                                      radius: '100%',
                                      pointColorMapper: (ChartData data, _) =>
                                          data.color,
                                      xValueMapper: (ChartData data, _) =>
                                          data.x,
                                      yValueMapper: (ChartData data, _) =>
                                          data.y,
                                      dataLabelSettings: DataLabelSettings(
                                          // Renders the data label
                                          isVisible: true))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 800,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              decoration: const BoxDecoration(
                                  color: Color(0xff71CBCA),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Row(
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.support_agent,
                                          size: 50.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'Advisor',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            const SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                const Text(
                                                  'Total Advisor Registered: 63',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                ),
                                                Expanded(
                                                  child: Container(),
                                                  flex: 1,
                                                ),
                                                const Text(
                                                  'Number of active user: 55',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                ),
                                                Expanded(
                                                  child: Container(),
                                                  flex: 1,
                                                ),
                                                const Text(
                                                  'Number of inactive user: 8',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 800,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              decoration: const BoxDecoration(
                                  color: Color(0xffF29180),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Row(
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.health_and_safety,
                                          size: 50.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'Medical Staff',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            const SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                const Text(
                                                  'Total Medical Staff Registered: 63',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                ),
                                                Expanded(
                                                  child: Container(),
                                                  flex: 1,
                                                ),
                                                const Text(
                                                  'Number of active user: 55',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                ),
                                                Expanded(
                                                  child: Container(),
                                                  flex: 1,
                                                ),
                                                const Text(
                                                  'Number of inactive user: 8',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: 800,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              decoration: const BoxDecoration(
                                  color: Color(0xff8290F0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Row(
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.school,
                                          size: 50.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'Teacher',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                            const SizedBox(height: 10.0),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                const Text(
                                                  'Total Teacher Registered: 63',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                ),
                                                Expanded(
                                                  child: Container(),
                                                  flex: 1,
                                                ),
                                                const Text(
                                                  'Number of Active User: 55',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                ),
                                                Expanded(
                                                  child: Container(),
                                                  flex: 1,
                                                ),
                                                const Text(
                                                  'Number of Inactive User: 8',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.0),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

class SimpleTimeSeriesChart extends StatelessWidget {
  SimpleTimeSeriesChart(this.seriesList, {required this.animate});
  final List<charts.Series<dynamic, DateTime>> seriesList;
  final bool animate;

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory SimpleTimeSeriesChart.withSampleData() {
    return new SimpleTimeSeriesChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      // Optionally pass in a [DateTimeFactory] used by the chart. The factory
      // should create the same type of [DateTime] as the data provided. If none
      // specified, the default creates local date time.
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeriesSales, DateTime>> _createSampleData() {
    final data = [
      new TimeSeriesSales(new DateTime(2017, 9, 19), 5),
      new TimeSeriesSales(new DateTime(2017, 9, 26), 25),
      new TimeSeriesSales(new DateTime(2017, 10, 3), 100),
      new TimeSeriesSales(new DateTime(2017, 10, 10), 75),
    ];

    return [
      new charts.Series<TimeSeriesSales, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeriesSales sales, _) => sales.time,
        measureFn: (TimeSeriesSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class TimeSeriesSales {
  final DateTime time;
  final int sales;

  TimeSeriesSales(this.time, this.sales);
}
