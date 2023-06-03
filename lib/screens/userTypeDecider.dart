import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:ummicare/screens/auth/authenticate.dart';
import 'package:ummicare/screens/home_parent.dart';
import 'package:ummicare/screens/home_advisor.dart';
import 'package:ummicare/screens/home_admin.dart';
import 'package:ummicare/shared/loading.dart';

import '../models/usermodel.dart';

class userTypeDecider extends StatefulWidget {
  const userTypeDecider({super.key});

  @override
  State<userTypeDecider> createState() => _userTypeDeciderState();
}

class _userTypeDeciderState extends State<userTypeDecider> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);

    if (user?.userType == 'advisor') {
      return HomeAdvisor();
    } else if (user?.userType == 'parent') {
      return HomeParent();
    } else if (user?.userType == 'admin') {
      return HomeAdmin();
    } else {
      return Loading();
    }
  }
}
