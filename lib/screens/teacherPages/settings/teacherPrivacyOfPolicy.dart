import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class teacherPrivacyOfPolicy extends StatefulWidget {
  const teacherPrivacyOfPolicy({super.key});

  @override
  State<teacherPrivacyOfPolicy> createState() => _teacherPrivacyOfPolicyState();
}

class _teacherPrivacyOfPolicyState extends State<teacherPrivacyOfPolicy> {
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
                          context.go('/teacher/settings');
                        }),
                ),
                const SizedBox(width: 10),
                const Text('>'),
                const SizedBox(width: 10),
                RichText(
                  text: const TextSpan(
                    text: 'Privacy of Policy',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Privacy of Policy',
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
                'You can see the system\'s privacy of policy here.',
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
                            'Privacy Policy',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Welcome to UmmiCare! We are committed to protecting the privacy of children using our mobile application. This Privacy Policy outlines how we collect, use, disclose, and manage personal information collected from users of our mobile app.'),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '1.0 Information Collection',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '1.1 Personal Information',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'We may collect personal information from users, such as names, ages, and contact information, for account registration or customization purposes.'),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '1.2 Non-Personal Information',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'We may collect non-personal information, such as device information, app usage statistics, and technical details to improve our services.'),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '2.0 Information Usage',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '2.1 Personal Information',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Personal information is used for account management, customization, and communication with users and parents.'),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            '2.2 Non-Personal Information',
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Non-personal information is used to analyze app performance, improve user experience, and develop new features.'),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '3.0 Data Security',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'We implement reasonable security measures to protect personal information from unauthorized access, disclosure, alteration, and destruction.'),
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            '4.0 Sharing Information',
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 18),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'We do not sell or share personal information of children with third parties for marketing purposes. However, we may share information with service providers for app functionality, maintenance, or improvement.'),
                          SizedBox(
                            height: 30,
                          ),
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
