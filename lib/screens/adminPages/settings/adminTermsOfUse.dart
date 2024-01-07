import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class adminTermsOfUse extends StatefulWidget {
  const adminTermsOfUse({super.key});

  @override
  State<adminTermsOfUse> createState() => _adminTermsOfUseState();
}

class _adminTermsOfUseState extends State<adminTermsOfUse> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        child: SingleChildScrollView(
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
                          context.go('/admin/settings');
                        }),
                ),
                const SizedBox(width: 10),
                const Text('>'),
                const SizedBox(width: 10),
                RichText(
                  text: const TextSpan(
                    text: 'Terms of Use',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Terms of Use',
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
                'You can see the system\'s terms of use here.',
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
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset:
                                const Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Last Updated: 7 January 2024',
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Terms of Use',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Welcome to UmmiCare! These Terms of Use govern your use of UmmiCare App. By accessing or using the App, you agree to be bound by these Terms.'),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '1.0 User Agreement',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '1.1 Acceptance',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'By using the App, you agree to comply with these Terms. If you do not agree, please refrain from using the App.'),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '2.0 Use of the App',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '2.1 Age Restriction',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'The App is intended for use by parents, with range of individuals age of above 18 years old. Users under this age must have parental supervision.'),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '2.2 User Conduct',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Users are prohibited from engaging in any unlawful, harmful, or disruptive activities while using the App. Any violation may result in the termination of access.'),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '3.0 Privacy',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Our Privacy Policy governs the collection, use, and protection of user information. By using the App, you consent to the practices outlined in our Privacy Policy.'),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    )),
                Expanded(flex: 1, child: Container())
              ],
            )
          ]),
        ));
  }
}
