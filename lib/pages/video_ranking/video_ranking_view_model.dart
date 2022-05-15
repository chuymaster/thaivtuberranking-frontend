import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_repository.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking_type.dart';
import 'package:thaivtuberranking/services/result.dart';

class VideoRankingViewModel extends ChangeNotifier {
  final AbstractVideoRankingRepository repository;
  final OriginType originType;
  final VideoRankingType videoRankingType;

  Result viewState = Result.loading();

  VideoRankingViewModel(
      {required this.videoRankingType,
      required this.originType,
      required this.repository});

  Future<void> getVideoRanking() async {
    viewState = Result.loading();
    notifyListeners();
    viewState = await repository.getVideoRanking(videoRankingType);
    notifyListeners();
  }

  List<VideoRanking> get filteredVideoRanking {
    if (viewState is SuccessState) {
      final List<VideoRanking> videoRanking = (viewState as SuccessState).value;
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
