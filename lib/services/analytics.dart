import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:thaivtuberranking/services/environment_setting.dart';

class Analytics {
  final FirebaseAnalytics? analytics;
  final FirebaseAnalyticsObserver? observer;

  Analytics({this.analytics, this.observer});

  Future<void> sendAnalyticsEvent(
      String name, Map<String, dynamic> parameters) async {
    if (EnvironmentSetting.shared.isReleaseMode &&
        EnvironmentSetting.shared.deployEnvironment ==
            DeployEnvironment.Production) {
      await analytics?.logEvent(name: name, parameters: parameters);
    }
  }
}

class AnalyticsEvent {
  static String open_drawer_url = 'open_drawer_url';
  static String set_type = 'set_type';
  static String click_vtuber_url = 'click_vtuber_url';
  static String view_detail = 'view_detail';
  static String change_page = 'change_page';
  static String view_add_page = 'view_add_page';
  static String set_filter = 'set_filter';
  static String video_loaded = 'video_loaded';
  static String request_add_channel = 'request_add_channel';
  static String tap_channel_url_before_submit_add_request =
      'tap_channel_url_before_submit_add_request';
  static String open_video_url = 'open_video_url';
  static String change_bottom_tab = 'change_bottom_tab';
  static String change_video_ranking_tab = 'change_bottom_tab';
  static String load_ad = 'load_ad';
  static String copy_channel_url = "copy_channel_url";
  static String view_search_page = 'view_search_page';
  static String search = 'search';
  static String click_channel_statistics_api = 'click_channel_statistics_api';

  // Load screen
  static String page_loaded = "screen_loaded";
}

class AnalyticsParameterName {
  static String page_name = "screen_name";
}

class AnalyticsPageName {
  static String add = "add";
  static String add_complete = "add_complete";
  static String home = "home";
  static String video_ranking = "video_ranking";
  static String video_ranking_container = "video_ranking_container";
  static String channel_ranking = "channel_ranking";
  static String channel = "channel";
  static String error = "error";
  static String search = "search";
  static String live = "live";
}
