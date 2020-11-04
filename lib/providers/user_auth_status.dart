import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserAuthStatus with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;

  UserAuthStatus.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  // Register method

  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _status = Status.Authenticated;
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      var error = typeOfError(e.code);
      return error;
    }
  }

  // Log in method

  Future signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      var error = typeOfError(e.code);
      return error;
    }
  }

  // Log out method

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    _user = null;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  // Reset password via email

  Future passwordReset(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      var error = typeOfError(e.code);
      return error;
    }
  }

  // Method for checking if user is log in

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  // Method for checking what type of error was throw for authentication screens.

  String typeOfError(String error) {
    if (error == 'ERROR_USER_NOT_FOUND') {
      return 'No user found with this email.';
    } else if (error == 'ERROR_WRONG_PASSWORD') {
      return 'Wrong password.';
    } else if (error == 'ERROR_EMAIL_ALREADY_IN_USE') {
      return 'There is already a user with this email address.';
    } else if (error == ' ERROR_NETWORK_REQUEST_FAILED') {
      return 'No internet access.';
    } else {
      return 'Something has gone wrong';
    }
  }
}
