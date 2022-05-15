import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:thaivtuberranking/services/environment_setting.dart';
import 'common/component/thai_text.dart';
import 'pages/home/home_page.dart';
import 'services/route/router.dart' as router;

Future<void> main() async {
  await Firebase.initializeApp(
    options: _isProduction
        ? DefaultFirebaseOptions.currentPlatform
        : DefaultFirebaseOptions.currentDevPlatform,
  );
  runApp(MyApp());
}

bool get _isProduction =>
    EnvironmentSetting.shared.isReleaseMode &&
    EnvironmentSetting.shared.deployEnvironment == DeployEnvironment.Production;

class MyApp extends StatelessWidget {
  static String title = "จัดอันดับ VTuber ไทย";

  static late Analytics analytics;

  initAnalytics() {
    analytics = Analytics(analytics: FirebaseAnalytics.instance);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    initAnalytics();

    return OKToast(
        child: MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
      ],
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
