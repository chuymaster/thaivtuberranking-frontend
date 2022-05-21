import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';

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

  List<ChannelInfo> getFilteredChannelList(List<ChannelInfo> channelList) {
    switch (_originType) {
      case OriginType.OriginalOnly:
        return channelList.where((element) => (!element.isRebranded)).toList();
      case OriginType.All:
        return channelList;
    }
  }
}
