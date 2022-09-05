import 'package:flutter/material.dart';

class TextFieldWidgets extends StatelessWidget {
  final TextEditingController controller;
  final String text;
  final bool isObscure;
  final TextInputType inputType;
  final bool isRead;
  final Function? onPressed;
  final IconData? icon;
  final String? Function(String?)? validation;
  const TextFieldWidgets({
    Key? key,
    required this.controller,
    required this.text,
    required this.isObscure,
    required this.inputType,
    required this.isRead,
    this.validation,
    this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        readOnly: isRead,
        keyboardType: inputType,
        validator: validation,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Colors.deepPurple),
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.deepPurple),
                borderRadius: BorderRadius.circular(12.0)),
            hintText: text,
            fillColor: Colors.grey[200],
            filled: true,
            suffixIcon: IconButton(
                onPressed: () {
                  onPressed!();
                },
                icon: Icon(icon))),
      ),
    );
  }
}
