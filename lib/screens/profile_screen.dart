import 'package:flutter/material.dart';

import 'package:habitsapp/size_config.dart';
import 'package:provider/provider.dart';

import 'package:habitsapp/providers/user_auth_status.dart';
import 'package:habitsapp/providers/users_data.dart';

import 'package:habitsapp/screens/launch_screen.dart';

import 'package:habitsapp/custom_widgets/profile_data_field.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({this.toggleView});

  final Function toggleView;
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserAuthStatus>(context).user;
    return StreamBuilder(
        stream: Provider.of<UsersData>(context).getUserDetail(user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userData = snapshot.data;
            return Scaffold(
              body: SafeArea(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              left: SizeConfig.widthMultiplier * 3.0,
                            ),
                            child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: SizeConfig.textMultiplier * 3.0,
                                ),
                                color: Colors.black,
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              right: SizeConfig.widthMultiplier * 3.0,
                            ),
                            child: IconButton(
                                icon: Icon(
                                  Icons.mode_edit,
                                  size: SizeConfig.textMultiplier * 3.0,
                                ),
                                color: Colors.black,
                                onPressed: () {
                                  toggleView(true);
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 5,
                      ),
                      Hero(
                        tag: 'profileImage',
                        child: userData['photoUrl'] == null
                            ? CircleAvatar(
                                radius: SizeConfig.textMultiplier * 9.4,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    AssetImage('images/noPhotoUser.jpg'),
                              )
                            : CircleAvatar(
                                radius: SizeConfig.textMultiplier * 9.4,
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(userData['photoUrl']),
                              ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 4,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.widthMultiplier * 5),
                        child: Divider(
                          thickness: 2.0,
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 6,
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              ProfileDataField(
                                fieldName: 'User name',
                                fieldValue: userData['name'],
                              ),
                              ProfileDataField(
                                fieldName: 'Email adress',
                                fieldValue: userData['email'],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return LaunchScreen();
          }
        });
  }
}
