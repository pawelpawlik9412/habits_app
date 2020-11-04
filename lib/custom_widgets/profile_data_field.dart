import 'package:flutter/material.dart';
import 'package:habitsapp/size_config.dart';

class ProfileDataField extends StatelessWidget {

  ProfileDataField({@required this.fieldName, @required this.fieldValue});

  final String fieldName;
  final String fieldValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 15,
      padding: EdgeInsets.only(bottom: SizeConfig.heightMultiplier * 5),
      child: Column(
        children: <Widget>[
          Text(
            fieldName,
            style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: SizeConfig.textMultiplier * 2.5,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: SizeConfig.heightMultiplier,
          ),
          Text(
            fieldValue,
            style: TextStyle(
              fontFamily: 'Open Sans',
              fontSize: SizeConfig.textMultiplier * 2, color: Colors.grey,),
          ),
        ],
      ),
    );
  }
}
