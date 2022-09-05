import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth;
  AuthProvider(this._auth);
  bool _isLoading = false;

  Stream<User?> stream() => _auth.authStateChanges();
  bool get loading => _isLoading;

  // signIn
  Future<String> signIn(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      await _auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) =>
              Fluttertoast.showToast(msg: 'Login Successfully').catchError((e) {
                Fluttertoast.showToast(msg: e!.messege);
              }));
      _isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

  // signUp
  Future<String> signUp(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      _auth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) =>
              Fluttertoast.showToast(msg: 'Account created SuccessFully')
                  .catchError((e) {
                Fluttertoast.showToast(msg: e!.messafge);
              }));
      _isLoading = false;
      notifyListeners();
      return Future.value('');
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      notifyListeners();
      return Future.value(e.message);
    }
  }

  // signOut
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // select user image

}
