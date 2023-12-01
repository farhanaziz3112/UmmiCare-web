import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/advisorModel.dart';
import 'package:ummicare/models/childModel.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/charts/noOfChildsCategory.dart';
import 'package:ummicare/screens/charts/noOfChildsOverMonth.dart';
import 'package:ummicare/screens/charts/noOfParentsOverMonth.dart';
import 'package:ummicare/services/adminDatabase.dart';
import 'package:ummicare/services/advisorDatabase.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/shared/function.dart';

class advisorDashboard extends StatefulWidget {
  const advisorDashboard({super.key});

  @override
  State<advisorDashboard> createState() => _advisorDashboardState();
}

class _advisorDashboardState extends State<advisorDashboard> {
  AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder<advisorModel>(
        stream: advisorDatabase(advisorId: user!.userId).advisorData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            advisorModel? advisor = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome, ${advisor!.advisorFullName}!',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 50.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    'Last login: ${_auth.getUserLastSignedIn()}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 15,
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
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'User Statistics',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40.0,
                          fontFamily: 'Comfortaa',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                                width: 800,
                                height: 350,
                                child: noOfParentsOverMonth()),
                            const SizedBox(height: 20),
                            Container(
                              width: 800,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              decoration: const BoxDecoration(
                                  color: Color(0xff8290F0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Row(
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.escalator_warning,
                                          size: 50.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: StreamBuilder<List<parentModel>>(
                                            stream:
                                                adminDatabase().allParentData,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                List<parentModel>? parentList =
                                                    snapshot.data;
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    const Text(
                                                      'Parent',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                    const SizedBox(
                                                        height: 10.0),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Total Parent Registered: ${parentList!.length}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14.0),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(),
                                                        ),
                                                        Text(
                                                          'Number of Active Parent: ${parentList.length}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14.0),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(),
                                                        ),
                                                        const Text(
                                                          'Number of Inactive Parent: 0',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14.0),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(
                                width: 800,
                                height: 350,
                                child: noOfChildsOverMonth()),
                            const SizedBox(height: 20),
                            Container(
                              width: 800,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              decoration: const BoxDecoration(
                                  color: Color(0xff8290F0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  child: Row(
                                    children: <Widget>[
                                      const Padding(
                                        padding: EdgeInsets.all(20.0),
                                        child: Icon(
                                          Icons.child_care_rounded,
                                          size: 50.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Expanded(
                                        child: StreamBuilder<List<childModel>>(
                                            stream:
                                                adminDatabase().allChildData,
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                List<childModel>? childList =
                                                    snapshot.data;
                                                return Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    const Text(
                                                      'Child',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20.0,
                                                          fontStyle:
                                                              FontStyle.italic),
                                                    ),
                                                    const SizedBox(
                                                        height: 10.0),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          'Total Child Registered: ${childList!.length}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14.0),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(),
                                                        ),
                                                        Text(
                                                          'Number of Active Child: ${childList.length}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14.0),
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: Container(),
                                                        ),
                                                        const Text(
                                                          'Number of Inactive Child: 0',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14.0),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return Container();
                                              }
                                            }),
                                      )
                                    ],
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  StreamBuilder<List<childModel>>(
                      stream: adminDatabase().allChildData,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<childModel>? childList = snapshot.data;
                          return SizedBox(
                            height: 400,
                            child: Row(
                              children: <Widget>[
                                const Expanded(
                                  flex: 1,
                                  child: noOfChildsCategory(),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.center,
                                          constraints:
                                              const BoxConstraints.expand(),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                          decoration: const BoxDecoration(
                                              color: Color(0xff71CBCA),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              const Icon(
                                                Icons.child_care,
                                                size: 80,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                'Newborn to 3 Years Old',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 5),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Divider(
                                                  color: Colors.white,
                                                  thickness: 1,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                getNoOfChildCategory(childList!,
                                                        'Newborn to 3 years old')
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 40,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.center,
                                          constraints:
                                              const BoxConstraints.expand(),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                          decoration: const BoxDecoration(
                                              color: Color(0xffF29180),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              const Icon(
                                                Icons.sentiment_very_satisfied,
                                                size: 80,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                '3 to 6 Years Old',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 5),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Divider(
                                                  color: Colors.white,
                                                  thickness: 1,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                getNoOfChildCategory(childList,
                                                        '3 to 6 years old')
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 40,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          alignment: Alignment.center,
                                          constraints:
                                              const BoxConstraints.expand(),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 20),
                                          decoration: const BoxDecoration(
                                              color: Color(0xff8290F0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10))),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              const Icon(
                                                Icons.face,
                                                size: 80,
                                                color: Colors.white,
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                '7 to 12 Years Old',
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color: Colors.white),
                                                textAlign: TextAlign.center,
                                              ),
                                              const SizedBox(height: 5),
                                              const Padding(
                                                padding: EdgeInsets.symmetric(horizontal: 20),
                                                child: Divider(
                                                  color: Colors.white,
                                                  thickness: 1,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                getNoOfChildCategory(childList,
                                                        '7 to 12 years old')
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 40,
                                                    color: Colors.white),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}


