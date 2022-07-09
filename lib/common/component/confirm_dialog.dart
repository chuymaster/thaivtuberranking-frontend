import 'package:flutter/material.dart';

class ConfirmDialog {
  static Future<void> show(String title, String message,
      Function() onPressedContinue, BuildContext context) async {
    Widget continueButton = ElevatedButton(
        child: const Text("Continue"),
        onPressed: () {
          onPressedContinue();
          Navigator.pop(context);
        });
    Widget cancelButton = ElevatedButton(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        });

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [cancelButton, continueButton],
        );
      },
    );
  }
}
