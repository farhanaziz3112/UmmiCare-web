import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/medicalStaffModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/medicalStaffDatabase.dart';

class medicalStaffHomeProfile extends StatefulWidget {
  const medicalStaffHomeProfile({super.key});

  @override
  State<medicalStaffHomeProfile> createState() => _medicalStaffHomeProfileState();
}

class _medicalStaffHomeProfileState extends State<medicalStaffHomeProfile> {
  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder(
        stream: medicalStaffDatabase().medicalStaffData(user!.userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            medicalStaffModel? doc = snapshot.data;
            return Column(
              children: <Widget>[
                ImageNetwork(
                    image: doc!.medicalStaffProfileImg,
                    height: 100,
                    width: 100,
                    borderRadius: BorderRadius.circular(70)),
                const SizedBox(
                  height: 20,
                ),
                Text(doc.medicalStaffFullName),
                const SizedBox(height: 15),
                Text(doc.medicalStaffEmail)
              ],
            );
          } else {
            return Container(
              child: Text("ss"),
            );
          }
        });
  }
}