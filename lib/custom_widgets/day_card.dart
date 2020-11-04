import 'package:flutter/material.dart';
import 'package:habitsapp/size_config.dart';
import 'package:provider/provider.dart';
import 'package:habitsapp/providers/preferences_data.dart';

class DayCard extends StatelessWidget {
  DayCard({
    @required this.fullDate,
    @required this.label,
  });

  final String label;
  final String fullDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<PreferencesData>(context, listen:  false).setCalendarDatePreferences(fullDate);
      },
      child: Container(
        padding: EdgeInsets.only(right: SizeConfig.widthMultiplier * 6.2),
        child: FutureBuilder(
          future: Provider.of<PreferencesData>(context).checkIfIsSelected(fullDate),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.hasData) {
              return Text(
                label,
                style: TextStyle(
                  color: snapshot.data ? Color(0xFF79B197) : Color(0xFFC7C7C7),
                  fontSize: SizeConfig.textMultiplier * 2,
                  fontWeight: FontWeight.w600,
                ),
              );
            } else {
              return Text(
                label,
                style: TextStyle(
                  color: Color(0xFFC7C7C7),
                  fontSize: SizeConfig.textMultiplier * 2,
                  fontWeight: FontWeight.w600,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
