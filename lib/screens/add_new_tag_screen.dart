import 'package:flutter/material.dart';
import 'package:habitsapp/model/habit_tag.dart';
import 'package:habitsapp/providers/habit_tag_data.dart';
import 'package:habitsapp/providers/user_auth_status.dart';
import 'package:habitsapp/size_config.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter/cupertino.dart';

import 'package:habitsapp/custom_widgets/custom_color_picker.dart';
import 'package:provider/provider.dart';


class AddNewTagScreen extends StatefulWidget {

  @override
  _AddNewTagScreenState createState() => _AddNewTagScreenState();
}

class _AddNewTagScreenState extends State<AddNewTagScreen> {
  TextEditingController _tagController = TextEditingController();

  String nameOfTag = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xff757575),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          height: SizeConfig.heightMultiplier * 72,
          child: Container(
            padding: EdgeInsets.only(
                top: SizeConfig.heightMultiplier * 5,
                left: SizeConfig.widthMultiplier * 5,
                right: SizeConfig.widthMultiplier * 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'New Tag Habit Name',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.textMultiplier * 1.7,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                    TextField(
                      maxLength: 25,
                      controller: _tagController,
                      onChanged: (value) {
                        setState(() {
                          nameOfTag = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightMultiplier * 2,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Color Settings',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.textMultiplier * 1.7,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.heightMultiplier * 4,
                    ),
                    CustomColorPicker(
                      paletteType: PaletteType.hsv,
                      onColorChanged: (value) {},
                      textFieldValue: nameOfTag,
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: FlatButton(
                    onPressed: () {
                      var tagColor = Provider.of<HabitTagData>(context, listen: false).colorChosenForTagWidget;
                      var user = Provider.of<UserAuthStatus>(context, listen: false).user.uid;
                      Provider.of<HabitTagData>(context, listen: false).addHabitTagToFirebase(HabitTag(tagColor: tagColor.value, tagLabel: nameOfTag), user, nameOfTag);
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.all(SizeConfig.heightMultiplier * 1.5),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular((20.0))),
                      child: Text(
                        'Add tag',
                        style: TextStyle(
                            fontSize: SizeConfig.textMultiplier * 1.7,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
