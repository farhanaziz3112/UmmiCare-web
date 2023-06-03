import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/screens/home_parent.dart';
import 'package:ummicare/services/database.dart';
import 'package:ummicare/services/storage.dart';
import 'package:ummicare/screens/parent_pages/child/childlist/childlist.dart';

import '../../../models/childmodel.dart';
import '../../../models/usermodel.dart';

class parentMain extends StatefulWidget {
  const parentMain({super.key});

  @override
  State<parentMain> createState() => _parentMainState();
}

class _parentMainState extends State<parentMain> {
  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);

    return StreamProvider<List<ChildModel>>.value(
      initialData: [],
      value: DatabaseService(userId: user!.userId).allChildData,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Welcome, ${user.userName}!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  'Last login: 2 Jun 2023 10.30pm',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Your Child',
                      style: TextStyle(color: Colors.black, fontSize: 20.0),
                    ),
                    // TextButton(
                    //   onPressed: () {
                    //     HomeParentState().setState(() {
                    //       HomeParentState().pageIndex = 1;
                    //     });
                    //   },
                    //   child: Text('View More'),
                    // ),
                  ],
                ),
                childList(),
              ]),
        ),
      ),
    );
    ;
  }
}
