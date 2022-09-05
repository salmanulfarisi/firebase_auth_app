// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_firebaseapp/controller/auth_provider.dart';
import 'package:sample_firebaseapp/controller/login_provider.dart';
import 'package:sample_firebaseapp/utilities/navigate_functions.dart';
import 'package:sample_firebaseapp/utilities/sizes.dart';
import 'package:sample_firebaseapp/utilities/textstyles.dart';
import 'package:sample_firebaseapp/view/login/reset_password.dart';
import 'package:sample_firebaseapp/view/login/widgets/button_widgets.dart';
import 'package:sample_firebaseapp/view/login/widgets/textfield_widgets.dart';
import 'package:sample_firebaseapp/view/register/register_page.dart';

class LoginPage extends StatelessWidget {
  // final VoidCallback showRegisterPage;
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final loginPov = Provider.of<LoginProvider>(context);
    final formkey = GlobalKey<FormState>();
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
                    'Hello Again!',
                    style: heading1,
                  ),
                  const Text(
                    'Welcome back, you\'ve been Missed!',
                    style: heading2,
                  ),
                  size20,
                  // email TextFiled
                  TextFieldWidgets(
                    controller: loginPov.emailcontroller,
                    text: 'E-mail',
                    inputType: TextInputType.emailAddress,
                    isObscure: false,
                    isRead: false,
                    validation: (value) {
                      if (value!.isEmpty) {
                        'Please Enter Your Email';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                  ),
                  size10,
                  // password TextField
                  TextFieldWidgets(
                    controller: loginPov.passwordcontroller,
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
                        return "Enter valid Password(Min.6 charecter)";
                      }
                      return null;
                    },
                  ),
                  size10,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () => NavigateFunctions.pushPage(
                              context, const ResetPassWordPage()),
                          child: const Text(
                            'Forget Password?',
                            style: forgetText,
                          ),
                        ),
                      ],
                    ),
                  ),
                  size10,
                  // SignIn Button
                  if (authProvider.loading)
                    const CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  if (!authProvider.loading)
                    GestureDetector(
                      onTap: () {
                        if (formkey.currentState!.validate()) {
                          loginPov.signIn(authProvider);
                        }

                        // loginPov.signIn(emailcontroller.text.trim(),
                        //     passwordcontroller.text.trim());
                      },
                      child: const ButtonWidgets(
                        text: 'Sign In',
                      ),
                    ),
                  size20,
                  // Not a member
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not a member?', style: memberText),
                      GestureDetector(
                          onTap: () {
                            NavigateFunctions.pushPage(
                                context, const RegisterPage());
                            loginPov.emailcontroller.clear();
                            loginPov.passwordcontroller.clear();
                          },
                          child: const Text(' Register Now',
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
  }
}
