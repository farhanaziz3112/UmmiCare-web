import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/screens/auth/authenticate.dart';
import 'package:ummicare/screens/home_advisor.dart';
import 'package:ummicare/screens/home_parent.dart';
import 'package:ummicare/screens/home_admin.dart';
import 'package:ummicare/models/usermodel.dart';
import 'package:ummicare/screens/userTypeDecider.dart';
import 'package:ummicare/services/database.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuthModel?>(context);

    //return either the Home or Auth pages
    //depending on the current state of auth
    if (user == null) {
      return Authenticate();
    } else {
      return StreamProvider<UserModel?>.value(
        value: DatabaseService(userId: user.userId).userData,
        initialData: null,
        catchError: (_,__) {},
        child: userTypeDecider(),
      );
    }
  }
}
