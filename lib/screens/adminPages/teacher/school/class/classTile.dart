import 'package:flutter/material.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/services/schoolDatabase.dart';

class classTile extends StatefulWidget {
  const classTile({super.key, required this.classDetail});
  final classModel classDetail;

  @override
  State<classTile> createState() => _classTileState();
}

class _classTileState extends State<classTile> {
  final List<String> studyYearList = [
    'Kindergarten (4 Years Old)',
    'Kindergarten (5 Years Old)',
    'Kindergarten (6 Years Old)',
    'Primary School (Year 1)',
    'Primary School (Year 2)',
    'Primary School (Year 3)',
    'Primary School (Year 4)',
    'Primary School (Year 5)',
    'Primary School (Year 6)',
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<classModel>(
      stream: schoolDatabase().classData(widget.classDetail.classId),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          classModel? classDetail = snapshot.data;
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              decoration: BoxDecoration(
                color: const Color(0xff8290F0),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: Text(
                        classDetail!.classYear,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
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
                        classDetail.className,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
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
                    child: Container(
                      alignment: Alignment.center,
                      constraints:
                          const BoxConstraints(minWidth: 100, maxWidth: 200),
                      child: Text(
                        classDetail.classId,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(),
                  ),
                  Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: 15,
                        child: IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  final _formKey = GlobalKey<FormState>();

                                  String newClassName = classDetail.className;
                                  String newClassYear = classDetail.classYear;

                                  return AlertDialog(
                                    scrollable: true,
                                    title: const Text('Edit Class Details'),
                                    content: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              initialValue:
                                                  classDetail.className,
                                              decoration: const InputDecoration(
                                                labelText: "Class Name",
                                                icon: Icon(Icons.school),
                                              ),
                                              validator: (value) => value == ''
                                                  ? 'Please enter class name'
                                                  : null,
                                              onChanged: ((value) =>
                                                  setState(() {
                                                    newClassName = value;
                                                  })),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            DropdownButtonFormField(
                                              value: newClassYear,
                                              onChanged: (value) =>
                                                  setState(() {
                                                newClassYear = value!;
                                              }),
                                              decoration: const InputDecoration(
                                                labelText: "Class Year",
                                                icon: Icon(Icons.account_box),
                                              ),
                                              items: studyYearList.map((year) {
                                                return DropdownMenuItem(
                                                  value: year,
                                                  child: Text(year),
                                                );
                                              }).toList(),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xffF29180),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Cancel",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff8290F0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                        ),
                                        onPressed: () async {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            schoolDatabase().updateClassData(
                                                classDetail.classId,
                                                classDetail.schoolId,
                                                newClassName,
                                                newClassYear,
                                                classDetail.classStatus);
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: const Text("Update",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      )),
                ],
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
