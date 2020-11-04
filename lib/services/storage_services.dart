import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class StorageServices {
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> saveAndGetImageFromStorage(String userId, File chosenPhoto) async {
    StorageReference firebaseStorageRef = _storage.ref().child('user/profile/$userId');
    StorageUploadTask uploadTask = firebaseStorageRef.putFile(chosenPhoto);
    var completed = await uploadTask.onComplete;
    String url = await completed.ref.getDownloadURL();
    return url;
  }
}
