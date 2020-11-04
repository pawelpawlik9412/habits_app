import 'package:flutter/material.dart';
import 'package:habitsapp/enum.dart';

import 'package:habitsapp/screens/login_screen.dart';
import 'package:habitsapp/screens/register_screen.dart';
import 'package:habitsapp/screens/password_reset_screen.dart';



class AuthenticateScreen extends StatefulWidget {
  @override
  _AuthenticateScreenState createState() => _AuthenticateScreenState();
}

class _AuthenticateScreenState extends State<AuthenticateScreen> {


  Screen showScreen = Screen.Login;

  void toggleView(Screen screen){
    setState(() {
      showScreen = screen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showScreen == Screen.Login) {
      return LoginScreen(toggleView:  toggleView);
    }
    else if(showScreen == Screen.Register) {
      return RegisterScreen(toggleView:  toggleView);
    }
    else {
      return PasswordResetScreen(toggleView: toggleView);
    }
  }
}
