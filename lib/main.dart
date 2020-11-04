import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'size_config.dart';

import 'package:habitsapp/screens/wrapper_screen.dart';

import 'package:habitsapp/providers/user_auth_status.dart';
import 'package:habitsapp/providers/preferences_data.dart';
import 'package:habitsapp/providers/users_data.dart';
import 'package:habitsapp/providers/habits_data.dart';
import 'package:habitsapp/providers/habit_tag_data.dart';

void main() {
  runApp(HabitApp());
}

class HabitApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserAuthStatus.instance(),
        ),
        ChangeNotifierProvider(
          create: (_) => UsersData(),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitsData(),
        ),
        ChangeNotifierProvider(
          create: (_) => HabitTagData(),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LayoutBuilder(builder: (context, constraints) {
          return OrientationBuilder(builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return WrapperScreen();
          });
        }),
      ),
    );
  }
}
