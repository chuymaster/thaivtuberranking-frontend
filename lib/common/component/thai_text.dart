import 'package:flutter/material.dart';

class ThaiText extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double textHeight;
  final Color color;
  final double fontSize;
  final TextOverflow overflow;
  final String fontFamily;

  static const String kanit = 'Kanit';
  static const String sarabun = 'Sarabun';

  ThaiText(
      {super.key,
      required this.text,
      this.fontWeight = FontWeight.normal,
      this.textHeight = 1.35, // จำเป็นต้องเซ็ตความสูงเพื่อให้ภาษาไทยไม่ตกร่อง
      this.color = Colors.black,
      this.fontSize = 16,
      this.overflow = TextOverflow.ellipsis,
      this.fontFamily = ThaiText.sarabun});

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(
      height: textHeight,
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontFamily: fontFamily,
    );
    return Text(text, style: style);
  }
}
