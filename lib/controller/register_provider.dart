import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_firebaseapp/controller/auth_provider.dart';
import 'package:sample_firebaseapp/model/user_model.dart';
import 'package:sample_firebaseapp/utilities/utils.dart';

class RegsiterProvider extends ChangeNotifier {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final formkey2 = GlobalKey<FormState>();
  // signUp
  void signUp(AuthProvider provider) async {
    final msg = await provider
        .signUp(
      emailcontroller.text,
      passwordcontroller.text,
    )
        .then((value) {
      final user = UserModel(
        name: usernameController.text,
        email: emailcontroller.text,
        location: '',
        image: _imageToString,
        contact: '',
      );
      createProfile(user);
    });
    if (msg == '') return;
  }

  Future createProfile(UserModel user) async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    user.id = docUser.id;
    final json = user.toJson();
    await docUser.set(json);
  }

  String _imageToString = tempImg;
  get imageToString => _imageToString;
  set imageToString(val) => _imageToString = val;
  pickImage() async {
    final imageFromGallery =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFromGallery == null) {
      return;
    }
    final bytes = File(imageFromGallery.path).readAsBytesSync();
    _imageToString = base64Encode(bytes);
    notifyListeners();
  }
}
