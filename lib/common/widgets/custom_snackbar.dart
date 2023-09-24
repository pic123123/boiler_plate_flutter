import 'package:flutter/material.dart';

enum SnackBarType { success, error }

class CustomSnackBar {
  static void show(BuildContext context, SnackBarType type, String message) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            type == SnackBarType.success ? Icons.check_circle : Icons.error,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Flexible(
            // Add this
            child: Text(message),
          ),
        ],
      ),
      backgroundColor: type == SnackBarType.success ? Colors.green : Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
