import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/services/auth.dart';

class teacherSettingsMain extends StatefulWidget {
  const teacherSettingsMain({super.key});

  @override
  State<teacherSettingsMain> createState() => _teacherSettingsMainState();
}

class _teacherSettingsMainState extends State<teacherSettingsMain> {
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Settings',
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
            const SizedBox(height: 50),
            Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.person_3,
                  size: 24.0,
                  color: Colors.white,
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xff8290F0),
                  fixedSize: const Size(300,50),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide.none),
                ),
                onPressed: () {
                  context.go('/teacher/settings/editprofile');
                },
                label: const Text(
                  'Edit Profile',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.school,
                  size: 24.0,
                  color: Colors.white,
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xff8290F0),
                  fixedSize: const Size(300,50),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide.none),
                ),
                onPressed: () {
                  context.go('/teacher/settings/schoolregistration');
                },
                label: const Text(
                  'School Registration',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.system_update_alt,
                  size: 24.0,
                  color: Colors.white,
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xff8290F0),
                  fixedSize: const Size(300,50),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide.none),
                ),
                onPressed: () {
                  context.go('/teacher/settings/version');
                },
                label: const Text(
                  'Version',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.article,
                  size: 24.0,
                  color: Colors.white,
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xff8290F0),
                  fixedSize: const Size(300,50),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide.none),
                ),
                onPressed: () {
                  context.go('/teacher/settings/privacyofpolicy');
                },
                label: const Text(
                  'Privacy of Policy',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.pan_tool,
                  size: 24.0,
                  color: Colors.white,
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xff8290F0),
                  fixedSize: const Size(300,50),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide.none),
                ),
                onPressed: () {
                  context.go('/teacher/settings/termsofuse');
                },
                label: const Text(
                  'Terms of Use',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.phone,
                  size: 24.0,
                  color: Colors.white,
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xff8290F0),
                  fixedSize: const Size(300,50),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide.none),
                ),
                onPressed: () {
                  context.go('/teacher/settings/contactus');
                },
                label: const Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: ElevatedButton.icon(
                icon: const Icon(
                  Icons.logout,
                  size: 24.0,
                  color: Colors.white,
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xff8290F0),
                  fixedSize: const Size(300,50),
                  alignment: Alignment.centerLeft,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide.none),
                ),
                onPressed: () async {
                  await _auth.signOut();
                  context.go('/signup');
                },
                label: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}