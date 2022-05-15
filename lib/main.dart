import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:thaivtuberranking/common/strings.dart';
import 'package:thaivtuberranking/providers/channel_list/channel_list_provider.dart';
import 'package:thaivtuberranking/providers/channel_list/channel_list_repository.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:thaivtuberranking/services/environment_setting.dart';
import 'common/component/thai_text.dart';
import 'pages/home/home_page.dart';
import 'services/route/router.dart' as router;
import 'package:http/http.dart' as http;

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
  static late Analytics analytics;

  ChannelListProvider _channelListProvider =
      ChannelListProvider(repository: ChannelListRepository(http.Client()));

  _initAnalytics() {
    analytics = Analytics(analytics: FirebaseAnalytics.instance);
  }

  MyApp() {
    _initAnalytics();
    _channelListProvider.getChannelList();
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
        child: ChangeNotifierProvider(
      create: (context) => _channelListProvider,
      child: MaterialApp(
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)
        ],
        initialRoute: HomePage.route,
        title: Strings.siteTitle,
        onGenerateRoute: router.generateRoute,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: ThaiText.sarabun),
        home: HomePage(),
      ),
    ));
  }
}
