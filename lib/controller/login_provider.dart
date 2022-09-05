import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sample_firebaseapp/controller/auth_provider.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final formkey = GlobalKey<FormState>();
  // signIn
  void signIn(AuthProvider provider) async {
    final msg =
        await provider.signIn(emailcontroller.text, passwordcontroller.text);
    if (msg == '') return;
  }

  Future passwordReset(context, TextEditingController resetController) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: resetController.text.trim());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
                content: Text('Password reset Link sent! Check your e-mail'));
          });
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(e.message.toString()));
          });
    }
  }
}
