import 'package:flutter/material.dart';
import 'package:habitsapp/providers/user_auth_status.dart';
import 'package:habitsapp/providers/users_data.dart';
import 'package:habitsapp/size_config.dart';
import 'package:provider/provider.dart';
import 'package:habitsapp/enum.dart';
import 'package:habitsapp/model/user.dart';

import 'package:habitsapp/screens/launch_screen.dart';

import 'package:habitsapp/custom_widgets/user_name_input.dart';
import 'package:habitsapp/custom_widgets/user_email_input.dart';
import 'package:habitsapp/custom_widgets/user_password_input.dart';

import 'package:habitsapp/custom_widgets/rounded_rectangle_button.dart';
import 'package:habitsapp/custom_widgets/start_screen_bottom_button.dart';

import 'package:habitsapp/custom_widgets/error_alert_dialog.dart';
import 'package:flutter/cupertino.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({this.toggleView});
  final Function toggleView;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserAuthStatus>(context);
    return user.status == Status.Authenticating
        ? LaunchScreen()
        : Scaffold(
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.only(top: SizeConfig.heightMultiplier * 15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Create account',
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 3.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 11.9),
                        child: Column(
                          children: <Widget>[
                            UserNameInput(
                              controller: _nameController,
                            ),
                            SizedBox(
                              height: SizeConfig.heightMultiplier * 4,
                            ),
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
                              height: SizeConfig.heightMultiplier * 4,
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
                                    var x =
                                        await user.registerWithEmailAndPassword(
                                            _emailController.text,
                                            _passwordController.text,
                                            _nameController.text);
                                    if (x != true) {
                                      errorHandle(context, x, 'Error');
                                    } else {
                                      Provider.of<UsersData>(context,
                                              listen: false)
                                          .addNewUser(
                                              User(
                                                  uid: user.user.uid,
                                                  email: user.user.email,
                                                  name: _nameController.text),
                                              user.user.uid);
                                    }
                                  }
                                  _emailController.clear();
                                  _passwordController.clear();
                                  _nameController.clear();
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
                                  borderColor: Colors.black,
                                  onPressed: () {
                                    print('jesteś w tym ekranie');
                                  },
                                ),
                                StartScreenBottomButton(
                                  label: 'Login',
                                  borderColor: Colors.white,
                                  onPressed: () {
                                    widget.toggleView(Screen.Login);
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
