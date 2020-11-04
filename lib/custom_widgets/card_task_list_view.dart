import 'package:flutter/material.dart';
import 'package:habitsapp/size_config.dart';

class CardTaskListView extends StatelessWidget {
  CardTaskListView(
      {@required this.habitId,
      @required this.label,
        @required this.tagName,
      @required this.color,
      @required this.done,
        @required this.onChangedCheckBox,
      });

  final String habitId;
  final String label;
  final String tagName;
  final Color color;
  final bool done;
  final Function onChangedCheckBox;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.heightMultiplier, horizontal: SizeConfig.widthMultiplier),
      child: Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: SizeConfig.heightMultiplier * 10.5,
          ),
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.heightMultiplier * 2.0,
            horizontal: SizeConfig.widthMultiplier * 2
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
            color: Color(0xFFF4F4F4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                flex: 10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          tagName,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            letterSpacing: 1.2,
                            wordSpacing: 1.1,
                            color: color,
                            fontWeight: FontWeight.w800,
                            fontSize: SizeConfig.textMultiplier * 1.5,
                            fontFamily: 'Open Sans',
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 0.1,
                    ),
                    Text(
                      label,
                      style: TextStyle(
                        letterSpacing: 1.2,
                        wordSpacing: 1.1,
                        color: color,
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.textMultiplier * 2.5,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Checkbox(
                    onChanged: onChangedCheckBox,
                    value: done,
                    activeColor: color,
                  )),
            ],
          )),
    );
  }
}