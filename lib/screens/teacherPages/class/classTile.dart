import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/academicCalendarModel.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/subjectModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/shared/function.dart';
import 'package:ummicare/shared/loading.dart';

class classTile extends StatefulWidget {
  const classTile(
      {super.key,
      required this.academicCalendarDetail,
      required this.colorIndex});
  final academicCalendarModel academicCalendarDetail;
  final int colorIndex;

  @override
  State<classTile> createState() => _classTileState();
}

class _classTileState extends State<classTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<academicCalendarModel>(
      stream: academicCalendarDatabase().academicCalendarData(
          widget.academicCalendarDetail.academicCalendarId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          academicCalendarModel? academicCalendarDetail = snapshot.data;
          return StreamBuilder<classModel>(
            stream: schoolDatabase().classData(academicCalendarDetail!.classId),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                classModel? classDetail = snapshot.data;
                return InkWell(
                  onTap: () {
                    context.go(
                        '/teacher/class/${academicCalendarDetail.academicCalendarId}');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      decoration: BoxDecoration(
                        color: widget.colorIndex == 0
                            ? const Color(0xff8290F0)
                            : widget.colorIndex == 1
                                ? const Color(0xff71CBCA)
                                : const Color(0xffF29180),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.class_),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${classDetail!.classYear}: ',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            classDetail.className,
                            style: TextStyle(fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container(
                  child: const Text('no data'),
                );
              }
            }),
          );
        } else {
          return Container(
            child: const Text('no data'),
          );
        }
      }),
    );
  }

  Widget buildSubjectList(List<subjectModel>? subjectList) {
    if (subjectList!.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: const Center(
          child: Text(
            'No subject registered.',
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: subjectList.length,
        itemBuilder: ((context, index) {
          return InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Text(subjectList[index].subjectName),
            ),
          );
        }),
      );
    }
  }
}
