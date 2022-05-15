import 'package:flutter/material.dart';

import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/providers/channel_list/channel_list_repository.dart';
import 'package:thaivtuberranking/services/result.dart';

class ChannelListProvider extends ChangeNotifier {
  final AbstractChannelListRepository repository;

  ChannelListProvider({required this.repository});

  Result viewState = Result.loading();

  Future<void> getChannelList() async {
    viewState = Result.loading();
    notifyListeners();
    viewState = await repository.getChannelList();
    notifyListeners();
  }

  List<ChannelInfo> get channelList {
    if (viewState is SuccessState) {
      final channelList = (viewState as SuccessState).value;
      return channelList;
    }
    return [];
  }

  List<String> get channelIdList {
    return channelList.map((e) => e.channelId).toList();
  }

  String get channelListLastUpdatedAt {
    if (channelList.isNotEmpty) {
      channelList.sort((a, b) => a.updatedAt - b.updatedAt);
      return channelList[0].updatedAtString;
    }
    return "";
  }
}
