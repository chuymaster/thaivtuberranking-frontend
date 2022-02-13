import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
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
          VideoRankingType.OneDay, OriginType.OriginalOnly);
      expect(viewModel.originType, OriginType.OriginalOnly);
      expect(viewModel.videoRankingType, VideoRankingType.OneDay);
      expect(viewModel.viewState, isA<LoadingState>());
    });
  });
  group('getVideoRanking', () {
    test('viewState is updated correctly', () async {
      final viewModel = VideoRankingViewModel(
          VideoRankingType.OneDay, OriginType.OriginalOnly);
      viewModel.repository = MockVideoRankingRepository(MockClient());

      List<Result> results = [];
      viewModel.addListener(() {
        results.add(viewModel.viewState);
      });

      await viewModel.getVideoRanking();

      expect(results, [isA<LoadingState>(), isA<SuccessState>()]);
    });
  });
}

class MockVideoRankingRepository extends AbstractVideoRankingRepository {
  MockVideoRankingRepository(Client client) : super(client);

  @override
  Future<Result> getVideoRanking(VideoRankingType type) async {
    List<VideoRanking> videoRankingList = [];
    videoRankingList.add(VideoRanking("id", "title", "channelId",
        "channelTitle", 1, 1, 1, 1, 1, "https://", "", false));
    return Result.success(videoRankingList);
  }
}
