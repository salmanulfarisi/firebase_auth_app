import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_firebaseapp/controller/auth_provider.dart';
import 'package:sample_firebaseapp/model/user_model.dart';
import 'package:sample_firebaseapp/view/home/widgets/drawer_widgets.dart';
import 'package:sample_firebaseapp/view/login/login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: context.watch<AuthProvider>().stream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const LoginPage();
          }
          return Scaffold(
            drawer: const Drawerwidgets(),
            appBar: AppBar(
              actions: const [
                // IconButton(
                //   onPressed: () => context.read<AuthProvider>().signOut(),
                //   icon: const Icon(Icons.exit_to_app),
                // ),
              ],
            ),
            body: StreamBuilder<UserModel?>(
                stream: userData(FirebaseAuth.instance.currentUser!.uid),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final users = snapshot.data;
                    return Center(
                      child: Text(
                        'Welcome ${users!.name}',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          );
        });
  }

  Stream<UserModel> userData(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromJson(event.data()!));
  }

  Widget appBar() {
    return AppBar();
  }
}
