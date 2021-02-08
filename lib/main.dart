import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:thaivtuberranking/services/environment_setting.dart';
import 'common/component/thai_text.dart';
import 'pages/home/home_page.dart';
import 'services/route/router.dart' as router;

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  static String title = "จัดอันดับ VTuber ไทย";

  static FirebaseAnalytics _analytics;
  static FirebaseAnalyticsObserver _observer;
  static Analytics analytics;

  // Init Analytics object only on release mode
  initAnalytics() {
    if (EnvironmentSetting.shared.isReleaseMode &&
        EnvironmentSetting.shared.deployEnvironment ==
            DeployEnvironment.Production) {
      _analytics = FirebaseAnalytics();
      _observer = FirebaseAnalyticsObserver(analytics: _analytics);
      analytics = Analytics(analytics: _analytics, observer: _observer);
    } else {
      analytics = Analytics(analytics: null, observer: null);
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initAnalytics();

    return OKToast(
        child: MaterialApp(
      initialRoute: HomePage.route,
      title: title,
      onGenerateRoute: router.generateRoute,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: ThaiText.sarabun),
      home: HomePage(),
    ));
  }
}
