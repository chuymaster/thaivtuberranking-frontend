import '../../services/environment_setting.dart';

class Endpoint {
  static String get _baseUrl {
    if (EnvironmentSetting.shared.deployEnvironment ==
        DeployEnvironment.Production) {
      return "https://us-central1-thaivtuberranking.cloudfunctions.net/";
    } else {
      return "https://us-central1-thaivtuberranking-dev.cloudfunctions.net/";
    }
  }

  static String get getChannelRequestList {
    return _baseUrl + "getChannelRequestList";
  }

  static String get postChannelRequest {
    return _baseUrl + "postChannelRequest";
  }

  static String get deleteChannelRequest {
    return _baseUrl + "deleteChannelRequest";
  }

  static String get getChannelList {
    return _baseUrl + "getChannelList";
  }

  static String get postChannel {
    return _baseUrl + "postChannel";
  }

  static String get deleteChannel {
    return _baseUrl + "deleteChannel";
  }

  static String get deleteObsoleteChannels {
    return _baseUrl + "deleteObsoleteChannels";
  }
}
