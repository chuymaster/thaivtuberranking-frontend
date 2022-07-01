import 'package:flutter_test/flutter_test.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking_type.dart';

void main() {
  group('VideoRankingType enum tests', () {
    test('get jsonUrl', () {
      expect(VideoRankingType.OneDay.jsonUrl.toString(),
          "https://storage.googleapis.com/thaivtuberranking.appspot.com/v2/channel_data/one_day_ranking.json");
      expect(VideoRankingType.ThreeDay.jsonUrl.toString(),
          "https://storage.googleapis.com/thaivtuberranking.appspot.com/v2/channel_data/three_days_ranking.json");
      expect(VideoRankingType.SevenDay.jsonUrl.toString(),
          "https://storage.googleapis.com/thaivtuberranking.appspot.com/v2/channel_data/seven_days_ranking.json");
    });
  });
}
