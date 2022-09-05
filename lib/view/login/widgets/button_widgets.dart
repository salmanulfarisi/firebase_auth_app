import 'package:flutter/material.dart';
import 'package:sample_firebaseapp/utilities/textstyles.dart';

class ButtonWidgets extends StatelessWidget {
  final String text;
  const ButtonWidgets({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Text(
            text,
            style: buttonText,
          ),
        ),
      ),
    );
  }
}
