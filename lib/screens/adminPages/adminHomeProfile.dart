import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/staffDatabase.dart';

class adminHomeProfile extends StatefulWidget {
  const adminHomeProfile({super.key});

  @override
  State<adminHomeProfile> createState() => _adminHomeProfileState();
}

class _adminHomeProfileState extends State<adminHomeProfile> {
  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel?>(context);

    return StreamBuilder<staffUserModel>(
        stream: staffDatabase(staffId: user!.userId).staffData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            staffUserModel? staff = snapshot.data;
            return Column(
              children: <Widget>[
                ImageNetwork(
                    image: staff!.staffProfileImg,
                    height: 100,
                    width: 100,
                    borderRadius: BorderRadius.circular(70)),
                const SizedBox(height: 20),
                Text(staff.staffFullName),
                const SizedBox(height: 15),
                Text(staff.staffEmail)
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
