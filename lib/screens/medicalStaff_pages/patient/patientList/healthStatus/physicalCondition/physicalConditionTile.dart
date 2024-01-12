import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/services/healthDatabase.dart';

class physicalConditionTile extends StatefulWidget {
  const physicalConditionTile({super.key, required this.physicalCondition});
  final PhysicalConditionModel physicalCondition;

  @override
  State<physicalConditionTile> createState() => _physicalConditionTileState();
}

class _physicalConditionTileState extends State<physicalConditionTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PhysicalConditionModel>(
      stream: HealthDatabaseService().physicalConditionData(widget.physicalCondition.physicalConditionId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          PhysicalConditionModel? physical = snapshot.data;
          return InkWell(
            onTap: () {
              var id = physical.physicalConditionId;
              context.go('/medicalstaff/patient/${physical.patientId}/physicalcondition/$id');
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
                          physical!.currentInjury,
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
                          physical.details,
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
                          physical.physicalConditionId,
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
