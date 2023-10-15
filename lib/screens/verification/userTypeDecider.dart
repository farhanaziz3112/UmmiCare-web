import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/parentModel.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/screens/admin_pages/home_admin.dart';
import 'package:ummicare/screens/advisor_pages/home_advisor.dart';
import 'package:ummicare/screens/parent_pages/home_parent.dart';
import 'package:ummicare/screens/verification/staffVerification.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/parentDatabase.dart';
import 'package:ummicare/services/staffDatabase.dart';
import 'package:ummicare/services/userDatabase.dart';

class userTypeDecider extends StatefulWidget {
  const userTypeDecider({super.key});

  @override
  State<userTypeDecider> createState() => _userTypeDeciderState();
}

class _userTypeDeciderState extends State<userTypeDecider> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userModel?>(context);

    if (user?.userType == 'parent') {
      return StreamProvider<parentModel?>.value(
        value: parentDatabase(parentId: user!.userId).parentData,
        initialData: null,
        catchError: (_,__) {},
        child: HomeParent(),
      );
    } else if (user?.userType == 'admin') {
      return StreamProvider<staffUserModel?>.value(
        value: staffDatabase(staffId: user!.userId).staffData,
        initialData: null,
        catchError: (_,__) {},
        child: HomeAdmin(),
      );
    } else {
      return staffVerification(staffId: user!.userId);
    }
  }
}
