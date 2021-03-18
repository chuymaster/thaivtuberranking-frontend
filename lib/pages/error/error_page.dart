import 'package:flutter/material.dart';
import 'package:thaivtuberranking/services/analytics.dart';

import '../../main.dart';

class ErrorPage extends StatelessWidget {
  final String name;
  final String errorMessage;
  const ErrorPage({Key? key, required this.name, required this.errorMessage})
      : super(key: key);

  static const String route = '/error';

  @override
  Widget build(BuildContext context) {
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.error});
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: Text(
          errorMessage,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
