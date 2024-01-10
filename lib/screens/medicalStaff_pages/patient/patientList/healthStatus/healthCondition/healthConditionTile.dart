import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/services/healthDatabase.dart';

class healthConditionTile extends StatefulWidget {
  const healthConditionTile({super.key, required this.healthCondition});
  final HealthConditionModel healthCondition;

  @override
  State<healthConditionTile> createState() => _healthConditionTileState();
}

class _healthConditionTileState extends State<healthConditionTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<HealthConditionModel>(
      stream: healthDatabaseService().healthConditionData(widget.healthCondition.healthConditionId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          HealthConditionModel? condition = snapshot.data;
          return InkWell(
            onTap: () {
              var id = condition.healthConditionId;
              context.go('/advisor/parent/${id}');
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Card(
                margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                color: const Color(0xff8290F0),
                child: ListTile(
                  contentPadding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: Text(
                          condition!.currentTemperature,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: Text(
                          condition.currentHeartRate,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: Text(
                          condition.currentIllness,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                      Container(
                        alignment: Alignment.center,
                        constraints:
                            const BoxConstraints(minWidth: 100, maxWidth: 200),
                        child: Text(
                          condition.healthConditionId,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
