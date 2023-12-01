import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/models/subjectModel.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/academicCalendarDatabase.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/services/teacherDatabase.dart';

class registerNewClass extends StatefulWidget {
  const registerNewClass({super.key});

  @override
  State<registerNewClass> createState() => _registerNewClassState();
}

class _registerNewClassState extends State<registerNewClass> {
  final _formKey = GlobalKey<FormState>();

  //form values holder
  DateTime _currentCalendarStartDate = DateTime.now();
  DateTime _currentCalendarEndDate = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day + 1);
  classModel? _currentClass;

  final List<String> subjects = [
    'Bahasa Melayu',
    'Bahasa Inggeris',
    'Matematik',
    'Sains',
    'Pendidikan Islam',
    'Pendidikan Moral',
    'Muzik',
    'Pendidikan Seni Visual',
    'Pendidikan Jasmani',
    'Sejarah',
    'Bahasa Arab',
    'Bahasa Tamil',
    'Bahasa Cina',
  ];

  //subjects selection checkboxes bool holder
  List<bool> subjectCheckboxes = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  List<classModel> classList = [];
  List<subjectModel> subjectList = [];

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder<teacherModel>(
        stream: teacherDatabase(teacherId: user!.userId).teacherData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            teacherModel? teacher = snapshot.data;
            return Container(
              alignment: Alignment.topLeft,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              text: 'Class',
                              style: const TextStyle(
                                  color: Colors.grey,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go('/teacher/class');
                                }),
                        ),
                        const SizedBox(width: 10),
                        const Text('>'),
                        const SizedBox(width: 10),
                        RichText(
                          text: const TextSpan(
                            text: 'Register New Class',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Register New Class',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 45.0,
                            fontFamily: 'Comfortaa',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Register new class by setting up the details for academic calendar.',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w500),
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
                    const SizedBox(height: 50),
                    Form(
                      key: _formKey,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: const Text(
                                    'Class Selection',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      _currentClass != null
                                          ? Text(
                                              '${_currentClass!.classYear} - ${_currentClass!.className}',
                                              style: const TextStyle(fontSize: 20),
                                            )
                                          : const Text(
                                              'No class choosen',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff8290F0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return StreamBuilder<
                                                        List<classModel>>(
                                                    stream: schoolDatabase()
                                                        .allUnoccupiedClassDataWithSchoolId(
                                                            teacher!.schoolId),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        List<classModel>?
                                                            classList =
                                                            snapshot.data;
                                                        return AlertDialog(
                                                          scrollable: true,
                                                          title: const Column(
                                                            children: [
                                                              Text(
                                                                  'Class Available To Choose'),
                                                              SizedBox(
                                                                height: 20,
                                                              )
                                                            ],
                                                          ),
                                                          content: Container(
                                                            padding: const EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            height: 600,
                                                            width: 500,
                                                            child:
                                                                SingleChildScrollView(
                                                              child:
                                                                  buildClassList(
                                                                      classList!),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return const Center(
                                                          child:
                                                              Text('No data'),
                                                        );
                                                      }
                                                    });
                                              });
                                        },
                                        child: const Text(
                                          'Choose Class',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: const Text(
                                    'Calendar Starting Date',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          const Text(
                                            'Day',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            _currentCalendarStartDate.day
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        ' / ',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'Month',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            _currentCalendarStartDate.month
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        ' / ',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'Year',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            _currentCalendarStartDate.year
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff8290F0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate:
                                                _currentCalendarStartDate,
                                            firstDate: DateTime(
                                                _currentCalendarStartDate.year -
                                                    1),
                                            lastDate: DateTime(
                                                _currentCalendarEndDate.year,
                                                _currentCalendarEndDate.month,
                                                _currentCalendarEndDate.day -
                                                    1),
                                          ).then((date) {
                                            setState(() {
                                              _currentCalendarStartDate = date!;
                                            });
                                          });
                                        },
                                        child: const Text(
                                          'Set Calendar Start Date',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: const Text(
                                    'Calendar End Date',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0.0, horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          const Text(
                                            'Day',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            _currentCalendarEndDate.day
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        ' / ',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'Month',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            _currentCalendarEndDate.month
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        ' / ',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            'Year',
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            _currentCalendarEndDate.year
                                                .toString(),
                                            style:
                                                const TextStyle(fontSize: 20.0),
                                          ),
                                        ],
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xff8290F0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        onPressed: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate:
                                                _currentCalendarEndDate,
                                            firstDate: DateTime(
                                                _currentCalendarStartDate.year,
                                                _currentCalendarStartDate.month,
                                                _currentCalendarStartDate.day +
                                                    1),
                                            lastDate: DateTime(
                                                _currentCalendarEndDate.year +
                                                    1),
                                          ).then((date) {
                                            setState(() {
                                              _currentCalendarEndDate = date!;
                                            });
                                          });
                                        },
                                        child: const Text(
                                          'Set Calendar End Date',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: const Text(
                                    'Subjects Selection',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CheckboxListTile(
                                      title: const Text(
                                        'Bahasa Melayu',
                                        //style: TextStyle(fontSize: 5.0),
                                      ),
                                      isThreeLine: false,
                                      tileColor: Colors.white,
                                      value: subjectCheckboxes[0],
                                      onChanged: (value) {
                                        setState(() {
                                          subjectCheckboxes[0] = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CheckboxListTile(
                                      title: const Text('Bahasa Inggeris'),
                                      value: subjectCheckboxes[1],
                                      onChanged: (value) {
                                        setState(() {
                                          subjectCheckboxes[1] = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CheckboxListTile(
                                      title: const Text('Matematik'),
                                      value: subjectCheckboxes[2],
                                      onChanged: (value) {
                                        setState(() {
                                          subjectCheckboxes[2] = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CheckboxListTile(
                                      title: const Text('Sains'),
                                      value: subjectCheckboxes[3],
                                      onChanged: (value) {
                                        setState(() {
                                          subjectCheckboxes[3] = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CheckboxListTile(
                                      title: const Text('Pendidikan Islam'),
                                      value: subjectCheckboxes[4],
                                      onChanged: (value) {
                                        setState(() {
                                          subjectCheckboxes[4] = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CheckboxListTile(
                                      title: const Text('Pendidikan Moral'),
                                      value: subjectCheckboxes[5],
                                      onChanged: (value) {
                                        setState(() {
                                          subjectCheckboxes[5] = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CheckboxListTile(
                                      title: const Text('Muzik'),
                                      value: subjectCheckboxes[6],
                                      onChanged: (value) {
                                        setState(() {
                                          subjectCheckboxes[6] = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CheckboxListTile(
                                      title:
                                          const Text('Pendidikan Seni Visual'),
                                      value: subjectCheckboxes[7],
                                      onChanged: (value) {
                                        setState(() {
                                          subjectCheckboxes[7] = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CheckboxListTile(
                                      title: const Text('Pendidikan Jasmani'),
                                      value: subjectCheckboxes[8],
                                      onChanged: (value) {
                                        setState(() {
                                          subjectCheckboxes[8] = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CheckboxListTile(
                                      title: const Text('Sejarah'),
                                      value: subjectCheckboxes[9],
                                      onChanged: (value) {
                                        setState(() {
                                          subjectCheckboxes[9] = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CheckboxListTile(
                                      title: const Text('Bahasa Arab'),
                                      value: subjectCheckboxes[10],
                                      onChanged: (value) {
                                        setState(() {
                                          subjectCheckboxes[10] = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CheckboxListTile(
                                      title: const Text('Bahasa Tamil'),
                                      value: subjectCheckboxes[11],
                                      onChanged: (value) {
                                        setState(() {
                                          subjectCheckboxes[11] = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(
                                            0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: CheckboxListTile(
                                      title: const Text('Bahasa Cina'),
                                      value: subjectCheckboxes[12],
                                      onChanged: (value) {
                                        setState(() {
                                          subjectCheckboxes[12] = value!;
                                        });
                                      }),
                                ),
                                const SizedBox(height: 30.0),
                                const SizedBox(
                                  height: 30.0,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffF29180),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                  child: const Text(
                                    'Register Academic Calendar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    final document = FirebaseFirestore.instance
                                        .collection('Academic Calendar')
                                        .doc();
                                    academicCalendarDatabase()
                                        .updateAcademicCalendarData(
                                            document.id,
                                            teacher!.schoolId,
                                            _currentClass!.classId,
                                            teacher.teacherId,
                                            _currentCalendarStartDate
                                                .millisecondsSinceEpoch
                                                .toString(),
                                            _currentCalendarEndDate
                                                .millisecondsSinceEpoch
                                                .toString(),
                                            '0',
                                            'open');

                                    //------------Checked Subjects-------------
                                    List<String> checkedSubjects = [];
                                    for (var i = 0; i < 13; i++) {
                                      if (subjectCheckboxes[i] == true) {
                                        checkedSubjects.add(subjects[i]);
                                        final subjectDocument =
                                            FirebaseFirestore.instance
                                                .collection('Academic Calendar')
                                                .doc();
                                        await FirebaseFirestore.instance
                                            .collection('Academic Calendar')
                                            .doc(document.id)
                                            .collection('Subjects')
                                            .doc(subjectDocument.id)
                                            .set({
                                          'subjectId': subjectDocument.id,
                                          'subjectName': '${subjects[i]}'
                                        });
                                      }
                                    }

                                    schoolDatabase().updateClassData(
                                        _currentClass!.classId,
                                        _currentClass!.schoolId,
                                        _currentClass!.className,
                                        _currentClass!.classYear,
                                        'occupied');

                                    context.go('/teacher/class');
                                  },
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  Widget buildClassList(List<classModel> classList) {
    if (classList.isEmpty) {
      return Container(
        padding: const EdgeInsets.only(top: 50),
        child: const Center(
          child: Text(
            'No class available at the moment.',
          ),
        ),
      );
    } else {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: classList.length,
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                _currentClass = classList[index];
              });
              Navigator.of(context).pop();
            },
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
              child: Text(
                  '${classList[index].classYear} - ${classList[index].className}'),
            ),
          );
        }),
      );
    }
  }
}
