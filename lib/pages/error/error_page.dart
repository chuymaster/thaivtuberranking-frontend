import 'package:flutter/material.dart';
import 'package:thaivtuberranking/services/analytics.dart';

import '../../main.dart';

class ErrorPage extends StatelessWidget {
  final String name;
  final String errorMessage;
  const ErrorPage({super.key, required this.name, required this.errorMessage});

  static const String route = '/error';

  @override
  Widget build(BuildContext context) {
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.screenLoaded,
        {AnalyticsParameterName.screenName: AnalyticsPageName.error});
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
