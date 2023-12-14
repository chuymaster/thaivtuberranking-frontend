import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';
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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

  final ChannelListProvider _channelListProvider =
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
        onGenerateTitle: (context) {
          L10n.setLocalizations(AppLocalizations.of(context)!);
          return L10n.strings.app__site_title;
        } ,
        onGenerateRoute: router.generateRoute,
        theme: ThemeData(useMaterial3: true, fontFamily: ThaiText.sarabun),
        home: HomePage(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    ));
  }
}
