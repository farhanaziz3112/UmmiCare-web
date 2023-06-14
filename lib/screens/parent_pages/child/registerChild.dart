import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ummicare/services/database.dart';
import 'package:ummicare/shared/function.dart';

import '../../../services/storage.dart';
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
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Insert your child details',
                  style: TextStyle(fontSize: 20.0),
                ),
                // SizedBox(
                //   height: 40.0,
                // ),
                // Container(
                //   alignment: Alignment.centerLeft,
                //   padding: EdgeInsets.only(left: 20.0),
                //   child: Text(
                //     'Profile Picture',
                //     textAlign: TextAlign.left,
                //     style: TextStyle(
                //       fontSize: 15.0,
                //       fontWeight: FontWeight.bold,
                //       color: Colors.grey[500],
                //     ),
                //   ),
                // ),
                // Stack(
                //   clipBehavior: Clip.none,
                //   children: [
                //     CircleAvatar(
                //       backgroundImage: NetworkImage(childProfileImg),
                //       radius: 50.0,
                //       backgroundColor: Colors.grey,
                //     ),
                //     Positioned(
                //       bottom: -60,
                //       right: -15,
                //       top: 0,
                //       child: RawMaterialButton(
                //         onPressed: () async {
                //           ImagePicker imagePicker = ImagePicker();
                //           XFile? file = await imagePicker.pickImage(
                //               source: ImageSource.camera);
                //           print('${file!.path}');

                //           StorageService _storageService = StorageService();
                //           setState(() async {
                //             childProfileImg = await _storageService
                //                 .uploadChildProfilePic(widget.file);
                //             print(childProfileImg);
                //           });
                //         },
                //         constraints: BoxConstraints.tight(Size(30, 30)),
                //         elevation: 2.0,
                //         fillColor: Color.fromARGB(255, 216, 216, 216),
                //         child: Icon(Icons.edit, color: Colors.black),
                //         padding: EdgeInsets.all(0.0),
                //         shape: CircleBorder(),
                //       ),
                //     )
                //   ],
                // ),
                // CircleAvatar(
                //   radius: 50.0,
                //   backgroundImage: NetworkImage(usermodel.userProfileImg),
                // ),
                SizedBox(
                  height: 30.0,
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
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Child first name'),
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
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        childBirthday.day.toString(),
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(' / '),
                      Text(
                        childBirthday.month.toString(),
                        style: TextStyle(fontSize: 20.0),
                      ),
                      Text(' / '),
                      Text(
                        childBirthday.year.toString(),
                        style: TextStyle(fontSize: 20.0),
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
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff8290F0)),
                  child: Text(
                    'Create child profile',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(userId: widget.currentuserId)
                          .createChildData(
                              widget.currentuserId,
                              childName,
                              childFirstname,
                              childLastname,
                              childBirthday.millisecondsSinceEpoch.toString(),
                              getAge(childBirthday.millisecondsSinceEpoch.toString()),
                              getAgeCategory(getAge(childBirthday.millisecondsSinceEpoch.toString())),
                              childProfileImg);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
