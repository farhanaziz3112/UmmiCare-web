import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/models/subjectModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/shared/loading.dart';

class examSubjectTile extends StatefulWidget {
  const examSubjectTile(
      {super.key,
      required this.academicCalendarId,
      required this.subjectId,
      required this.examId});
  final String academicCalendarId;
  final String subjectId;
  final String examId;

  @override
  State<examSubjectTile> createState() => _examSubjectTileState();
}

class _examSubjectTileState extends State<examSubjectTile> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<subjectModel>(
      stream: academicCalendarDatabase()
          .subjectData(widget.academicCalendarId, widget.subjectId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          subjectModel? subject = snapshot.data;
          return Padding(
            padding: const EdgeInsets.all(0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(1)),
                border: Border.all(color: Colors.grey),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: const Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: Text(
                        subject!.subjectName,
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: Text(
                        subject.subjectId,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 1,
                          child: IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              context.go(
                                  '/teacher/class/${widget.academicCalendarId}/exam/${widget.examId}/${subject.subjectId}');
                            },
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Loading();
        }
      },
    );
  }
}
