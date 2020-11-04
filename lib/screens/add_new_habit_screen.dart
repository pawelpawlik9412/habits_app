import 'package:flutter/material.dart';
import 'package:habitsapp/custom_widgets/card_task_list_view.dart';
import 'package:habitsapp/custom_widgets/error_alert_dialog.dart';
import 'package:habitsapp/model/habit.dart';
import 'package:habitsapp/model/habit_tag.dart';
import 'package:habitsapp/providers/habits_data.dart';
import 'package:habitsapp/providers/preferences_data.dart';
import 'package:habitsapp/size_config.dart';
import 'package:provider/provider.dart';
import 'package:habitsapp/providers/habit_tag_data.dart';
import 'package:habitsapp/providers/user_auth_status.dart';
import 'package:habitsapp/custom_widgets/habit_label_tag.dart';

class AddNewHabitScreen extends StatefulWidget {

  @override
  _AddNewHabitScreenState createState() => _AddNewHabitScreenState();
}

class _AddNewHabitScreenState extends State<AddNewHabitScreen> {
  String habitTask = '';
  HabitTag newHabit;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserAuthStatus>(context).user;
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'New Habit Name',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: SizeConfig.textMultiplier * 1.7,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Open Sans',
                      ),
                    ),
                    TextField(
                      maxLength: 120,
                      onChanged: (value) {
                        setState(() {
                          habitTask = value;
                        });
                      },
                    ),
                  ],
                ),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: <Widget>[
                   Text(
                     'Chose Tag',
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
                   Container(
                     height: SizeConfig.heightMultiplier * 4.5,
                     width: double.infinity,
                     constraints: BoxConstraints(
                       minWidth: SizeConfig.widthMultiplier * 15,
                       minHeight: SizeConfig.heightMultiplier * 4.5,
                     ),
                     child: FutureBuilder(
                       future:
                       Provider.of<HabitTagData>(context).listOfTags(user.uid),
                       builder: (BuildContext context, AsyncSnapshot snapshot) {
                         if (snapshot.hasData) {
                           var list = snapshot.data;
                           return ListView.builder(
                               itemCount: list.length,
                               scrollDirection: Axis.horizontal,
                               itemBuilder: (BuildContext context, int index) {
                                 return GestureDetector(
                                   onTap: () {
                                     Provider.of<PreferencesData>(context,
                                         listen: false)
                                         .setSelectedHabitTag(
                                         list[index][0]);
                                   },
                                   child: Container(
                                     padding: EdgeInsets.all(1.0),
                                     child: HabitLabelTag(
                                       tagId: list[index][0],
                                       tagLabel: list[index][1].tagLabel,
                                       tagColor: Color(list[index][1].tagColor),
                                     ),
                                   ),
                                 );
                               });
                         } else {
                           return Container();
                         }
                       },
                     ),
                   ),
                 ],
               ),
                Column(
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
                    FutureBuilder(
                      future: Provider.of<HabitTagData>(context).getTagDetail(context, user.uid),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        HabitTag tag = snapshot.data;
                        newHabit = tag;
                        if(snapshot.hasData) {
                          return CardTaskListView(habitId: null, label: habitTask, color: Color(tag.tagColor), tagName: tag.tagLabel, done: false, onChangedCheckBox: null,);
                        } else {
                          return CardTaskListView(habitId: null, label: '', color: Colors.white, tagName: '', done: false, onChangedCheckBox: null,);

                        }
                      },
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: FutureBuilder(
                    future: Provider.of<PreferencesData>(context, listen: false).getSelectedHabitTag(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if(snapshot.hasData) {
                        return FlatButton(
                          onPressed: () async {
                            String date = await Provider.of<PreferencesData>(context, listen: false).getCalendarDatePreferences();
                            Provider.of<HabitsData>(context, listen: false).addNewHabitForChosenDay(context, Habit(date: date, done: false, label: habitTask, tagColor: newHabit.tagColor, tagId: snapshot.data, tagName: newHabit.tagLabel ), user.uid);
                            Provider.of<PreferencesData>(context, listen: false).setSelectedHabitTag(null);
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(SizeConfig.heightMultiplier * 1.5),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular((20.0))),
                            child: Text(
                              'Add habit',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.7,
                                  color: Colors.white),
                            ),
                          ),
                        );
                      }
                      else {
                        return FlatButton(
                          onPressed: () {
                            errorHandle(context, 'To create a new task, select the habit tag.', 'There is no selected tag.');
                            Provider.of<PreferencesData>(context, listen: false).setSelectedHabitTag(null);
                          },
                          child: Container(
                            padding: EdgeInsets.all(SizeConfig.heightMultiplier * 1.5),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular((20.0))),
                            child: Text(
                              'Add habit',
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier * 1.7,
                                  color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
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
