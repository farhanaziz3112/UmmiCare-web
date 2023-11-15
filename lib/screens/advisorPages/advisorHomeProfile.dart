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
                    image: advisor!.advisorProfileImg,
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
