import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/staffUserModel.dart';
import 'package:ummicare/screens/adminPages/adminHome.dart';
import 'package:ummicare/screens/verification/staffVerification.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/staffDatabase.dart';
import 'package:ummicare/shared/loading.dart';

class userTypeDecider extends StatefulWidget {
  const userTypeDecider({super.key});

  @override
  State<userTypeDecider> createState() => _userTypeDeciderState();
}

class _userTypeDeciderState extends State<userTypeDecider> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userModel?>(context);

    if (user == null) {
      return Loading();
    } else {
      if (user.userType == 'admin') {
        return StreamProvider<staffUserModel?>.value(
          value: staffDatabase(staffId: user.userId).staffData,
          initialData: null,
          catchError: (_, __) {
            return null;
          },
          child: adminHome(currentPage: 0),
        );
      } else {
        return staffVerification(staffId: user.userId);
      }
    }
  }
}
