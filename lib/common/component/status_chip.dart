import 'package:flutter/material.dart';

class StatusChip extends StatelessWidget {
  const StatusChip(
      {Key? key,
      required this.title,
      this.foregroundColor = Colors.white,
      required this.backgroundColor});

  final String title;
  final Color foregroundColor;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        title,
        style: TextStyle(color: foregroundColor, fontSize: 12),
      ),
      backgroundColor: backgroundColor,
    );
  }
}
