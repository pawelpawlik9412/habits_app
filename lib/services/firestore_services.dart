import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:habitsapp/model/user.dart';
import 'package:habitsapp/model/habit.dart';
import 'package:habitsapp/model/habit_tag.dart';

class FirestoreServices {
  Firestore _db = Firestore.instance;

  String usersCollections = 'Users';
  String habitsCollections = 'Habits';
  String tagHabitsCollections = 'Tags';
  String dateCollections = 'Date';

  // Method for Users collection

  void saveNewUser(User user, String userId) {
    _db.collection(usersCollections).document(userId).setData(user.toMap());
  }

  Stream<DocumentSnapshot> getUserDetail(String userId) {
    return _db.collection(usersCollections).document(userId).snapshots();
  }

  Future<void> updateUserDetail(
      String userId, String newUserPhotoUrl, String newUserName) async {
    _db
        .collection(usersCollections)
        .document(userId)
        .updateData({'photoUrl': newUserPhotoUrl, 'name': newUserName});
  }





  // Method for Habits collection

  void addNewHabitForChosenDay(Habit habit, String userId) {
    _db
        .collection(habitsCollections)
        .document(userId)
        .collection(dateCollections)
        .add(habit.toMap());
  }

  Future<int> getNumberOfHabitsForChosenDay(
    String chosenDate,
    String currentUserId,
  ) async {
    var list = await _db
        .collection(habitsCollections)
        .document(currentUserId)
        .collection(dateCollections)
        .where('date', isEqualTo: chosenDate)
        .getDocuments();
    return list.documents.length;
  }


  Stream<QuerySnapshot> getListOfHabitsForChosenDay(String currentUserId, String chosenDate) {
    var x = _db
        .collection(habitsCollections)
        .document(currentUserId)
        .collection(dateCollections)
        .where('date', isEqualTo: chosenDate).snapshots();
    return x;
  }

  void deleteHabitForChosenDay(
      String currentUserId, String chosenDate, String habitId) {
    _db
        .collection(habitsCollections)
        .document(currentUserId)
        .collection(dateCollections)
        .document(habitId)
        .delete();
  }

  void updateHabitDone(
      String chosenDate, String currentUserId, bool done, habitId) {
    _db
        .collection(habitsCollections)
        .document(currentUserId)
        .collection(dateCollections)
        .document(habitId)
        .updateData({'done': done});
  }

  Future<List> getHabitsWithDeletedTagId(String userId, String documentTagId) async {
    var x = await _db
        .collection(habitsCollections)
        .document(userId)
        .collection(dateCollections)
        .where('tagId', isEqualTo: documentTagId)
        .getDocuments();

    List list = [];
    for(var y in x.documents) {
      list.add(y.documentID);
    }
    return list;
  }


  void deleteHabitsByDocumentId(String userId, String documentTagId, List habitsListToDelete) async {
    for(var x in habitsListToDelete) {
      _db.collection(habitsCollections).document(userId).collection(dateCollections).document(x).delete();
    }
  }





  // Method for Tags collection

  void addTag(HabitTag habitTag, String userId, String habitTagName) {
    _db
        .collection(tagHabitsCollections)
        .document(userId)
        .collection(userId)
        .add(habitTag.toMap());
  }

  Future<List> getListOfTags(String userId) async {
    QuerySnapshot result = await _db
        .collection(tagHabitsCollections)
        .document(userId)
        .collection(userId)
        .getDocuments();
    List list = result.documents;
    return list;
  }

  Future<DocumentSnapshot> getTagDetail(String userId, String tagId) async {
    var result = await _db
        .collection(tagHabitsCollections)
        .document(userId)
        .collection(userId)
        .document(tagId)
        .get();
    return result;
  }

  void deleteChosenTag(String userId, String documentTagId) async {
    await _db
        .collection(tagHabitsCollections)
        .document(userId)
        .collection(userId)
        .document(documentTagId)
        .delete();
  }
}
