import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/activity_type.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';

import '../../main.dart';
import '../../services/analytics.dart';

class HomeViewModel extends ChangeNotifier {
  int _tabIndex = 0;
  int get tabIndex => _tabIndex;
  set tabIndex(int index) {
    _tabIndex = index;
    notifyListeners();
  }

  bool _isBottomNavigationBarHidden = false;
  bool get isBottomNavigationBarHidden => _isBottomNavigationBarHidden;
  set isBottomNavigationBarHidden(bool isBottomNavigationBarHidden) {
    if (_isBottomNavigationBarHidden == isBottomNavigationBarHidden) {
      return;
    }
    _isBottomNavigationBarHidden = isBottomNavigationBarHidden;
    notifyListeners();
  }

  OriginType _originType = OriginType.OriginalOnly;
  OriginType get originType => _originType;
  set originType(OriginType originType) {
    _originType = originType;
    notifyListeners();
  }

  toggleChannelOriginType() {
    if (_originType == OriginType.All) {
      _originType = OriginType.OriginalOnly;
    } else {
      _originType = OriginType.All;
    }
    notifyListeners();
    MyApp.analytics.sendAnalyticsEvent(
        AnalyticsEvent.setActivityType, {'type': _activityType.name});
  }

  ActivityType _activityType = ActivityType.ActiveOnly;
  ActivityType get activityType => _activityType;
  set activityType(ActivityType activityType) {
    _activityType = activityType;
    notifyListeners();
  }

  toggleDisplayInactiveChannel() {
    if (_activityType == ActivityType.All) {
      _activityType = ActivityType.ActiveOnly;
    } else {
      _activityType = ActivityType.All;
    }
    notifyListeners();
    MyApp.analytics.sendAnalyticsEvent(
        AnalyticsEvent.setActivityType, {'type': _activityType.name});
  }

  List<ChannelInfo> getFilteredChannelList(List<ChannelInfo> channelList) {
    List<ChannelInfo> filteredChannelList = [];
    switch (_originType) {
      case OriginType.OriginalOnly:
        filteredChannelList =
            channelList.where((element) => (!element.isRebranded)).toList();
        break;
      case OriginType.All:
        filteredChannelList = channelList;
        break;
    }
    switch (_activityType) {
      case ActivityType.ActiveOnly:
        filteredChannelList = filteredChannelList.where((element) {
          return element.isActive;
        }).toList();
        break;
      default:
        break;
    }
    return filteredChannelList;
  }
}
