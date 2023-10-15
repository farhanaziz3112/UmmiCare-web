import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/auth.dart';

class adminMain extends StatefulWidget {
  const adminMain({super.key});

  @override
  State<adminMain> createState() => _adminMainState();
}

class _adminMainState extends State<adminMain> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    staffUserModel? staff = Provider.of<staffUserModel>(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40.0),
      child: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Welcome, ${staff.staffFullName}!",
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
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
              const SizedBox(
                height: 30.0,
              ),
              Container(
                alignment: Alignment.center,
                child: const Text('Statistics',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25.0,
                        fontWeight: FontWeight.w300)),
              ),
              const SizedBox(
                height: 20.0,
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 60.0, vertical: 0),
              //   width: double.infinity,
              //   alignment: Alignment.center,
              //   decoration: BoxDecoration(
              //       color: Color(0xff71CBCA),
              //       borderRadius: BorderRadius.all(Radius.circular(10))),
              //   child: Container(
              //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //     child: Column(
              //       children: <Widget>[
              //         Icon(
              //           Icons.person,
              //           size: 70.0,
              //           color: Colors.white,
              //         ),
              //         Text(
              //           'Parent',
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontSize: 20.0,
              //               fontStyle: FontStyle.italic),
              //         ),
              //         SizedBox(height: 10),
              //         Text(
              //           'Number of user: 55',
              //           style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 15.0,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // // ),
              // SizedBox(
              //   height: 10.0,
              // ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color(0xff71CBCA),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.escalator_warning,
                            size: 70.0,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Parent',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Number of active user: 55',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                'Number of inactive user: 8',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              const SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color(0xff8290F0),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.support_agent,
                            size: 70.0,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Advisor',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Number of active user: 15',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                'Number of inactive user: 2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              const SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color(0xffF29180),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.health_and_safety,
                            size: 70.0,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Medical Staff',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Number of active user: 24',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                'Number of inactive user: 6',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
              const SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    color: Color(0xff71CBCA),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: const Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Icon(
                            Icons.school,
                            size: 70.0,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Teacher',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                'Number of active user: 70',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                'Number of inactive user:11',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15.0
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )),
              ),
            ]),
      ),
    );
  }
}
