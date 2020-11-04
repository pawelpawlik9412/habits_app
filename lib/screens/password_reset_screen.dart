import 'package:flutter/material.dart';
import 'package:habitsapp/size_config.dart';
import 'package:habitsapp/enum.dart';
import 'package:provider/provider.dart';
import 'package:habitsapp/providers/user_auth_status.dart';

import 'package:habitsapp/custom_widgets/user_email_input.dart';

import 'package:habitsapp/custom_widgets/rounded_rectangle_button.dart';
import 'package:habitsapp/custom_widgets/start_screen_bottom_button.dart';

import 'package:habitsapp/custom_widgets/error_alert_dialog.dart';

class PasswordResetScreen extends StatelessWidget {
  PasswordResetScreen({this.toggleView});
  final Function toggleView;

  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuthStatus>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Reset your password',
                  style: TextStyle(
                      fontSize: SizeConfig.textMultiplier * 3.0,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.widthMultiplier * 11.9,
                      right: SizeConfig.widthMultiplier * 11.9,
                      bottom: SizeConfig.heightMultiplier * 25.0),
                  child: Column(
                    children: <Widget>[
                      UserEmailInput(
                        controller: _emailController,
                      ),
                    ],
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
                              var x = await user
                                  .passwordReset(_emailController.text);
                              if (x != true) {
                                errorHandle(context, x, 'Error');
                              }
                            }
                            _emailController.clear();
                            toggleView(Screen.Login);
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
                            borderColor: Colors.white,
                            onPressed: () {
                              toggleView(Screen.Login);
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
      ),
    );
  }
}
