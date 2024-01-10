import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/healthStatusModel.dart';
import 'package:ummicare/services/healthDatabase.dart';

class chronicConditionTile extends StatefulWidget {
  const chronicConditionTile({super.key, required this.chronicCondition});
  final ChronicConditionModel chronicCondition;

  @override
  State<chronicConditionTile> createState() => _chronicConditionTileState();
}

class _chronicConditionTileState extends State<chronicConditionTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChronicConditionModel>(
      stream: healthDatabaseService().chronicConditionData(widget.chronicCondition.chronicConditionId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          ChronicConditionModel? chronic = snapshot.data;
          return InkWell(
            onTap: () {
              var id = chronic.chronicConditionId;
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
                          chronic!.childAllergies,
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
                          chronic.childChronic,
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
                          chronic.chronicConditionId,
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
