import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sample_firebaseapp/utilities/sizes.dart';
import 'package:sample_firebaseapp/view/login/widgets/textfield_widgets.dart';

class DialogeFunctions {
  static updateUserDialogue(context, id, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Are You Want Update'),
          content: TextFieldWidgets(
              controller: controller,
              text: 'Update User name',
              isObscure: false,
              inputType: TextInputType.text,
              isRead: false),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () {
                  final docUser =
                      FirebaseFirestore.instance.collection('users').doc(id);
                  docUser.update({
                    'user name': controller.text,
                  }).then((value) =>
                      Fluttertoast.showToast(msg: 'Updated Successfully')
                          .catchError((e) {
                        Fluttertoast.showToast(msg: e!.messege);
                      }));
                  Navigator.pop(context);
                },
                child: const Text('Update'))
          ],
        );
      },
    );
  }

  static updateLocationDialogue(context, id, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Are You Want Update'),
          content: TextFieldWidgets(
              controller: controller,
              text: 'Update Location',
              isObscure: false,
              inputType: TextInputType.text,
              isRead: false),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () {
                  final docUser =
                      FirebaseFirestore.instance.collection('users').doc(id);
                  docUser.update({
                    'location': controller.text,
                  }).then((value) =>
                      Fluttertoast.showToast(msg: 'Updated Successfully')
                          .catchError((e) {
                        Fluttertoast.showToast(msg: e!.messege);
                      }));
                  Navigator.pop(context);
                },
                child: const Text('Update'))
          ],
        );
      },
    );
  }

  static updateContactDialogue(context, id, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Are You Want Update'),
          content: TextFieldWidgets(
              controller: controller,
              text: 'Update Number',
              isObscure: false,
              inputType: TextInputType.phone,
              isRead: false),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel')),
            ElevatedButton(
                onPressed: () {
                  final docUser =
                      FirebaseFirestore.instance.collection('users').doc(id);
                  docUser.update({'contact': controller.text}).then((value) =>
                      Fluttertoast.showToast(msg: 'Updated Successfully')
                          .catchError((e) {
                        Fluttertoast.showToast(msg: e!.messege);
                      }));
                  Navigator.pop(context);
                },
                child: const Text('Update'))
          ],
        );
      },
    );
  }

  static showProfile(context) {
    showDialog(
        context: context,
        builder: (ctx) {
          final displayNameController = TextEditingController();
          return AlertDialog(
            title: const Text('What is your Name'),
            content: SizedBox(
              height: MediaQuery.of(context).size.width / 1.1,
              width: 250,
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 10)),
                              ],
                              border: Border.all(
                                  width: 4, color: Colors.deepPurple),
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQG7Ya6NFpKCiA2Q1UgS7zGN8yYvbjhb5b5X3PczjaoygRgWCe8aABqdrgWNpTnTxMCwDA&usqp=CAU'))),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 4, color: Colors.deepPurple),
                              color: Colors.deepPurple,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  size50,
                  TextFieldWidgets(
                      controller: displayNameController,
                      text: 'Display name',
                      isObscure: false,
                      inputType: TextInputType.text,
                      isRead: false),
                  size20,
                  ElevatedButton(
                    onPressed: () {
                      var user = FirebaseAuth.instance.currentUser;
                      user?.updateDisplayName(displayNameController.text);
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  )
                ],
              ),
            ),
          );
        });
  }
}
