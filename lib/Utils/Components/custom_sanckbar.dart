import 'package:flutter/material.dart';

class CustomSnackBar {
  static mySnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(
          seconds: 1
        ),
        behavior: SnackBarBehavior.floating,
        content: Text(message),
      ),
    );
  }
}
