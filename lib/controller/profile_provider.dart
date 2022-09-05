import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sample_firebaseapp/model/user_model.dart';
import 'package:sample_firebaseapp/utilities/utils.dart';

class ProfileProvider extends ChangeNotifier {
  // read user
  Future<UserModel?> readUser() async {
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    }
    return null;
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
    final docUser = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    docUser.update({'image': _imageToString});
    notifyListeners();
  }
}
