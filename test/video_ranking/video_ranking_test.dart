import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking.dart';

void main() {
  final _json = '''
      {
         "id":"id",
         "title":"title",
         "channelId":"channelId",
         "channelTitle":"channelTitle",
         "viewCount":1000,
         "commentCount":1,
         "dislikeCount":null,
         "favoriteCount":0,
         "likeCount":0,
         "thumbnailImageUrl":"https://",
         "publishedAt":"2022-02-12T13:24:36Z",
         "isRebranded":false
      }
''';
  group('VideoRanking entity tests', () {
    test('fromJson initialization', () {
      final entity = VideoRanking.fromJson(json.decode(_json));
      expect(entity.id, 'id');
      expect(entity.title, 'title');
      expect(entity.channelId, 'channelId');
      expect(entity.channelTitle, 'channelTitle');
      expect(entity.viewCount, 1000);
      expect(entity.commentCount, 1);
      expect(entity.dislikeCount, 0);
      expect(entity.favoriteCount, 0);
      expect(entity.likeCount, 0);
      expect(entity.thumbnailImageUrl, 'https://');
      expect(entity.publishedAt, '2022-02-12T13:24:36Z');
      expect(entity.isRebranded, false);
    });
    test('computed properties', () {
      final entity = VideoRanking.fromJson(json.decode(_json));
      expect(entity.getPublishedVideoAtString(), '12/2/2022 22:24');
      expect(entity.getViews(), '1,000');
      expect(entity.getVideoUrl(), 'http://youtube.com/watch?v=id');
    });
  });
}
