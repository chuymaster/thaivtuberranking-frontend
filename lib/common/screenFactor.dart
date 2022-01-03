import 'package:flutter/material.dart';

enum ScreenType { Small, Large }

ScreenType getScreenType(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > 600) return ScreenType.Large;
  return ScreenType.Small;
}

double getContentWidth(BuildContext context) {
  double deviceWidth = MediaQuery.of(context).size.shortestSide;
  if (deviceWidth > 600) return 600;
  return deviceWidth;
}
