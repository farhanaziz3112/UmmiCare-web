import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/advisorModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/advisorDatabase.dart';

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
        stream: advisorDatabase(advisorId: user.userId).advisorData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            advisorModel? advisor = snapshot.data;
            return Column(
              children: <Widget>[
                ImageNetwork(
                    image: advisor!.advisorProfileImg != '' ? advisor.advisorProfileImg : 'https://firebasestorage.googleapis.com/v0/b/ummicare-6db1a.appspot.com/o/other%2Fistockphoto-1223671392-612x612.jpg?alt=media&token=0c876dbc-4385-4270-95bc-7a2130f243b1',
                    height: 100,
                    width: 100,
                    borderRadius: BorderRadius.circular(70)),
                const SizedBox(
                  height: 20,
                ),
                Text(advisor.advisorFullName),
                const SizedBox(height: 15),
                Text(advisor.advisorEmail)
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
