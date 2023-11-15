import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/advisorPages/parent/parentList/parentList.dart';
import 'package:ummicare/services/advisorDatabase.dart';

class parentMain extends StatefulWidget {
  const parentMain({super.key});

  @override
  State<parentMain> createState() => _parentMainState();
}

class _parentMainState extends State<parentMain> {
  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamProvider<List<parentModel>>.value(
      initialData: [],
      value: advisorDatabase(advisorId: user!.userId).getParents(user.userId),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Parent',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 50.0,
                    fontFamily: 'Comfortaa',
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
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: const Text(
                      'Email',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Container(
                    alignment: Alignment.center,
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: const Text(
                      'First Name',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Container(
                    alignment: Alignment.center,
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: const Text(
                      'Last Name',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Container(
                    alignment: Alignment.center,
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: const Text(
                      'User Id',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                  Container(
                    alignment: Alignment.center,
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: const Text(
                      'Number of Children',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ),
                  Expanded(flex: 1, child: Container()),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: parentList(),
            )
          ],
        ),
      ),
    );
  }
}
