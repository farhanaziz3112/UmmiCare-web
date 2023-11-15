import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/advisorModel.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/advisorPages/home/advisorDashboard.dart';
import 'package:ummicare/screens/advisorPages/settings/advisorSettingsMain.dart';
import 'package:ummicare/screens/advisorPages/parent/parentMain.dart';
import 'package:ummicare/services/advisorDatabase.dart';
import 'package:ummicare/services/userDatabase.dart';

class advisorMainPane extends StatefulWidget {
  const advisorMainPane({super.key, required this.currentPage});
  final int currentPage;

  @override
  State<advisorMainPane> createState() => _advisorMainPaneState();
}

class _advisorMainPaneState extends State<advisorMainPane> {

  final pages = [
    const advisorDashboard(),
    const parentMain(),
    const advisorSettingsMain(),
  ];

  @override
  Widget build(BuildContext context) {
    userModel? user = Provider.of<userModel>(context);
    return StreamProvider<advisorModel?>.value(
      value: advisorDatabase(advisorId: user.userId).advisorData,
      initialData: null,
      catchError: (_, __) {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 80),
        child: pages[widget.currentPage],
        alignment: Alignment.topLeft,
      ),
    );
  }
}