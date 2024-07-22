import 'package:flutter/material.dart';

class MessageHepler {
  static GlobalKey<ScaffoldMessengerState> key =
      GlobalKey<ScaffoldMessengerState>();

  static void showSnackBarMessage({isSuccess = bool, message = String}) {
    key.currentState!.showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 1500),
      backgroundColor: isSuccess ? Colors.green : Colors.red,
      padding: const EdgeInsets.all(18),
      content: Text(
        message,
        style: TextStyle(
          fontSize: 18,
          backgroundColor: isSuccess ? Colors.green : Colors.red,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }
}
