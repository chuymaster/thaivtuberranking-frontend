import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/live/entity/live_video.dart';
import 'package:thaivtuberranking/pages/live/live_repository.dart';
import 'package:thaivtuberranking/services/result.dart';

class LiveViewModel extends ChangeNotifier {
  final OriginType originType;
  final LiveRepository _repository = LiveRepository();

  Result viewState = Result.loading();

  LiveViewModel(this.originType);

  void getLiveVideos() async {
    viewState = Result.loading();
    viewState = await _repository.getLiveVideos();
    notifyListeners();
  }

  List<LiveVideo> get filteredLiveVideos {
    if (viewState is SuccessState<List<LiveVideo>>) {
      final liveVideos = (viewState as SuccessState<List<LiveVideo>>).value;
      switch (originType) {
        case OriginType.OriginalOnly:
          return liveVideos
              .where((element) => (!element.channelIsRebranded))
              .toList();
        case OriginType.All:
          return liveVideos;
      }
    }
    return [];
  }
}
