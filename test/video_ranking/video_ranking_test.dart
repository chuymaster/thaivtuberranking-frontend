import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking.dart';

void main() {
  final _json = '''
      {
         "id":"id",
         "title":"title",
         "channel_id":"channelId",
         "channel_title":"channelTitle",
         "view_count":1000,
         "comment_count":1,
         "dislike_count":null,
         "favorite_count":0,
         "like_count":0,
         "thumbnail_image_url":"https://",
         "published_at":"2022-02-12T13:24:36Z",
         "is_rebranded":false
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
      final expected = DateFormat('d/M/yyyy HH:mm')
          .format(DateTime.parse('2022-02-12T13:24:36Z').toLocal());
      expect(entity.publishedAtString, expected);
      expect(entity.views, '1,000');
      expect(entity.videoUrl, 'http://youtube.com/watch?v=id');
    });
  });
}
