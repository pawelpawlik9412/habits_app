import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitsapp/size_config.dart';



class HabitLabelTag extends StatelessWidget {

  HabitLabelTag({this.tagId, @required this.tagLabel, @required this.tagColor});

  final String tagId;
  final String tagLabel;
  final Color tagColor;


  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: SizeConfig.widthMultiplier * 15,
        minHeight: SizeConfig.heightMultiplier * 4.5,
      ),
      padding: EdgeInsets.only(
          right: SizeConfig.widthMultiplier * 2,
      ),
      child: Container(
          decoration: BoxDecoration(
            color: tagColor,
            borderRadius: BorderRadius.circular(20.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 5.0, vertical: SizeConfig.heightMultiplier * 0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(tagLabel, style: TextStyle(
                color: Colors.white,
                fontSize: SizeConfig.textMultiplier * 1.6,
                fontFamily: 'Open Sans',
              ),),
            ],
          )
    ),
    );
  }
}
