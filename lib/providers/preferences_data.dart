import 'package:flutter/material.dart';
import 'package:habitsapp/model/shared_pref.dart';
import 'package:habitsapp/calendar_data.dart';

class PreferencesData extends ChangeNotifier {


  final SharedPref _sharedPrefCalendarData = SharedPref(instanceName: 'selectedCalendarCard', deflautValue: CalendarData.getFormatDate(CalendarData.getCurrentDay()),);
  final SharedPref _chosenPrefTagData = SharedPref(instanceName: 'selectedHabitTag', deflautValue: null);



  Future<String> getCalendarDatePreferences() async {
    var x = await _sharedPrefCalendarData.read();
    return x;
  }
  Future<bool> checkIfIsSelected(String fullDate) async {
    var x = await getCalendarDatePreferences();
    if(x == fullDate) {
      return true;
    } else {
      return false;
    }
  }
  void setCalendarDatePreferences(String fullDate) {
    _sharedPrefCalendarData.save(fullDate);
    notifyListeners();
  }
  Future<String> getSelectedHabitTag() async {
    var x = await _chosenPrefTagData.read();
    return x;
  }

  void setSelectedHabitTag(String tagId) {
    _chosenPrefTagData.save(tagId);
    notifyListeners();
  }






}