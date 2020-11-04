import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:habitsapp/providers/user_auth_status.dart';
import 'package:habitsapp/services/firestore_services.dart';
import 'package:provider/provider.dart';

import 'package:habitsapp/model/habit.dart';

import 'package:habitsapp/providers/preferences_data.dart';

class HabitsData extends ChangeNotifier {

  FirestoreServices _firestoreServices = FirestoreServices();

  void addNewHabitForChosenDay(BuildContext context, Habit habit, String userId) async {
    _firestoreServices.addNewHabitForChosenDay(habit, userId);
    notifyListeners();
  }
  
  void deleteHabitForChosenDay(BuildContext context, String currentUserId, String habitId) async {
    String chosenDate = await Provider.of<PreferencesData>(context, listen: false).getCalendarDatePreferences();
    _firestoreServices.deleteHabitForChosenDay(currentUserId, chosenDate, habitId);
    notifyListeners();
  }


  Future<int> getNumberOfHabitsForChosenDay(BuildContext context, String currentUserId) async {
    String chosenDate = await Provider.of<PreferencesData>(context).getCalendarDatePreferences();
    int numberOfHabits = await _firestoreServices.getNumberOfHabitsForChosenDay(chosenDate, currentUserId);
    return numberOfHabits;

  }

  Stream<QuerySnapshot> getListOfHabitsForChosen(BuildContext context, String currentUserId, String chosenDate) {
    var x = _firestoreServices.getListOfHabitsForChosenDay(currentUserId, chosenDate);
    return x;
  }

  Future<void> udpateHabitDone(BuildContext context, bool done, String habitId) async {
    String currentUserId = Provider.of<UserAuthStatus>(context, listen: false).user.uid;
    String chosenDate = await Provider.of<PreferencesData>(context, listen: false).getCalendarDatePreferences();
    _firestoreServices.updateHabitDone(chosenDate, currentUserId, done, habitId);
    notifyListeners();
  }
  

  Future<void> deleteHabitsByDeleteTag(String userId, String documentTagId) async {
    List listHabitsToDelete = await getListOfHabitsToDeleteByTag(userId, documentTagId);
    _firestoreServices.deleteHabitsByDocumentId(userId, documentTagId, listHabitsToDelete);
    notifyListeners();
  }

  Future<List> getListOfHabitsToDeleteByTag(String userId, String documentTagId) {
    var result = _firestoreServices.getHabitsWithDeletedTagId(userId, documentTagId);
    return result;
  }


}