import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:habitsapp/services/firestore_services.dart';
import 'package:habitsapp/services/storage_services.dart';

import 'package:habitsapp/model/user.dart';

class UsersData extends ChangeNotifier {


  FirestoreServices _firestoreServices = FirestoreServices();

  void addNewUser(User user, String userId) {
    _firestoreServices.saveNewUser(user, userId);
  }

  Stream<DocumentSnapshot> getUserDetail(String userId) {
    return _firestoreServices.getUserDetail(userId);
  }

  void updateUserDetail(String userId, String newUserPhotoUrl, String newUserName) {
    _firestoreServices.updateUserDetail(userId, newUserPhotoUrl, newUserName);
    notifyListeners();
  }


  // Methods that handles changing the user's profile photo

  StorageServices _storageServices = StorageServices();
  File _chosenPhotoFromGallery;

  get chosenPhoto => _chosenPhotoFromGallery;

  void setChosenPhotoFromGalleryToNull() async {
    _chosenPhotoFromGallery = null;
    notifyListeners();
  }

  dynamic getImageFromGallery() async {
    ImagePicker _picker = ImagePicker();
    try {
      final pickedFile = await _picker.getImage(source: ImageSource.gallery, imageQuality: 0);
      File _image = File(pickedFile.path);
      _chosenPhotoFromGallery = _image;
      notifyListeners();
      return _image;
    } catch (e) {
      print(e);
      return null;
    }
  }

  dynamic showPhotoForProfileEditMode(String userPhotoUrl) {
    var returnedData;
    if (_chosenPhotoFromGallery == null && userPhotoUrl == null) {
      returnedData = AssetImage('images/noPhotoUser.jpg');
    } else if (_chosenPhotoFromGallery == null && userPhotoUrl != null) {
      returnedData = NetworkImage(userPhotoUrl);
    } else if (_chosenPhotoFromGallery != null) {
      returnedData = AssetImage(_chosenPhotoFromGallery.path);
    } else {
      returnedData = AssetImage('images/noPhotoUser.jpg');
    }
    return returnedData;
  }

  void updateUserProfile(String userId, String newUserName) async {
    if (_chosenPhotoFromGallery != null) {
      try {
        _storageServices.saveAndGetImageFromStorage(userId, _chosenPhotoFromGallery).then((value) => updateUserDetail(userId, value, newUserName),);
        setChosenPhotoFromGalleryToNull();
      }
      catch(e)  {
        print(e);
      }
    }
  }










}
