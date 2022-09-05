import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_firebaseapp/controller/login_provider.dart';
import 'package:sample_firebaseapp/utilities/sizes.dart';
import 'package:sample_firebaseapp/view/login/widgets/textfield_widgets.dart';

class ResetPassWordPage extends StatefulWidget {
  const ResetPassWordPage({Key? key}) : super(key: key);

  @override
  State<ResetPassWordPage> createState() => _ResetPassWordPageState();
}

class _ResetPassWordPageState extends State<ResetPassWordPage> {
  final resetPasswordController = TextEditingController();
  @override
  void dispose() {
    resetPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginPro = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
                'Enter Your Email we will Send you a password reset link'),
            size20,
            TextFieldWidgets(
              controller: resetPasswordController,
              text: 'E-mail',
              isObscure: false,
              inputType: TextInputType.none,
              isRead: false,
            ),
            size20,
            MaterialButton(
              onPressed: () {
                loginPro.passwordReset(context, resetPasswordController);
              },
              color: Colors.deepPurple[200],
              child: const Text('Reset Password'),
            )
          ],
        ),
      ),
    );
  }
}
