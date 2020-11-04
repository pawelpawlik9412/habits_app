
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:habitsapp/model/habit.dart';
import 'package:habitsapp/providers/habit_tag_data.dart';
import 'package:habitsapp/providers/preferences_data.dart';
import 'package:habitsapp/screens/add_new_habit_screen.dart';

import 'package:provider/provider.dart';
import 'package:habitsapp/size_config.dart';

import 'package:habitsapp/calendar_data.dart';

import 'package:habitsapp/custom_widgets/day_card.dart';
import 'package:habitsapp/custom_widgets/habit_label_tag.dart';
import 'package:habitsapp/custom_widgets/card_task_list_view.dart';

import 'package:habitsapp/providers/user_auth_status.dart';
import 'package:habitsapp/providers/habits_data.dart';
import 'package:habitsapp/providers/users_data.dart';

import 'package:habitsapp/screens/profile_screen_manager.dart';
import 'package:habitsapp/screens/add_new_tag_screen.dart';

class HomeScreen extends StatelessWidget {


  List<List> getList(QuerySnapshot data) {
    List<List> list = [];
    for(var z in data.documents) {
      list.add([z.documentID, Habit.fromFirestore(z.data)]);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserAuthStatus>(context).user;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: SizeConfig.widthMultiplier * 5.0,
            right: SizeConfig.widthMultiplier * 5.0,
            top: SizeConfig.heightMultiplier * 2,
          ),
          child: Column(
            children: <Widget>[
              StreamBuilder(
                stream: Provider.of<UsersData>(context).getUserDetail(user.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var userData = snapshot.data;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Hi ${userData['name']}',
                              style: TextStyle(
                                fontSize: SizeConfig.textMultiplier * 3.2,
                                fontWeight: FontWeight.w800,
                                fontFamily: 'Open Sans',
                              ),
                            ),
                            FutureBuilder(
                              future: Provider.of<HabitsData>(context)
                                  .getNumberOfHabitsForChosenDay(
                                      context, user.uid),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    '${snapshot.data} task today',
                                    style: TextStyle(
                                      color: Color(0xFF79B197),
                                      fontSize: SizeConfig.textMultiplier * 1.7,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'Open Sans',
                                    ),
                                  );
                                } else {
                                  return Text('');
                                }
                              },
                            ),
                          ],
                        ),
                        Hero(
                          tag: 'profileImage',
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return ProfileScreenManager();
                                  },
                                ),
                              );
                            },
                            child: userData['photoUrl'] == null
                                ? CircleAvatar(
                                    radius: SizeConfig.textMultiplier * 2.4,
                                    backgroundColor: Colors.white,
                                    backgroundImage:
                                        AssetImage('images/noPhotoUser.jpg'),
                                  )
                                : CircleAvatar(
                                    radius: SizeConfig.textMultiplier * 2.4,
                                    backgroundColor: Colors.white,
                                    backgroundImage: NetworkImage(
                                      userData['photoUrl'],
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 3),
              Container(
                height: SizeConfig.heightMultiplier * 5,
                width: double.infinity,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.black,
                        size: SizeConfig.textMultiplier * 2.5,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SingleChildScrollView(
                            child: Container(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: AddNewTagScreen(),
                            ),
                          ),
                        );
                      },
                      padding: EdgeInsets.only(
                          right: SizeConfig.widthMultiplier * 4),
                    ),
                    Expanded(
                      child: FutureBuilder(
                        future:
                            Provider.of<HabitTagData>(context)
                                .listOfTags(user.uid),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            var list = snapshot.data;
                            return ListView.builder(
                              itemCount:  list.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return FocusedMenuHolder(
                                    menuWidth: MediaQuery.of(context).size.width*0.50,
                                    menuBoxDecoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                    menuItemExtent: 50.0,
                                    bottomOffsetHeight: 100,
                                    menuItems: [
                                      FocusedMenuItem(title: Text('Edit'), onPressed: () {
                                        //TODO możliwość edycji tagu habitu.
                                        }, trailingIcon: Icon(Icons.edit)),
                                      FocusedMenuItem(title: Text('Delete'), onPressed: () {
                                        Provider.of<HabitTagData>(context, listen: false).deleteChosenTag(user.uid, list[index][0]);
                                        Provider.of<HabitsData>(context, listen: false).deleteHabitsByDeleteTag(user.uid, list[index][0]);
                                      }, trailingIcon: Icon(Icons.delete)),
                                    ],
                                    child: HabitLabelTag(
                                      tagId: list[index][0],
                                      tagLabel: list[index][1].tagLabel,
                                      tagColor: Color(list[index][1].tagColor),
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
              ),
              SizedBox(height: SizeConfig.heightMultiplier * 3),
              Container(
                height: SizeConfig.heightMultiplier * 4,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: CalendarData.getNextDays(7).length,
                  itemBuilder: (BuildContext context, int index) {
                    var list = CalendarData.getNextDays(7);
                    return DayCard(
                      fullDate: list[index].fullDate,
                      label: CalendarData.stringDate(list[index]),
                    );
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.heightMultiplier * 5,
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: Provider.of<PreferencesData>(context).getCalendarDatePreferences(),
                    builder: (BuildContext context, AsyncSnapshot snapshoot) {
                      if(snapshoot.hasData) {
                        String chosenDate = snapshoot.data;
                        return StreamBuilder(
                          stream: Provider.of<HabitsData>(context).getListOfHabitsForChosen(context, user.uid, chosenDate),
                          builder: (BuildContext context, AsyncSnapshot snap) {
                            if(snap.hasData) {
                              List list = getList(snap.data);
                              return ListView.builder(
                                  itemCount: list.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Dismissible(
                                      key: Key(list[index][0]),
                                      direction: DismissDirection.endToStart,
                                      onDismissed: (direction) {
                                        try {
                                          Provider.of<HabitsData>(context,
                                              listen: false)
                                              .deleteHabitForChosenDay(
                                              context, user.uid, list[index][0]);
//                                          list.removeAt(index);
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: CardTaskListView(
                                        habitId: list[index][0],
                                        label: list[index][1].toMap()['label'],
                                        tagName: list[index][1].toMap()['tagName'],
                                        color: Color(list[index][1].toMap()['tagColor']),
                                        done: list[index][1].toMap()['done'],
                                        onChangedCheckBox: (value) {
                                          Provider.of<HabitsData>(context, listen: false).udpateHabitDone(context, value, list[index][0],);
                                        },
                                      ),
                                    );
                                  });
                            }
                            else {
                              return Container();
                            }
                          },
                        );
                      }
                      else {
                        return Container();
                      }
                    },
                  ),
//                  child: FutureBuilder(
//                    future: Provider.of<HabitsData>(context)
//                        .getListOfHabitsForChosen(context, user.uid),
//                    builder: (BuildContext context, AsyncSnapshot snapshot) {
//                      if (snapshot.hasData) {
//                        List list = snapshot.data;
//                        return ListView.builder(
//                            itemCount: list.length,
//                            itemBuilder: (BuildContext context, index) {
//                              return Dismissible(
//                                key: Key(list[index][0]),
//                                direction: DismissDirection.endToStart,
//                                onDismissed: (direction) {
//                                  try {
//                                    Provider.of<HabitsData>(context,
//                                            listen: false)
//                                        .deleteHabitForChosenDay(
//                                            context, user.uid, list[index][0]);
//                                    list.removeAt(index);
//                                  } catch (e) {
//                                    print(e);
//                                  }
//                                },
//                                child: CardTaskListView(
//                                  habitId: list[index][0],
//                                  label: list[index][1].toMap()['label'],
//                                  tagName: list[index][1].toMap()['tagName'],
//                                  color: Color(list[index][1].toMap()['tagColor']),
//                                  done: list[index][1].toMap()['done'],
//                                  onChangedCheckBox: (value) {
//                                    Provider.of<HabitsData>(context, listen: false).udpateHabitDone(context, value, list[index][0],);
//                                  },
//                                ),
//                              );
//                            });
//                      } else {
//                        return Container();
//                      }
//                    },
//                  ),
                ),
              ),
            ],
          ),
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        backgroundColor: Color(0xFF79B197),
//        child: Icon(Icons.add),
//      ),
//      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0.0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: SizeConfig.textMultiplier * 5,
              color: Color(0xFFC7C7C7),
            ),
            title: Container(
                padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
                child: Text(
                  'Home',
                  style: TextStyle(
                    color: Color(0xFFC7C7C7),
                  ),
                )),
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: Color(0xFF79B197),
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
                child: Icon(
                  Icons.add,
                  size: SizeConfig.textMultiplier * 4,
                  color: Colors.white,
                ),
              ),
            ),
            title: Container(
              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
              child: Text(
                '',
                style: TextStyle(
                  color: Color(0xFFC7C7C7),
                ),
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: SizeConfig.textMultiplier * 5,
              color: Color(0xFFC7C7C7),
            ),
            title: Container(
              padding: EdgeInsets.only(top: SizeConfig.heightMultiplier),
              child: Text(
                'Profile',
                style: TextStyle(
                  color: Color(0xFFC7C7C7),
                ),
              ),
            ),
          ),
        ],
        currentIndex: 0,
        onTap: (index) async {
          if (index == 0) {
            Provider.of<UserAuthStatus>(context, listen: false).signOut();
          }
          if (index == 1) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      bottom:
                      MediaQuery.of(context).viewInsets.bottom),
                  child: AddNewHabitScreen(),
                ),
              ),
            );
          }
          if (index == 2) {}
        },
      ),
    );
  }
}
