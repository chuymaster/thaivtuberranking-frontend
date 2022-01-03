import 'package:flutter/material.dart';

double getContentWidth(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.width;
  return deviceWidth > largeScreenContentWidth
      ? largeScreenContentWidth
      : deviceWidth;
}

double largeScreenContentWidth = 600;
