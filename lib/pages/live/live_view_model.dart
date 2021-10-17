import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/live/entity/live_video.dart';
import 'package:thaivtuberranking/pages/live/live_repository.dart';
import 'package:thaivtuberranking/services/result.dart';

class LiveViewModel extends ChangeNotifier {
  final OriginType originType;
  final LiveRepository _repository = LiveRepository();

  bool isLoading = false;
  String? errorMessage;

  List<LiveVideo> _liveVideos = [];

  LiveViewModel(this.originType);

  void getLiveVideos() async {
    isLoading = true;
    final result = await _repository.getLiveVideos();
    isLoading = false;
    if (result is SuccessState) {
      _liveVideos = result.value;
    } else if (result is ErrorState) {
      errorMessage = result.msg;
    }
    notifyListeners();
  }

  List<LiveVideo> get filteredLiveVideos {
    switch (originType) {
      case OriginType.OriginalOnly:
        return _liveVideos
            .where((element) => (!element.channelIsRebranded))
            .toList();
      case OriginType.All:
        return _liveVideos;
    }
  }

  void clearErrorMessage() {
    errorMessage = null;
  }
}
