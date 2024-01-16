import 'package:flutter/material.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';

class ErrorDialog {
  static Future<void> showErrorDialog(
      errorTitle, errorDescription, context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(L10n.strings.common_alert_error),
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
              child: Text(L10n.strings.common_button_close),
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
