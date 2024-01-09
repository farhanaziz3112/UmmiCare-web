import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class medicalStaffContactUs extends StatefulWidget {
  const medicalStaffContactUs({super.key});

  @override
  State<medicalStaffContactUs> createState() => _medicalStaffContactUsState();
}

class _medicalStaffContactUsState extends State<medicalStaffContactUs> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          alignment: Alignment.topLeft,
          child: Column(children: <Widget>[
            Row(
              children: <Widget>[
                RichText(
                  text: TextSpan(
                      text: 'Settings',
                      style: const TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go('/medicalstaff/settings');
                        }),
                ),
                const SizedBox(width: 10),
                const Text('>'),
                const SizedBox(width: 10),
                RichText(
                  text: const TextSpan(
                    text: 'Contact Us',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Contact Us',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 45.0,
                    fontFamily: 'Comfortaa',
                    fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Please contact us if there is any problem regarding the system. Our contact detail can be seen as below.',
                style: TextStyle(
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
            const SizedBox(height: 30),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Contact Us',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'For any questions, concerns, or support related to UmmiCare, please feel free to reach out to us using the following contact methods:'),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.email),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Email',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'farhanaziz3112@gmail.com',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('maizat13501@gmail.com'),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.phone),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Customer Support Phone',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '018-2026040',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('013-5223880'),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: <Widget>[
                              Icon(Icons.location_on),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Mailing Address',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 18),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                              'Universiti Malaya, 50603 Kuala Lumpur, Wilayah Persekutuan Kuala Lumpur'),
                        ],
                      ),
                    )),
                Expanded(flex: 1, child: Container())
              ],
            )
          ])),
    );
  }
}
