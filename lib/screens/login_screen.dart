import 'package:flutter/material.dart';
import 'package:habitsapp/screens/launch_screen.dart';
import 'package:habitsapp/size_config.dart';
import 'package:habitsapp/enum.dart';
import 'package:provider/provider.dart';

import 'package:habitsapp/providers/user_auth_status.dart';

import 'package:habitsapp/custom_widgets/user_email_input.dart';
import 'package:habitsapp/custom_widgets/user_password_input.dart';

import 'package:habitsapp/custom_widgets/rounded_rectangle_button.dart';
import 'package:habitsapp/custom_widgets/start_screen_bottom_button.dart';

import 'package:habitsapp/custom_widgets/error_alert_dialog.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({this.toggleView});
  final Function toggleView;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuthStatus>(context);
    return user.status == Status.Authenticating ? LaunchScreen() : Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 9),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    'Hello',
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 11.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Sign in to your account',
                    style: TextStyle(
                        fontSize: SizeConfig.textMultiplier * 2.0,
                        letterSpacing: 2),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 11.9),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      UserEmailInput(
                        controller: _emailController,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 4,
                      ),
                      UserPasswordInput(
                        icon: Icons.lock_outline,
                        controller: _passwordController,
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 1.5,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () {
                            print('tap');
                            toggleView(Screen.Reset);
                          },
                          padding: EdgeInsets.all(0.0),
                          child: Text('Forgot your password?'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizeConfig.widthMultiplier * 11.9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerRight,
                      child: RoundedRectangleButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            var x = await user.signIn( _emailController.text, _passwordController.text);
                            if(x != true) {
                              errorHandle(context, x, 'Error');
                            }
                          }
                          _emailController.clear();
                          _passwordController.clear();
                        },
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 8,
                    ),
                    Row(
                      textBaseline: TextBaseline.alphabetic,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        StartScreenBottomButton(
                          label: 'Sign up',
                          borderColor: Colors.white,
                          onPressed: () {
                            toggleView(Screen.Register);
                          },
                        ),
                        StartScreenBottomButton(
                          label: 'Login',
                          borderColor: Colors.black,
                          onPressed: () {
                            print('jesteś w tym ekranie');
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
