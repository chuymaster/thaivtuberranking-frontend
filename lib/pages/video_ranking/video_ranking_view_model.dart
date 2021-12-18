import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_repository.dart';
import 'package:thaivtuberranking/services/result.dart';

class VideoRankingViewModel extends ChangeNotifier {
  final OriginType originType;
  final VideoRankingType videoRankingType;
  final VideoRankingRepository _repository = VideoRankingRepository();

  Result viewState = Result.loading();

  VideoRankingViewModel(this.videoRankingType, this.originType);

  void getVideoRanking() async {
    viewState = Result.loading();
    viewState = await _repository.getVideoRanking(videoRankingType);
    notifyListeners();
  }

  List<VideoRanking> get filteredVideoRanking {
    if (viewState is SuccessState<List<VideoRanking>>) {
      final videoRanking =
          (viewState as SuccessState<List<VideoRanking>>).value;
      switch (originType) {
        case OriginType.OriginalOnly:
          return videoRanking
              .where((element) => (!element.isRebranded))
              .toList();
        case OriginType.All:
          return videoRanking;
      }
    }
    return [];
  }
}
