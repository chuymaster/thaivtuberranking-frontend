import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_repository.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking_type.dart';
import 'package:thaivtuberranking/services/result.dart';

import '../http_client.mocks.dart';

void main() {
  String _mockJson = '''
{
   "result":[
      {
         "id":"id",
         "title":"title",
         "channel_id":"channelId",
         "channel_title":"channelTitle",
         "view_count":1,
         "comment_count":1,
         "dislike_count":0,
         "favorite_count":0,
         "like_count":0,
         "thumbnail_image_url":"https://",
         "published_at":"2022-02-12T13:24:36Z",
         "is_rebranded":false
      }
   ]
}
    ''';

  group('getVideoRanking', () {
    test(
        'returns one-day video ranking if the http call completes successfully',
        () async {
      final client = MockClient();
      final repository = VideoRankingRepository(client);

      Uri url = Uri.parse(
          "https://storage.googleapis.com/thaivtuberranking.appspot.com/v2/channel_data/one_day_ranking.json");

      when(client.get(url))
          .thenAnswer((_) async => http.Response(_mockJson, 200));

      final result = await repository.getVideoRanking(VideoRankingType.OneDay);
      expect(result, isA<SuccessState<dynamic>>());

      final List<VideoRanking> videoRankingList =
          (result as SuccessState).value;
      expect(videoRankingList.length, 1);
      expect(videoRankingList[0].id, "id");
    });
    test(
        'returns three-day video ranking if the http call completes successfully',
        () async {
      final client = MockClient();
      final repository = VideoRankingRepository(client);

      Uri url = Uri.parse(
          "https://storage.googleapis.com/thaivtuberranking.appspot.com/v2/channel_data/three_days_ranking.json");

      when(client.get(url))
          .thenAnswer((_) async => http.Response(_mockJson, 200));

      final result =
          await repository.getVideoRanking(VideoRankingType.ThreeDay);
      expect(result, isA<SuccessState<dynamic>>());

      final List<VideoRanking> videoRankingList =
          (result as SuccessState).value;
      expect(videoRankingList.length, 1);
      expect(videoRankingList[0].id, "id");
    });
    test(
        'returns seven-day video ranking if the http call completes successfully',
        () async {
      final client = MockClient();
      final repository = VideoRankingRepository(client);

      Uri url = Uri.parse(
          "https://storage.googleapis.com/thaivtuberranking.appspot.com/v2/channel_data/seven_days_ranking.json");

      when(client.get(url))
          .thenAnswer((_) async => http.Response(_mockJson, 200));

      final result =
          await repository.getVideoRanking(VideoRankingType.SevenDay);
      expect(result, isA<SuccessState<dynamic>>());

      final List<VideoRanking> videoRankingList =
          (result as SuccessState).value;
      expect(videoRankingList.length, 1);
      expect(videoRankingList[0].id, "id");
    });
    test('returns error if http call completes with error', () async {
      final client = MockClient();
      final repositoory = VideoRankingRepository(client);

      Uri url = Uri.parse(
          "https://storage.googleapis.com/thaivtuberranking.appspot.com/v2/channel_data/one_day_ranking.json");

      when(client.get(url)).thenAnswer((_) async => http.Response('', 500));

      final result = await repositoory.getVideoRanking(VideoRankingType.OneDay);
      expect(result, isA<ErrorState<dynamic>>());
      expect((result as ErrorState).msg, '500');
    });
  });
}
