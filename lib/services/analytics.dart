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
  static String openDrawerUrl = 'open_drawer_url';
  static String setType = 'set_type';
  static String clickVtuberUrl = 'click_vtuber_url';
  static String viewDetail = 'view_detail';
  static String changePage = 'change_page';
  static String viewChannelRegistrationPage = 'view_channel_registration_page';
  static String setFilter = 'set_filter';
  static String registerChannel = 'register_channel';
  static String tapChannelUrlBeforeRegister = 'tap_channel_url_before_register';
  static String openVideoUrl = 'open_video_url';
  static String changeBottomTab = 'change_bottom_tab';
  static String changeVideoRankingTab = 'change_video_ranking_tab';
  static String copyChannelUrl = "copy_channel_url";
  static String search = 'search';
  static String clickChannelStatisticsApi = 'click_channel_statistics_api';
  static String clickDeleteChannelAnnouncement =
      'click_delete_channel_announcement';

  // Load screen
  static String screenLoaded = "screen_loaded";
}

class AnalyticsParameterName {
  static String screenName = "screen_name";
}

class AnalyticsPageName {
  static String channelRegistration = "channel_registration";
  static String channelRegistrationComplete = "channel_registration_complete";
  static String home = "home";
  static String videoRanking = "video_ranking";
  static String videoRankingContainer = "video_ranking_container";
  static String channelRanking = "channel_ranking";
  static String channel = "channel";
  static String error = "error";
  static String live = "live";
}
