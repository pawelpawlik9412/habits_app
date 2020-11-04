import 'package:flutter/material.dart';
import 'package:habitsapp/size_config.dart';

class UserNameFieldEditMode extends StatefulWidget {
  UserNameFieldEditMode({@required this.controller, @required this.userName});

  final TextEditingController controller;
  final String userName;

  @override
  _UserNameFieldEditModeState createState() => _UserNameFieldEditModeState();
}

class _UserNameFieldEditModeState extends State<UserNameFieldEditMode> {
  @override
  void initState() {
    super.initState();
    widget.controller.text = widget.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 15,
      padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 5),
      child: Column(
        children: <Widget>[
          Text(
            'User name',
            style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier,
          ),
          TextField(
            controller: widget.controller,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 2.8),
            ),
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: SizeConfig.textMultiplier * 2,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
