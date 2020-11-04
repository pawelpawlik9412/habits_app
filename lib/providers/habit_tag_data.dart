import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:habitsapp/model/habit_tag.dart';
import 'package:habitsapp/providers/preferences_data.dart';

import 'package:habitsapp/services/firestore_services.dart';
import 'package:provider/provider.dart';

class HabitTagData extends ChangeNotifier {
  FirestoreServices _firestoreServices = FirestoreServices();

  Color _colorChosenForTagWidget;

  get colorChosenForTagWidget => _colorChosenForTagWidget;

  setChosenCololor(Color color) {
    _colorChosenForTagWidget = color;
  }

  void addHabitTagToFirebase(
    HabitTag habitTag,
    String userId,
    String habitTagName,
  ) {
    _firestoreServices.addTag(habitTag, userId, habitTagName);
    notifyListeners();
  }

  Future<List<List>> listOfTags(String userId) async {
    List<DocumentSnapshot> documents =
        await _firestoreServices.getListOfTags(userId);
    List<List> result = [];
    for (var i in documents) {
      result.add([i.documentID, HabitTag.fromFirestore(i.data)]);
    }
    return result;
  }

  Future<HabitTag> getTagDetail(BuildContext context, String userId) async {
    String tagId = await Provider.of<PreferencesData>(context).getSelectedHabitTag();
    DocumentSnapshot x = await _firestoreServices.getTagDetail(userId, tagId);
    HabitTag result = HabitTag.fromFirestore(x.data);
    return result;
  }

  void deleteChosenTag(String userId, String documentTagId) {
    _firestoreServices.deleteChosenTag(userId, documentTagId);
    notifyListeners();
  }

}
