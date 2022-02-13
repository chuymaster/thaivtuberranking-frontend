import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_repository.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_view_model.dart';
import 'package:thaivtuberranking/services/result.dart';

import '../http_client.mocks.dart';

void main() {
  group('Initialization', () {
    test('initial values are as expected', () {
      final viewModel = VideoRankingViewModel(
          videoRankingType: VideoRankingType.OneDay,
          originType: OriginType.OriginalOnly,
          repository: MockVideoRankingRepository(MockClient()));
      expect(viewModel.originType, OriginType.OriginalOnly);
      expect(viewModel.videoRankingType, VideoRankingType.OneDay);
      expect(viewModel.viewState, isA<LoadingState>());
    });
  });
  group('getVideoRanking', () {
    test('viewState is updated correctly', () async {
      final viewModel = VideoRankingViewModel(
          videoRankingType: VideoRankingType.OneDay,
          originType: OriginType.OriginalOnly,
          repository: MockVideoRankingRepository(MockClient()));

      List<Result> results = [];
      viewModel.addListener(() {
        results.add(viewModel.viewState);
      });

      await viewModel.getVideoRanking();

      expect(results, [isA<LoadingState>(), isA<SuccessState>()]);
      List<VideoRanking> videoRankingList =
          (viewModel.viewState as SuccessState).value;
      expect(videoRankingList.length, 2);
      expect(videoRankingList[0].id, "id1");
    });
  });
  group('filteredVideoRanking', () {
    test('video ranking is filtered to OriginalOnly', () async {
      final viewModel = VideoRankingViewModel(
          videoRankingType: VideoRankingType.OneDay,
          originType: OriginType.OriginalOnly,
          repository: MockVideoRankingRepository(MockClient()));

      await viewModel.getVideoRanking();

      expect(viewModel.filteredVideoRanking.length, 1);
      expect(viewModel.filteredVideoRanking[0].id, "id2");
      expect(viewModel.filteredVideoRanking[0].isRebranded, false);
    });
    test('video ranking is filtered to All', () async {
      final viewModel = VideoRankingViewModel(
          videoRankingType: VideoRankingType.OneDay,
          originType: OriginType.All,
          repository: MockVideoRankingRepository(MockClient()));

      await viewModel.getVideoRanking();

      expect(viewModel.filteredVideoRanking.length, 2);
      expect(viewModel.filteredVideoRanking[0].id, "id1");
      expect(viewModel.filteredVideoRanking[0].isRebranded, true);
      expect(viewModel.filteredVideoRanking[1].id, "id2");
      expect(viewModel.filteredVideoRanking[1].isRebranded, false);
    });
  });
}

class MockVideoRankingRepository implements AbstractVideoRankingRepository {
  final http.Client client;
  MockVideoRankingRepository(this.client);

  Future<Result> getVideoRanking(VideoRankingType type) async {
    List<VideoRanking> videoRankingList = [];
    videoRankingList.add(VideoRanking("id1", "title", "channelId",
        "channelTitle", 1, 1, 1, 1, 1, "https://", "", true));
    videoRankingList.add(VideoRanking("id2", "title", "channelId",
        "channelTitle", 1, 1, 1, 1, 1, "https://", "", false));
    return Result.success(videoRankingList);
  }
}
