import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';

class HomeViewModel extends ChangeNotifier {
  int _tabIndex = 0;
  int get tabIndex {
    return _tabIndex;
  }

  bool _isBottomNavigationBarHidden = false;

  bool get isBottomNavigationBarHidden {
    return _isBottomNavigationBarHidden;
  }

  OriginType _originType = OriginType.OriginalOnly;
  OriginType get originType {
    return _originType;
  }

  List<ChannelInfo> getFilteredChannelList(List<ChannelInfo> channelList) {
    switch (_originType) {
      case OriginType.OriginalOnly:
        return channelList.where((element) => (!element.isRebranded)).toList();
      case OriginType.All:
        return channelList;
    }
  }

  void changeTabIndex(int index) {
    _tabIndex = index;
    notifyListeners();
  }

  void changeOriginType(OriginType originType) {
    _originType = originType;
    notifyListeners();
  }

  void hideBottomNavigationBar() {
    if (!_isBottomNavigationBarHidden) {
      _isBottomNavigationBarHidden = true;
      notifyListeners();
    }
  }

  void showBottomNavigationBar() {
    if (_isBottomNavigationBarHidden) {
      _isBottomNavigationBarHidden = false;
      notifyListeners();
    }
  }
}
