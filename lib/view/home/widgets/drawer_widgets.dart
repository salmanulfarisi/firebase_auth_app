import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_firebaseapp/controller/auth_provider.dart';
import 'package:sample_firebaseapp/model/user_model.dart';
import 'package:sample_firebaseapp/utilities/navigate_functions.dart';
import 'package:sample_firebaseapp/utilities/utils.dart';
import 'package:sample_firebaseapp/view/profile/profile_page.dart';

class Drawerwidgets extends StatelessWidget {
  const Drawerwidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: StreamBuilder<UserModel>(
          stream: userData(FirebaseAuth.instance.currentUser!.uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data;
              return Column(
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text('${users!.name}'),
                    accountEmail: Text('${users.email}'),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: MemoryImage(const Base64Decoder()
                          .convert('${users.image}'.isEmpty
                              ? tempImg
                              : '${users.image}')),
                    ),
                    onDetailsPressed: () => NavigateFunctions.pushPage(
                        context, const ProfilePage()),
                  ),
                  ListTile(
                    title: const Text('Home'),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading: const Icon(Icons.home_rounded),
                    selected: true,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('About App',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading:
                        const Icon(Icons.info_rounded, color: Colors.black),
                    onTap: () {
                      showAboutDialog(
                          context: context,
                          applicationName: 'Firebase App',
                          applicationVersion: 'v0.0.01',
                          applicationIcon: Container(
                              width: 80,
                              height: 80,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/download.png'),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.circle,
                              )),
                          applicationLegalese:
                              '© 2020-2021 All rights reserved.',
                          children: [
                            const Text(
                              'This app is made with ❤️ by '
                              'Salman',
                            ),
                          ]);
                    },
                  ),
                  ListTile(
                    title: const Text('Share App',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading:
                        const Icon(Icons.share_rounded, color: Colors.black),
                    onTap: () {
                      // Share.share(
                      //     'https://play.google.com/store/apps/details?id=com.beats.beats');
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('Feedback',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading:
                        const Icon(Icons.feedback_rounded, color: Colors.black),
                    onTap: () {
                      // mailToMe();
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: const Text('About Developer',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading: const Icon(Icons.person, color: Colors.black),
                    onTap: () {
                      // aboutMe();
                    },
                  ),
                  ListTile(
                    title: const Text('Rate this App',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading: const Icon(Icons.star_border_outlined,
                        color: Colors.black),
                    onTap: () {
                      // ratingApp();
                    },
                  ),
                  ListTile(
                    title: const Text('Logout',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20.0),
                    leading: const Icon(Icons.exit_to_app, color: Colors.black),
                    onTap: () => context.read<AuthProvider>().signOut(),
                    // showReset(context);
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Stream<UserModel> userData(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromJson(event.data()!));
  }
}
