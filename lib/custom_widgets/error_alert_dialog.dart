import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:habitsapp/size_config.dart';

Future<void> errorHandle(BuildContext context, String error, String errorTitle) async {
  return showCupertinoDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          errorTitle,
          style: TextStyle(
              fontSize: SizeConfig.heightMultiplier * 2,
              fontWeight: FontWeight.w600),
        ),
        content: Container(
          padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
          child: Text(error),
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
