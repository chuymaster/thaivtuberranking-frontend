import 'package:flutter/material.dart';

class CenterCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center, child: CircularProgressIndicator());
  }
}
