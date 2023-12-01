import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/teacherModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/teacherDatabase.dart';

class teacherHomeProfile extends StatefulWidget {
  const teacherHomeProfile({super.key});

  @override
  State<teacherHomeProfile> createState() => _teacherHomeProfileState();
}

class _teacherHomeProfileState extends State<teacherHomeProfile> {
  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel>(context);

    return StreamBuilder(
        stream: teacherDatabase(teacherId: user.userId).teacherData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            teacherModel? teacher = snapshot.data;
            return Column(
              children: <Widget>[
                ImageNetwork(
                    image: teacher!.teacherProfileImg,
                    height: 100,
                    width: 100,
                    borderRadius: BorderRadius.circular(70)),
                const SizedBox(
                  height: 20,
                ),
                Text(teacher.teacherFullName),
                const SizedBox(height: 15),
                Text(teacher.teacherEmail)
              ],
            );
          } else {
            return Container();
          }
        });
  }
}