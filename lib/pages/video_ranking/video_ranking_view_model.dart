import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_repository.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:http/http.dart' as http;

class VideoRankingViewModel extends ChangeNotifier {
  AbstractVideoRankingRepository repository =
      VideoRankingRepository(http.Client());
  final OriginType originType;
  final VideoRankingType videoRankingType;

  Result viewState = Result.loading();

  VideoRankingViewModel(this.videoRankingType, this.originType);

  Future<void> getVideoRanking() async {
    viewState = Result.loading();
    notifyListeners();
    viewState = await repository.getVideoRanking(videoRankingType);
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
