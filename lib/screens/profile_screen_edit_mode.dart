import 'package:flutter/material.dart';
import 'package:habitsapp/providers/users_data.dart';
import 'package:habitsapp/screens/launch_screen.dart';
import 'package:provider/provider.dart';
import 'package:habitsapp/size_config.dart';

import 'package:habitsapp/custom_widgets/profile_data_field.dart';
import 'package:habitsapp/custom_widgets/user_name_field_edit_mode.dart';

import 'package:habitsapp/providers/user_auth_status.dart';

class ProfileScreenEditMode extends StatefulWidget {
  ProfileScreenEditMode({this.toggleView});

  final Function toggleView;

  @override
  _ProfileScreenEditModeState createState() => _ProfileScreenEditModeState();
}

class _ProfileScreenEditModeState extends State<ProfileScreenEditMode> {
  TextEditingController _nameController = TextEditingController();

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
                                left: SizeConfig.widthMultiplier * 3.0),
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: SizeConfig.textMultiplier * 3.0,
                              ),
                              color: Colors.black,
                              onPressed: () {
//                                Provider.of<ImageData>(context, listen:  false).setChosenPhotoFromGalleryToNull();
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                right: SizeConfig.widthMultiplier * 3.0),
                            child: IconButton(
                                icon: Icon(
                                  Icons.save,
                                  size: SizeConfig.textMultiplier * 3.0,
                                ),
                                color: Colors.black,
                                onPressed: () {
                                  Provider.of<UsersData>(context, listen: false)
                                      .updateUserProfile(
                                          user.uid, _nameController.text);
                                  Navigator.pop(context);
                                  //TODO zapisanie wybranego zdjęcia do storage i konkretnego użytkownia, zapisanie nowego imienia jeśli się zmieniło ustawienie chosenPhoto na null i toggleView na false
                                }),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 5,
                      ),
                      Hero(
                        tag: 'profileImage',
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<UsersData>(context, listen: false)
                                .getImageFromGallery();
                          },
                          child: CircleAvatar(
                                    radius: SizeConfig.textMultiplier * 9.4,
                                    backgroundColor: Colors.white,
                                    backgroundImage: Provider.of<UsersData>(context).showPhotoForProfileEditMode(userData['photoUrl']),
                                  ),

//                          FutureBuilder(
//                            future: Provider.of<UsersData>(context).showPhotoForProfileEditMode(userData['photoUrl']),
//                            builder: (BuildContext context, AsyncSnapshot snapshot) {
//                              if(snapshot.hasData) {
//                                if(snapshot.data == UserPhoto.FirebasePhoto) {
//                                  return CircleAvatar(
//                                    radius: SizeConfig.textMultiplier * 9.4,
//                                    backgroundColor: Colors.white,
//                                    backgroundImage: NetworkImage(userData['photoUrl']),
//                                  );
//                                }
//                                else if(snapshot.data == UserPhoto.GalleryPhoto) {
//                                  return CircleAvatar(
//                                    radius: SizeConfig.textMultiplier * 9.4,
//                                    backgroundColor: Colors.white,
//                                    backgroundImage: AssetImage(Provider.of<UsersData>(context).chosenPhoto),
//                                  );
//                                }
//                                else {
//                                  return CircleAvatar(
//                                    radius: SizeConfig.textMultiplier * 9.4,
//                                    backgroundColor: Colors.white,
//                                    backgroundImage: AssetImage('images/noPhotoUser.jpg'),
//                                  );
//                                }
//                              }
//                              else {
//                                return CircleAvatar(
//                                  radius: SizeConfig.textMultiplier * 9.4,
//                                  backgroundColor: Colors.white,
//                                  backgroundImage: AssetImage('images/noPhotoUser.jpg'),
//                                );
//                              }
//                            },
//                          ),
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
                              UserNameFieldEditMode(
                                controller: _nameController,
                                userName: userData['name'],
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
