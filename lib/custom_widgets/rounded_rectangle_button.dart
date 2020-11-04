import 'package:flutter/material.dart';
import 'package:habitsapp/size_config.dart';

class RoundedRectangleButton extends StatelessWidget {
  RoundedRectangleButton({@required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Color(0xFF40444E),
      child: Icon(
        Icons.arrow_forward,
        color: Colors.white,
        size: SizeConfig.textMultiplier * 3.5,
      ),
      padding: EdgeInsets.all(25.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    );
  }
}
