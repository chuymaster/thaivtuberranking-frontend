import 'package:flutter/material.dart';

class CenterCircularProgressIndicator extends StatelessWidget {
  const CenterCircularProgressIndicator({Key? key, this.isOverlay = false});
  final bool isOverlay;

  @override
  Widget build(BuildContext context) {
    if (isOverlay) {
      return SizedBox.expand(
          child: Container(
        color: Colors.black26,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ));
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
