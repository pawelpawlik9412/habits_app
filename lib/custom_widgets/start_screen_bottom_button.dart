import 'package:flutter/material.dart';
import 'package:habitsapp/size_config.dart';

class StartScreenBottomButton extends StatelessWidget {
  StartScreenBottomButton(
      {@required this.borderColor,
      @required this.label,
      @required this.onPressed});

  final Color borderColor;
  final String label;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      padding: EdgeInsets.all(0.0),
      child: Container(
        padding: EdgeInsets.only(
          bottom: SizeConfig.heightMultiplier,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: borderColor,
              width: 1.0,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(),
        ),
      ),
    );
  }
}
