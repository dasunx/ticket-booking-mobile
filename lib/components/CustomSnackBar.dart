import 'package:flutter/material.dart';

SnackBar customSnackBar(BuildContext context, String message) {
  return SnackBar(
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(message, style: TextStyle(color: Colors.white, fontSize: 16)),
    ),
    duration: Duration(seconds: 3),
    backgroundColor: Colors.black,
    behavior: SnackBarBehavior.floating,
  );
}
