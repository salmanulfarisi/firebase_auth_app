import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_firebaseapp/controller/auth_provider.dart';
import 'package:sample_firebaseapp/controller/login_provider.dart';
import 'package:sample_firebaseapp/controller/profile_provider.dart';
import 'package:sample_firebaseapp/controller/register_provider.dart';
import 'package:sample_firebaseapp/view/home/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => RegsiterProvider()),
        ChangeNotifierProvider(
            create: (_) => AuthProvider(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) => context.watch<AuthProvider>().stream(),
            initialData: null)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          canvasColor: Colors.grey[300],
          primarySwatch: Colors.deepPurple,
        ),
        home: const HomePage(),
      ),
    );
  }
}
