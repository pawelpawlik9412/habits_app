import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:habitsapp/screens/home_screen.dart';
import 'package:habitsapp/screens/authenticate_screen.dart';

import 'package:habitsapp/providers/user_auth_status.dart';

class WrapperScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, UserAuthStatus user, _) {
        if (user.user == null) {
          return AuthenticateScreen();
        } else {
          return HomeScreen();
        }
      },
    );
  }
}
