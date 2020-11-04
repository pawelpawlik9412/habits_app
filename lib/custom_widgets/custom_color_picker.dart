import 'package:flutter/material.dart';
import 'package:habitsapp/providers/habit_tag_data.dart';
import 'package:habitsapp/size_config.dart';

import 'package:habitsapp/custom_widgets/habit_label_tag.dart';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';



class CustomColorPicker extends StatefulWidget {
  CustomColorPicker(
      {this.paletteType, this.onColorChanged, this.textFieldValue});

  String textFieldValue;
  PaletteType paletteType;
  Function onColorChanged;

  @override
  _CustomColorPickerState createState() => _CustomColorPickerState();
}

class _CustomColorPickerState extends State<CustomColorPicker> {

  HSVColor _currentHsvColor = HSVColor.fromColor(Colors.green);



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: SizeConfig.widthMultiplier * 70,
          height: SizeConfig.heightMultiplier * 15,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: ColorPickerArea(
              _currentHsvColor,
                  (HSVColor color) {
                setState(() => _currentHsvColor = color);
                widget.onColorChanged(_currentHsvColor.toColor());
                Provider.of<HabitTagData>(context, listen: false).setChosenCololor(_currentHsvColor.toColor());
              },
              widget.paletteType,
            ),
          ),
        ),
        Container(
          width: SizeConfig.widthMultiplier * 70,
          height: SizeConfig.heightMultiplier * 6,
          child: ColorPickerSlider(
            TrackType.hue,
            _currentHsvColor,
                (value) {
              setState(() {
                _currentHsvColor = value;
                Provider.of<HabitTagData>(context, listen: false).setChosenCololor(_currentHsvColor.toColor());
              });
            },
            fullThumbColor: true,
          ),
        ),
        Container(
          width: SizeConfig.widthMultiplier * 70,
          height: SizeConfig.heightMultiplier * 6,
          child: ColorPickerSlider(
            TrackType.alpha,
            _currentHsvColor,
                (value) {
              setState(() {
                _currentHsvColor = value;
                Provider.of<HabitTagData>(context, listen: false).setChosenCololor(_currentHsvColor.toColor());
              });
            },
            fullThumbColor: true,
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Preview',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: SizeConfig.textMultiplier * 1.7,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'Open Sans',
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 2,
              ),
              HabitLabelTag(
                tagColor: _currentHsvColor.toColor(),
                tagLabel: widget.textFieldValue,
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
