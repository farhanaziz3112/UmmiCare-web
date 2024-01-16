import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/schoolModel.dart';
import 'package:ummicare/screens/adminPages/teacher/school/class/classTile.dart';
import 'package:ummicare/services/schoolDatabase.dart';
import 'package:ummicare/shared/constant.dart';

class classList extends StatefulWidget {
  const classList({super.key, required this.schoolId});
  final String schoolId;

  @override
  State<classList> createState() => _classListState();
}

class _classListState extends State<classList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<classModel>>(
      stream: schoolDatabase().allclassDataWithSchoolId(widget.schoolId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<classModel>? classList = snapshot.data;
          classList!.sort((a, b) => b.classYear.compareTo(a.classYear));
          if (classList.isNotEmpty) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: classList.length,
              itemBuilder: ((context, index) {
                return classTile(
                  classDetail: classList[index],
                );
              }),
            );
          } else {
            return Container(
              padding: const EdgeInsets.only(top: 50),
              child: Center(child: noData('Oops! Nothing here...')),
            );
          }
        } else {
          return Container(
            padding: const EdgeInsets.only(top: 50),
            child: Center(child: noData('Oops! Nothing here...')),
          );
        }
      },
    );

    // if (classList.isEmpty) {
    //   return Container(
    //     padding: const EdgeInsets.only(top: 50),
    //     child: const Center(
    //       child: Text(
    //         'The list is empty.',
    //       ),
    //     ),
    //   );
    // } else {
    //   return ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: classList.length,
    //     itemBuilder: ((context, index) {
    //       return classTile(
    //         classDetail: classList[index],
    //       );
    //     }),
    //   );
    // }
  }
}
