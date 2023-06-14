import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/services/eduDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class addNewEduCalendar extends StatefulWidget {
  const addNewEduCalendar({super.key, required this.childId});
  final String childId;

  @override
  State<addNewEduCalendar> createState() => _addNewEduCalendarState();
}

class _addNewEduCalendarState extends State<addNewEduCalendar> {
  final _formKey = GlobalKey<FormState>();

  final List<String> currentYear = [
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

//education model value holder
  DateTime _currentCalendarEndDate = DateTime.now();
  DateTime _currentCalendarStartDate = DateTime.now();
  String _currentYear = "Primary School (Year 1)";
  String _currentStatus = "";
  List<String> _currentSubjects = [];

//school form value holder
  String _currentSchoolName = "";
  String _currentSchoolAddress = "";
  String _currentSchoolEmail = "";
  String _currentSchoolPhoneNumber = "";

//class form value holder
  String _currentClassName = "";
  String _classTeacherId = "";
  String _schoolId = "";

//teacher form value holder
  String _currentTeacherName = "";
  String _currentTeacherEmail = "";
  String _currentTeacherPhoneNumber = "";
  String _classId = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add New Calendar",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Current Year',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  DropdownButtonFormField(
                    value: _currentYear,
                    onChanged: (value) => setState(() {
                      _currentYear = value!;
                    }),
                    decoration: textInputDecoration,
                    items: currentYear.map((year) {
                      return DropdownMenuItem(
                        value: year,
                        child: Text(year),
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Calendar Start Date',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          _currentCalendarStartDate.day.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(' / '),
                        Text(
                          _currentCalendarStartDate.month.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(' / '),
                        Text(
                          _currentCalendarStartDate.year.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                        ElevatedButton(
                          child: Text('Set Start Date'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: _currentCalendarStartDate,
                              firstDate: DateTime(1995),
                              lastDate: DateTime.now(),
                            ).then((date) {
                              setState(() {
                                _currentCalendarStartDate = date!;
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Calendar End Date',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          _currentCalendarEndDate.day.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(' / '),
                        Text(
                          _currentCalendarEndDate.month.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                        Text(' / '),
                        Text(
                          _currentCalendarEndDate.year.toString(),
                          style: TextStyle(fontSize: 20.0),
                        ),
                        ElevatedButton(
                          child: Text('Set End Date'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                          ),
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: _currentCalendarEndDate,
                              firstDate: DateTime(1995),
                              lastDate: DateTime.now(),
                            ).then((date) {
                              setState(() {
                                _currentCalendarEndDate = date!;
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'School Information',
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'School Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: _currentSchoolName,
                    decoration: textInputDecoration,
                    validator: (value) =>
                        value == '' ? 'Please enter the school name' : null,
                    onChanged: (value) =>
                        setState(() => _currentSchoolName = value),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'School Address',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: _currentSchoolAddress,
                    maxLines: 5,
                    minLines: 1,
                    decoration: textInputDecoration,
                    validator: (value) =>
                        value == '' ? 'Please enter the school address' : null,
                    onChanged: (value) =>
                        setState(() => _currentSchoolAddress = value),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'School Email',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: _currentSchoolEmail,
                    decoration: textInputDecoration,
                    validator: (value) =>
                        value == '' ? 'Please enter the school email' : null,
                    onChanged: (value) =>
                        setState(() => _currentSchoolEmail = value),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'School Phone Number',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: _currentSchoolPhoneNumber,
                    decoration: textInputDecoration,
                    validator: (value) => value == ''
                        ? 'Please enter the school phone number'
                        : null,
                    onChanged: (value) =>
                        setState(() => _currentSchoolPhoneNumber = value),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Class and Teacher',
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Class Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: _currentClassName,
                    decoration: textInputDecoration,
                    validator: (value) =>
                        value == '' ? 'Please enter the class name' : null,
                    onChanged: (value) =>
                        setState(() => _currentClassName = value),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Class Teacher Name',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: _currentTeacherName,
                    decoration: textInputDecoration,
                    validator: (value) => value == ''
                        ? 'Please enter the teacher class name'
                        : null,
                    onChanged: (value) =>
                        setState(() => _currentTeacherName = value),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Class Teacher Email',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: _currentTeacherEmail,
                    decoration: textInputDecoration,
                    validator: (value) => value == ''
                        ? 'Please enter the class teacher email'
                        : null,
                    onChanged: (value) =>
                        setState(() => _currentTeacherEmail = value),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Class Teacher Phone Number',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    initialValue: _currentTeacherPhoneNumber,
                    decoration: textInputDecoration,
                    validator: (value) =>
                        value == '' ? 'Please enter the class name' : null,
                    onChanged: (value) =>
                        setState(() => _currentTeacherPhoneNumber = value),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Subjects List',
                      style: TextStyle(fontSize: 25.0),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  CheckboxListTile(
                      title: Text(
                        'Bahasa Melayu',
                        //style: TextStyle(fontSize: 5.0),
                      ),
                      isThreeLine: false,
                      tileColor: Color(0xff71CBCA),
                      value: this.subjectCheckboxes[0],
                      onChanged: (value) {
                        setState(() {
                          this.subjectCheckboxes[0] = value!;
                        });
                      }),
                  SizedBox(
                    height: 5.0,
                  ),
                  CheckboxListTile(
                      title: Text('Bahasa Inggeris'),
                      tileColor: Color(0xffF29180),
                      value: this.subjectCheckboxes[1],
                      onChanged: (value) {
                        setState(() {
                          this.subjectCheckboxes[1] = value!;
                        });
                      }),
                  SizedBox(
                    height: 5.0,
                  ),
                  CheckboxListTile(
                      title: Text('Matematik'),
                      tileColor: Color(0xff8290F0),
                      value: this.subjectCheckboxes[2],
                      onChanged: (value) {
                        setState(() {
                          this.subjectCheckboxes[2] = value!;
                        });
                      }),
                  SizedBox(
                    height: 5.0,
                  ),
                  CheckboxListTile(
                      title: Text('Sains'),
                      tileColor: Color(0xff71CBCA),
                      value: this.subjectCheckboxes[3],
                      onChanged: (value) {
                        setState(() {
                          this.subjectCheckboxes[3] = value!;
                        });
                      }),
                  SizedBox(
                    height: 5.0,
                  ),
                  CheckboxListTile(
                      title: Text('Pendidikan Islam'),
                      tileColor: Color(0xffF29180),
                      value: this.subjectCheckboxes[4],
                      onChanged: (value) {
                        setState(() {
                          this.subjectCheckboxes[4] = value!;
                        });
                      }),
                  SizedBox(
                    height: 5.0,
                  ),
                  CheckboxListTile(
                      title: Text('Pendidikan Moral'),
                      tileColor: Color(0xff8290F0),
                      value: this.subjectCheckboxes[5],
                      onChanged: (value) {
                        setState(() {
                          this.subjectCheckboxes[5] = value!;
                        });
                      }),
                  SizedBox(
                    height: 5.0,
                  ),
                  CheckboxListTile(
                      title: Text('Muzik'),
                      tileColor: Color(0xff71CBCA),
                      value: this.subjectCheckboxes[6],
                      onChanged: (value) {
                        setState(() {
                          this.subjectCheckboxes[6] = value!;
                        });
                      }),
                  SizedBox(
                    height: 5.0,
                  ),
                  CheckboxListTile(
                      title: Text('Pendidikan Seni Visual'),
                      tileColor: Color(0xffF29180),
                      value: this.subjectCheckboxes[7],
                      onChanged: (value) {
                        setState(() {
                          this.subjectCheckboxes[7] = value!;
                        });
                      }),
                  SizedBox(
                    height: 5.0,
                  ),
                  CheckboxListTile(
                      title: Text('Pendidikan Jasmani'),
                      tileColor: Color(0xff8290F0),
                      value: this.subjectCheckboxes[8],
                      onChanged: (value) {
                        setState(() {
                          this.subjectCheckboxes[8] = value!;
                        });
                      }),
                  SizedBox(
                    height: 5.0,
                  ),
                  CheckboxListTile(
                      title: Text('Sejarah'),
                      tileColor: Color(0xff71CBCA),
                      value: this.subjectCheckboxes[9],
                      onChanged: (value) {
                        setState(() {
                          this.subjectCheckboxes[9] = value!;
                        });
                      }),
                  SizedBox(
                    height: 5.0,
                  ),
                  CheckboxListTile(
                      title: Text('Bahasa Arab'),
                      tileColor: Color(0xffF29180),
                      value: this.subjectCheckboxes[10],
                      onChanged: (value) {
                        setState(() {
                          this.subjectCheckboxes[10] = value!;
                        });
                      }),
                  SizedBox(
                    height: 5.0,
                  ),
                  CheckboxListTile(
                      title: Text('Bahasa Tamil'),
                      tileColor: Color(0xff8290F0),
                      value: this.subjectCheckboxes[11],
                      onChanged: (value) {
                        setState(() {
                          this.subjectCheckboxes[11] = value!;
                        });
                      }),
                  SizedBox(
                    height: 5.0,
                  ),
                  CheckboxListTile(
                      title: Text('Bahasa Cina'),
                      tileColor: Color(0xff71CBCA),
                      value: this.subjectCheckboxes[12],
                      onChanged: (value) {
                        setState(() {
                          this.subjectCheckboxes[12] = value!;
                        });
                      }),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      //_formKey.currentState!.validate()
                      if (true) {
                        //------------School-------------
                        // String schoolIdHolder =
                        //     DateTime.now().millisecondsSinceEpoch.toString();
                        // await EduDatabaseService(
                        //         childId: widget.childId,
                        //         schoolId: schoolIdHolder)
                        //     .createSchoolData(
                        //         schoolIdHolder,
                        //         _currentSchoolAddress,
                        //         _currentSchoolEmail,
                        //         _currentSchoolName,
                        //         _currentSchoolPhoneNumber);

                        //------------Checked Subjects-------------
                        List<String> checkedSubjects = [];
                        for (var i = 0; i < 13; i++) {
                          if (subjectCheckboxes[i] == true) {
                            checkedSubjects.add(subjects[i]);
                            await FirebaseFirestore.instance.collection('Education').doc('Kn9QIpUlkh6hSP9boBiZ').collection('subjects').doc().set({'subjectsName': '${subjects[i]}'});
                          }
                        }
                        print(checkedSubjects);
                      }
                      //await FirebaseFirestore.instance.collection('Education').doc('Kn9QIpUlkh6hSP9boBiZ').collection('subjects').doc().set({'subjectsName': 'Bahasa Melayu'});
                      // await EduDatabaseService(childId: widget.childId).createEducationData(
                      //     widget.childId,
                      //     '123',
                      //     '123',
                      //     '123',
                      //     '123',
                      //     '123',
                      //     '123',
                      //     '123',
                      //     ['BM', 'BI', 'MATE'],
                      //   );
                      //Kn9QIpUlkh6hSP9boBiZ
                      // if (_formKey.currentState!.validate()) {
                      //   await EduDatabaseService(childId: widget.childId).createEducationData(
                      //     widget.childId,
                      //     '123',
                      //     '123',
                      //     '123',
                      //     '123',
                      //     '123',
                      //     '123',
                      //     '123',
                      //     ['BM', 'BI', 'MATE'],
                      //   );
                      // }
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
