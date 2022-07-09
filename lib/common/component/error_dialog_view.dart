import 'package:flutter/material.dart';

class ErrorDialogView extends StatelessWidget {
  final String title;
  final String message;
  final Function() closeAction;

  const ErrorDialogView(
      {Key? key,
      this.title = "Error",
      required this.message,
      required this.closeAction});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Container(
        color: Colors.black26,
        child: Center(
            child: ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 200, minWidth: 300),
          child: DecoratedBox(
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.all(const Radius.circular(8)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Text(title,
                          style: const TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold))),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(message,
                        style: const TextStyle(color: Colors.black54)),
                  ),
                  ElevatedButton(
                    onPressed: closeAction,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child:
                          Text("Close", style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
