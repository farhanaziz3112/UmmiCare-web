import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/staffDatabase.dart';

class advisorHomeProfile extends StatefulWidget {
  const advisorHomeProfile({super.key});

  @override
  State<advisorHomeProfile> createState() => _advisorHomeProfileState();
}

class _advisorHomeProfileState extends State<advisorHomeProfile> {
  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel>(context);

    return StreamBuilder(
        stream: staffDatabase(staffId: user.userId).staffData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            staffUserModel? staff = snapshot.data;
            return Column(
              children: <Widget> [
                CircleAvatar(
                  backgroundImage: NetworkImage(staff!.staffProfileImg),
                  radius: 35,
                ),
                SizedBox(height: 20,),
                Text(staff.staffFullName),
                SizedBox(height: 15),
                Text(staff.staffEmail)
              ],
            );
          } else {
            return Container();
          }
        }
    );
  }
}
