import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:ummicare/services/database.dart';

import '../../../shared/constant.dart';

class registerChild extends StatefulWidget {
  const registerChild({super.key, required this.currentuserId});
  final String currentuserId;

  @override
  State<registerChild> createState() => _registerChildState();
}

class _registerChildState extends State<registerChild> {
  final _formKey = GlobalKey<FormState>();

  //form values holder
  String parentId = '';
  String childName = '';
  String childFirstname = '';
  String childLastname = '';
  DateTime childBirthday = DateTime.now();
  int childCurrentAge =
      0; //the system will calculate the current age, no need for user input
  String childAgeCategory =
      'Newborn to 3 years old'; //the system will decide the age category, no need for user input
  String childProfileImg = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Register Child",
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Insert your child details',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Username',
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
                initialValue: childName,
                decoration:
                    textInputDecoration.copyWith(hintText: 'Child name'),
                validator: (value) =>
                    value == '' ? 'Please enter your child name' : null,
                onChanged: (value) => setState(() => childName = value),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'First Name',
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
                initialValue: childFirstname,
                decoration:
                    textInputDecoration.copyWith(hintText: 'Child first name'),
                validator: (value) =>
                    value == '' ? 'Please enter your child first name' : null,
                onChanged: (value) => setState(() => childFirstname = value),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Last Name',
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
                initialValue: childLastname,
                decoration:
                    textInputDecoration.copyWith(hintText: 'Child last name'),
                validator: (value) =>
                    value == '' ? 'Please enter your child last name' : null,
                onChanged: (value) => setState(() => childLastname = value),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'Birthday',
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
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      childBirthday.day.toString(),
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    Text(
                      ' / '
                    ),
                    Text(
                      childBirthday.month.toString(),
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    Text(
                      ' / '
                    ),
                    Text(
                      childBirthday.year.toString(),
                      style: TextStyle(
                        fontSize: 20.0
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Set Birthday'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: childBirthday,
                          firstDate: DateTime(1995),
                          lastDate: DateTime.now(),
                        ).then((date) {
                          setState(() {
                            childBirthday = date!;
                          });
                        });
                      },
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xff8290F0)),
                child: Text(
                  'Create child profile',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await DatabaseService(userId: widget.currentuserId)
                        .updateChildData(
                            widget.currentuserId,
                            childName,
                            childFirstname,
                            childLastname,
                            childBirthday.toString(),
                            childCurrentAge,
                            childAgeCategory,
                            childProfileImg);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
