import 'package:flutter/material.dart';

class ErrorDialog {
  static Future<void> showErrorDialog(
      errorTitle, errorDescription, context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(errorTitle),
                Text(
                  errorDescription,
                  style: TextStyle(color: Colors.red),
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ปิด'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
