import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/teacherPages/class/classGrid.dart';
import 'package:ummicare/services/teacherDatabase.dart';

class classMain extends StatefulWidget {
  const classMain({super.key});

  @override
  State<classMain> createState() => _classMainState();
}

class _classMainState extends State<classMain> {
  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder<teacherModel>(
        stream: teacherDatabase(teacherId: user!.userId).teacherData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            teacherModel? teacher = snapshot.data;
            return SingleChildScrollView(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                alignment: Alignment.topLeft,
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Class',
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
                      alignment: Alignment.topLeft,
                      child: ElevatedButton.icon(
                        icon: const Icon(
                          Icons.add_circle,
                          size: 24.0,
                          color: Colors.white,
                        ),
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xffF29180),
                          fixedSize: const Size(350, 50),
                          alignment: Alignment.center,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                              side: BorderSide.none),
                        ),
                        onPressed: () {
                          context.go(
                              '/teacher/class/registernewclass');
                        },
                        label: const Text(
                          'Register New Academic Calendar',
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Container(
                        constraints:
                            const BoxConstraints(maxHeight: 800, minHeight: 200),
                        child: Expanded(
                            child: classGrid(
                          teacherId: teacher!.teacherId,
                        )))
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }


  
}
