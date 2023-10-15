import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/medicalStaff_pages/settings/medicalStaffEditProfile.dart';
import 'package:ummicare/services/auth.dart';

class medicalStaffSettingsMain extends StatefulWidget {
  const medicalStaffSettingsMain({super.key});

  @override
  State<medicalStaffSettingsMain> createState() => _medicalStaffSettingsMainState();
}

class _medicalStaffSettingsMainState extends State<medicalStaffSettingsMain> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);
    final userId = user!.userId;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          OutlinedButton.icon(
            icon: const Icon(
              Icons.person_3,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          medicalStaffEditProfile(medicalStaffId: userId)));
            },
            label: const Text(
              'Edit Profile',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 7.0,
          ),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.settings,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {},
            label: const Text(
              'System Settings',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.system_update_alt,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {},
            label: const Text(
              'Version',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.article,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {},
            label: const Text(
              'Privacy of Policy',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.pan_tool,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {},
            label: const Text(
              'Terms of Use',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.phone,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () {},
            label: const Text(
              'Contact Us',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: const Icon(
              Icons.logout,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: const Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
            ),
            onPressed: () async {
              await _auth.signOut();
            },
            label: const Text(
              'Logout',
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}