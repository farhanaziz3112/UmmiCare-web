import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/screens/auth/signIn.dart';
import 'package:ummicare/screens/verification/userTypeDecider.dart';
import 'package:ummicare/services/auth.dart';
import 'package:ummicare/services/userDatabase.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<userModel?>(context);
    AuthService _auth = AuthService();
    
    //return either the Home or Auth pages
    //depending on the current state of auth
    if (user == null) {
      return const SignIn();
    } else {
      _auth.currentUser = user;
      return StreamProvider<userModel?>.value(
        value: userDatabase(userId: user.userId).userData,
        initialData: null,
        catchError: (_,__) {
          return null;
        },
        child: userTypeDecider(),
      );
    }
  }
}

