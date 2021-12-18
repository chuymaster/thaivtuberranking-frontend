import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/home/home_repository.dart';
import 'package:thaivtuberranking/services/result.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeRepository _repository = HomeRepository();

  Result viewState = Result.loading();

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
}
