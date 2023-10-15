import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/screens/parent_pages/child/childlist/childlist.dart';
import 'package:ummicare/screens/parent_pages/child/registerChild.dart';
import 'package:ummicare/services/parentDatabase.dart';

import '../../../models/childmodel.dart';
import '../../../models/parentModel.dart';

class childMain extends StatefulWidget {
  const childMain({super.key});

  @override
  State<childMain> createState() => _childMainState();
}

class _childMainState extends State<childMain> {
  @override
  Widget build(BuildContext context) {
    parentModel? parent = Provider.of<parentModel?>(context);
    final parentId = parent!.parentId;

    return StreamProvider<List<ChildModel>>.value(
      initialData: [],
      value: parentDatabase(parentId: parentId).allChildData,
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Text(
                      "Your Child",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w500),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff8290F0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)
                        ),
                      ),
                      child: const Text(
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
                                  registerChild(parentId: parentId))
                        );
                      }
                    )
                  ]
                ),
              ),
              const SizedBox(
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
              //                 registerChild(currentparentId: parentId)));
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
