import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';

class medicalStaffDashboard extends StatefulWidget {
  const medicalStaffDashboard({super.key});

  @override
  State<medicalStaffDashboard> createState() => _medicalStaffDashboardState();
}

class _medicalStaffDashboardState extends State<medicalStaffDashboard> {
  AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder<medicalStaffModel>(
      stream: medicalStaffDatabase(medicalStaffId: user!.userId).medicalStaffData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          medicalStaffModel? doc = snapshot.data;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome, ${doc!.medicalStaffFullName}!',
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
              ],
            ),
          );
        } else {
           return Container();
        }
      },
    );
  }
}