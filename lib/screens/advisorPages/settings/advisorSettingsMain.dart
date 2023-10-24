import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ummicare/services/auth.dart';

class advisorSettingsMain extends StatefulWidget {
  const advisorSettingsMain({super.key});

  @override
  State<advisorSettingsMain> createState() => _advisorSettingsMainState();
}

class _advisorSettingsMainState extends State<advisorSettingsMain> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Settings',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 50.0,
                  fontFamily: 'Comfortaa',
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              height: 1.0,
              width: double.infinity,
              color: Colors.grey[300],
            ),
          ),
          SizedBox(height: 50),
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
                fixedSize: Size(300,50),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide.none),
              ),
              onPressed: () {
                context.go('/advisor/settings/editprofile');
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
                Icons.settings,
                size: 24.0,
                color: Colors.white,
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xff8290F0),
                fixedSize: Size(300,50),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide.none),
              ),
              onPressed: () {
                context.go('/advisor/settings/systemsettings');
              },
              label: const Text(
                'System Settings',
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
                fixedSize: Size(300,50),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide.none),
              ),
              onPressed: () {
                context.go('/advisor/settings/version');
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
                fixedSize: Size(300,50),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide.none),
              ),
              onPressed: () {
                context.go('/advisor/settings/privacyofpolicy');
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
                fixedSize: Size(300,50),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide.none),
              ),
              onPressed: () {
                context.go('/advisor/settings/termsofuse');
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
                fixedSize: Size(300,50),
                alignment: Alignment.centerLeft,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide.none),
              ),
              onPressed: () {
                context.go('/advisor/settings/contactus');
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
                fixedSize: Size(300,50),
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
    );
  }
}