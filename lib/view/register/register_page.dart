// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_firebaseapp/controller/auth_provider.dart';
import 'package:sample_firebaseapp/controller/register_provider.dart';
import 'package:sample_firebaseapp/utilities/navigate_functions.dart';
import 'package:sample_firebaseapp/utilities/sizes.dart';
import 'package:sample_firebaseapp/utilities/textstyles.dart';
import 'package:sample_firebaseapp/view/home/home_page.dart';
import 'package:sample_firebaseapp/view/login/login_page.dart';
import 'package:sample_firebaseapp/view/login/widgets/button_widgets.dart';
import 'package:sample_firebaseapp/view/login/widgets/textfield_widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final registerPov = Provider.of<RegsiterProvider>(context);
    final formkey = GlobalKey<FormState>();
    return StreamBuilder<User?>(
        stream: authProvider.stream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          }
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Hello Again
                        Text(
                          'Hello There!',
                          style: heading1,
                        ),
                        const Text(
                          'Register below with your details!',
                          style: heading2,
                        ),
                        size20,
                        Center(
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: MemoryImage(
                                        const Base64Decoder().convert(
                                            registerPov.imageToString)),
                                    radius: 64,
                                  ),
                                  Positioned(
                                    bottom: -10,
                                    left: 80,
                                    child: IconButton(
                                      onPressed: registerPov.pickImage,
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
                        size20,
                        TextFieldWidgets(
                          controller: registerPov.usernameController,
                          text: 'User Name',
                          inputType: TextInputType.text,
                          isObscure: false,
                          isRead: false,
                        ),
                        size20,
                        // email TextFiled
                        TextFieldWidgets(
                          controller: registerPov.emailcontroller,
                          text: 'E-mail',
                          inputType: TextInputType.emailAddress,
                          isObscure: false,
                          isRead: false,
                          validation: (value) {
                            if (value!.isEmpty) {
                              'Please Enter Your Email';
                            }
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return 'Please Enter Valid Email';
                            }
                            return null;
                          },
                        ),
                        size10,

                        size10,
                        // password TextField
                        TextFieldWidgets(
                          controller: registerPov.passwordcontroller,
                          text: 'Password',
                          inputType: TextInputType.text,
                          isObscure: true,
                          isRead: false,
                          validation: (value) {
                            final regex = RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return 'Please Enter your Password';
                            }
                            if (!regex.hasMatch(value)) {
                              return "Please Enter valid Password(Min.6 charecter)";
                            }
                            return null;
                          },
                        ),
                        size20,
                        // confirm TextField

                        size20,
                        // SignIn Button
                        if (authProvider.loading)
                          const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        if (!authProvider.loading)
                          GestureDetector(
                            onTap: () {
                              if (formkey.currentState!.validate()) {
                                registerPov.signUp(authProvider);
                              }
                            },
                            child: const ButtonWidgets(
                              text: 'Sign Up',
                            ),
                          ),
                        size20,
                        // Not a member
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already Join?', style: memberText),
                            GestureDetector(
                                onTap: () {
                                  NavigateFunctions.pushPage(
                                    context,
                                    const LoginPage(),
                                  );
                                  registerPov.emailcontroller.clear();
                                  registerPov.passwordcontroller.clear();
                                  registerPov.usernameController.clear();
                                },
                                child: const Text(' Login Now',
                                    style: loginRegsiterText)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
