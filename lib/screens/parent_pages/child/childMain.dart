import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/screens/parent_pages/child/childlist/childlist.dart';
import 'package:ummicare/screens/parent_pages/child/registerChild.dart';
import 'package:ummicare/services/database.dart';

import '../../../models/childmodel.dart';
import '../../../models/usermodel.dart';

class childMain extends StatefulWidget {
  const childMain({super.key});

  @override
  State<childMain> createState() => _childMainState();
}

class _childMainState extends State<childMain> {
  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);
    final userId = user!.userId;

    return StreamProvider<List<ChildModel>>.value(
      initialData: [],
      value: DatabaseService(userId: userId).allChildData,
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Your Child",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff8290F0),
                      ),
                      child: Text(
                        'Add New Child',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  registerChild(currentuserId: userId))
                        );
                      }
                    )
                  ]
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: childList(),
              ),
              // TextButton(
              //   style: TextButton.styleFrom(primary: Colors.blue),
              //   onPressed: () {
              //     Navigator.of(context).pushNamed('/parent/child/childprofile');
              //   },
              //   child: Text('Child profile'),
              // ),
              // TextButton(
              //   style: TextButton.styleFrom(primary: Colors.blue),
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) =>
              //                 registerChild(currentuserId: userId)));
              //   },
              //   child: Text('Register new child'),
              // ),
              // TextButton(
              //   style: TextButton.styleFrom(primary: Colors.blue),
              //   onPressed: () {
              //     Navigator.of(context).pushNamed('/parent/child/advisory');
              //   },
              //   child: Text('Advisory page'),
              // ),
          ],
        )
      ),
    );
  }
}
