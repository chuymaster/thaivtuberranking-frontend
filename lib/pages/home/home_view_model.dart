import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/home/home_repository.dart';
import 'package:thaivtuberranking/services/result.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _repository = HomeRepository();

  String _lastUpdated = "";
  int _index = 0;
  bool _isBottomNavigationBarHidden = false;
  String _title = "จัดอันดับวิดีโอ VTuber ไทย";

  Result viewState = Result.loading();

  String get title {
    return _title;
  }

  int get index {
    return _index;
  }

  String get lastUpdated {
    return _lastUpdated;
  }

  bool get isBottomNavigationBarHidden {
    return _isBottomNavigationBarHidden;
  }

  void getChannelList() async {
    viewState = Result.loading();
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

  List<ChannelInfo> getFilteredChannelList(OriginType originType) {
    switch (originType) {
      case OriginType.OriginalOnly:
        return channelList.where((element) => (!element.isRebranded)).toList();
      case OriginType.All:
        return channelList;
    }
  }

  void changeIndex(int index) {
    _index = index;
    if (index == 0) {
      _title = "จัดอันดับวิดีโอ VTuber ไทย";
    } else {
      _title = "จัดอันดับแชนแนล VTuber ไทย";
    }
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
