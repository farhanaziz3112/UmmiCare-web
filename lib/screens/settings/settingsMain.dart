import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/screens/settings/editProfile.dart';

import '../../models/usermodel.dart';
import '../../services/auth.dart';

class settingsMain extends StatefulWidget {
  const settingsMain({super.key});

  @override
  State<settingsMain> createState() => _settingsMainState();
}

class _settingsMainState extends State<settingsMain> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    UserModel? user = Provider.of<UserModel?>(context);
    final userId = user!.userId;

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          OutlinedButton.icon(
            icon: Icon(
              Icons.person_3,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          editProfile(currentuserId: userId)));
            },
            label: Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: Icon(
              Icons.settings,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft
            ),
            onPressed: () {},
            label: Text(
              'System Settings',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: Icon(
              Icons.system_update_alt,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft
            ),
            onPressed: () {},
            label: Text(
              'Version',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: Icon(
              Icons.article,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft
            ),
            onPressed: () {},
            label: Text(
              'Privacy of Policy',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: Icon(
              Icons.pan_tool,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft
            ),
            onPressed: () {},
            label: Text(
              'Terms of Use',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: Icon(
              Icons.phone,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft
            ),
            onPressed: () {},
            label: Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black
              ),
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          OutlinedButton.icon(
            icon: Icon(
              Icons.logout,
              size: 24.0,
              color: Colors.black,
            ),
            style: OutlinedButton.styleFrom(
              primary: Color.fromARGB(255, 255, 255, 255),
              minimumSize: const Size.fromHeight(60),
              alignment: Alignment.centerLeft
            ),
            onPressed: () async {
              await _auth.signOut();
            },
            label: Text(
              'Logout',
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black
              ),
            ),
          ),
        ],
      ),
    );
  }
}
