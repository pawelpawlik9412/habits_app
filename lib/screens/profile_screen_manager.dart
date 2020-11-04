import 'package:flutter/material.dart';

import 'package:habitsapp/screens/profile_screen.dart';
import 'package:habitsapp/screens/profile_screen_edit_mode.dart';


class ProfileScreenManager extends StatefulWidget {
  @override
  _ProfileScreenManagerState createState() => _ProfileScreenManagerState();
}

class _ProfileScreenManagerState extends State<ProfileScreenManager> {

  bool edit = false;

  void toggleView(bool mode){
    setState(() {
      edit = mode;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(edit == false) {
      return ProfileScreen(toggleView: toggleView,);
    } else {
      return ProfileScreenEditMode(toggleView: toggleView);
    }
  }
}
