import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_firebaseapp/controller/profile_provider.dart';
import 'package:sample_firebaseapp/model/user_model.dart';
import 'package:sample_firebaseapp/utilities/functions.dart';
import 'package:sample_firebaseapp/utilities/sizes.dart';
import 'package:sample_firebaseapp/utilities/utils.dart';
import 'package:sample_firebaseapp/view/login/widgets/textfield_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final usernameController = TextEditingController();
  final locationController = TextEditingController();
  final contactController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    locationController.dispose();
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profilePro = Provider.of<ProfileProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<UserModel?>(
          future: profilePro.readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    size50,
                    Center(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                backgroundImage: MemoryImage(
                                    const Base64Decoder().convert(
                                        '${users!.image}'.isEmpty
                                            ? tempImg
                                            : '${users.image}')),
                                radius: 64,
                              ),
                              Positioned(
                                bottom: -10,
                                left: 80,
                                child: IconButton(
                                  onPressed: profilePro.pickImage,
                                  icon: const Icon(
                                    Icons.add_a_photo,
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    size50,
                    TextFieldWidgets(
                      controller: usernameController,
                      text: '${users.name}',
                      isObscure: false,
                      inputType: TextInputType.text,
                      isRead: true,
                      icon: Icons.edit,
                      onPressed: () {
                        DialogeFunctions.updateUserDialogue(
                            context,
                            FirebaseAuth.instance.currentUser!.uid,
                            usernameController);
                      },
                    ),
                    size20,
                    TextFieldWidgets(
                      controller: locationController,
                      text: '${users.location}' == ""
                          ? 'Add Your location here'
                          : '${users.location}',
                      isObscure: false,
                      inputType: TextInputType.text,
                      isRead: true,
                      icon: Icons.edit,
                      onPressed: () {
                        DialogeFunctions.updateLocationDialogue(
                            context,
                            FirebaseAuth.instance.currentUser!.uid,
                            locationController);
                      },
                    ),
                    size20,
                    TextFieldWidgets(
                      controller: contactController,
                      text: '${users.contact}' == ""
                          ? 'Add your Contact Here'
                          : '${users.contact}',
                      isObscure: false,
                      inputType: TextInputType.phone,
                      isRead: true,
                      icon: Icons.edit,
                      onPressed: () {
                        DialogeFunctions.updateContactDialogue(
                            context,
                            FirebaseAuth.instance.currentUser!.uid,
                            contactController);
                        // final docUser = FirebaseFirestore.instance
                        //     .collection('users')
                        //     .doc(FirebaseAuth.instance.currentUser!.uid);
                        // docUser.update({'contact': contactController.text});
                      },
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
