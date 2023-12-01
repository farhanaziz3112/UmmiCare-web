import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/screens/adminPages/teacher/school/class/classList.dart';
import 'package:ummicare/services/schoolDatabase.dart';

class schoolProfile extends StatefulWidget {
  const schoolProfile({super.key, required this.schoolId});
  final String schoolId;

  @override
  State<schoolProfile> createState() => _schoolProfileState();
}

class _schoolProfileState extends State<schoolProfile> {

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
    return StreamBuilder<schoolModel>(
      stream: schoolDatabase().schoolData(widget.schoolId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          schoolModel? school = snapshot.data;
          return Container(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                            text: 'Teacher',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/admin/teacher');
                              }),
                      ),
                      const SizedBox(width: 10),
                      const Text('>'),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                            text: 'School',
                            style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.go('/admin/teacher/school');
                              }),
                      ),
                      const SizedBox(width: 10),
                      const Text('>'),
                      const SizedBox(width: 10),
                      RichText(
                        text: TextSpan(
                          text: school!.schoolName,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      school.schoolName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 45.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      school.schoolEmail,
                      style: const TextStyle(
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
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Text(
                          'School Details',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30.0,
                              fontFamily: 'Comfortaa',
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 25,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    final _formKey = GlobalKey<FormState>();

                                    String newSchoolName = school.schoolName;
                                    String newSchoolAddress =
                                        school.schoolAddress;
                                    String newSchoolEmail = school.schoolEmail;
                                    String newSchoolPhoneNumber =
                                        school.schoolPhoneNumber;

                                    return AlertDialog(
                                      scrollable: true,
                                      title: const Text('Edit School Details'),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Form(
                                          key: _formKey,
                                          child: Column(
                                            children: <Widget>[
                                              TextFormField(
                                                initialValue: school.schoolName,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "School Name",
                                                  icon: Icon(Icons.school),
                                                ),
                                                validator: (value) => value ==
                                                        ''
                                                    ? 'Please enter school name'
                                                    : null,
                                                onChanged: ((value) =>
                                                    setState(() {
                                                      newSchoolName = value;
                                                    })),
                                              ),
                                              TextFormField(
                                                initialValue:
                                                    school.schoolAddress,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "School Address",
                                                  icon:
                                                      Icon(Icons.location_city),
                                                ),
                                                validator: (value) => value ==
                                                        ''
                                                    ? 'Please enter school address'
                                                    : null,
                                                onChanged: ((value) =>
                                                    setState(() {
                                                      newSchoolAddress = value;
                                                    })),
                                              ),
                                              TextFormField(
                                                initialValue:
                                                    school.schoolEmail,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: "School Email",
                                                  icon: Icon(Icons.email),
                                                ),
                                                validator: (value) => value ==
                                                        ''
                                                    ? 'Please enter school email'
                                                    : null,
                                                onChanged: ((value) =>
                                                    setState(() {
                                                      newSchoolEmail = value;
                                                    })),
                                              ),
                                              TextFormField(
                                                initialValue:
                                                    school.schoolPhoneNumber,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText:
                                                      "School Contact Number",
                                                  icon: Icon(Icons.phone),
                                                ),
                                                validator: (value) => value ==
                                                        ''
                                                    ? 'Please enter school contact number'
                                                    : null,
                                                onChanged: ((value) =>
                                                    setState(() {
                                                      newSchoolPhoneNumber =
                                                          value;
                                                    })),
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
                                              style: TextStyle(
                                                  color: Colors.white)),
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
                                              schoolDatabase().updateSchoolData(
                                                  school.schoolId,
                                                  newSchoolName,
                                                  newSchoolAddress,
                                                  newSchoolEmail,
                                                  newSchoolPhoneNumber);
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: const Text("Update",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            style: IconButton.styleFrom(
                                backgroundColor: const Color(0xffF29180)))
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: const Text(
                                'School Name',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                school.schoolName,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: const Text(
                                'School Email',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                school.schoolEmail,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: const Text(
                                'School Address',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                school.schoolAddress,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: const Text(
                                'School Contact Number',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                school.schoolPhoneNumber,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(flex: 2, child: Container()),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Class',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.add_circle,
                        size: 20.0,
                        color: Colors.white,
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xffF29180),
                        fixedSize: const Size(200, 50),
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                            side: BorderSide.none),
                      ),
                      onPressed: () {
                        //context.go('/admin/teacher/school/addclass');
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              final _formKey = GlobalKey<FormState>();

                              String className = '';
                              String classYear = studyYearList[3];

                              return AlertDialog(
                                scrollable: true,
                                title: const Text('Add New Class'),
                                content: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: <Widget>[
                                        TextFormField(
                                          initialValue: className,
                                          decoration: const InputDecoration(
                                            labelText: "Class Name",
                                            icon: Icon(Icons.school),
                                          ),
                                          validator: (value) => value == ''
                                              ? 'Please enter class name'
                                              : null,
                                          onChanged: ((value) => setState(() {
                                                className = value;
                                              })),
                                        ),
                                        SizedBox(height: 10,),
                                        DropdownButtonFormField(
                                          value: classYear,
                                          onChanged: (value) => setState(() {
                                            classYear = value!;
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
                                      backgroundColor: const Color(0xffF29180),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff8290F0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        schoolDatabase().createClassData(
                                            school.schoolId,
                                            className,
                                            classYear,
                                            'unoccupied');
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text("Submit",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              );
                            });
                      },
                      label: const Text(
                        'Add New Class',
                        style: TextStyle(fontSize: 15.0, color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    //padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Class Year',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Class Name',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                        ),
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(
                                minWidth: 100, maxWidth: 200),
                            child: const Text(
                              'Class ID',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          ),
                        ),
                        Expanded(flex: 3, child: Container()),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  StreamProvider<List<classModel>>.value(
                    initialData: [],
                    value: schoolDatabase()
                        .allclassDataWithSchoolId(school.schoolId),
                    child: const classList(),
                  ),
                  const SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
