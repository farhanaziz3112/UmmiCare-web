import 'package:flutter/material.dart';
import 'package:ummicare/routes.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/models/userModel.dart';
import 'package:ummicare/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDVfBl2Me55r85Us82Qf98p6-TMK85_4V0',
          appId: '1:1074912353697:web:67d3e92a97a314e956bfe0',
          messagingSenderId: '',
          projectId: 'ummicare-6db1a'));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //will detect the change of user auth state
    return StreamProvider<userModel?>.value(
      value: AuthService().user,
      initialData: null,
      catchError: (_, __) {
        return null;
      },
      child: MaterialApp.router(
        theme: ThemeData(fontFamily: 'ABeeZee'),
        routerConfig: routes,
      ),
    );
  }
}
