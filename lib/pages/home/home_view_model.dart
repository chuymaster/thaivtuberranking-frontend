import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/home/home_repository.dart';
import 'package:thaivtuberranking/services/result.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _repository = HomeRepository();

  String _lastUpdated = "";
  String get lastUpdated {
    return _lastUpdated;
  }

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

  Result viewState = Result.loading();

  void getChannelList() async {
    viewState = Result.loading();
    notifyListeners();
    viewState = await _repository.getChannelList();
    notifyListeners();
  }

  List<ChannelInfo> get channelList {
    if (viewState is SuccessState<List<ChannelInfo>>) {
      final channelList = (viewState as SuccessState<List<ChannelInfo>>).value;
      return channelList;
    }
    return [];
  }

  List<String> get channelIdList {
    return channelList.map((e) => e.channelId).toList();
  }

  List<ChannelInfo> get filteredChannelList {
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
