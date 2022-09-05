import 'package:flutter/material.dart';

class NavigateFunctions {
  static pushReplacePage(context, page) {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => page));
  }

  static pushPage(context, page) {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => page));
  }
}
