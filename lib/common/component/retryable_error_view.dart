import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';

class RetryableErrorView extends StatelessWidget {
  final String title;
  final String message;
  final Function() retryAction;

  const RetryableErrorView(
      {super.key,
      this.title = "Error",
      required this.message,
      required this.retryAction});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: ThaiText(
                        text: title,
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ThaiText(text: message, color: Colors.black54),
                ),
                ElevatedButton(
                  onPressed: retryAction,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ThaiText(
                      text: "Reload",
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            )));
  }
}
