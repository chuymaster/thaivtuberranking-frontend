import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';

void main() {
  final _json = '''
    {
      "channel_id":"channelId",
      "title":"test",
      "description":"test",
      "thumbnail_icon_url":"https://",
      "subscribers":1000,
      "views":1000,
      "comments":null,
      "videos":1,
      "uploads":"UU",
      "published_at":"2020-11-11T12:58:49.610362Z",
      "last_published_video_at":"2021-12-31T13:08:37Z",
      "updated_at":1641006011156,
      "is_rebranded":false
    }
''';
  group('ChannelInfo entity tests', () {
    test('fromJson initialization', () {
      final entity = ChannelInfo.fromJson(json.decode(_json));
      expect(entity.channelId, 'channelId');
      expect(entity.channelName, 'test');
      expect(entity.subscribers, 1000);
      expect(entity.views, 1000);
      expect(entity.iconUrl, 'https://');
      expect(entity.publishedAt, "2020-11-11T12:58:49.610362Z");
      expect(entity.lastPublishedVideoAt, "2021-12-31T13:08:37Z");
      expect(entity.description, 'test');
      expect(entity.isRebranded, false);
      expect(entity.updatedAt, 1641006011156);
    });
    test('computed properties', () {
      final entity = ChannelInfo.fromJson(json.decode(_json));
      final published = DateFormat('d/M/yyyy')
          .format(DateTime.parse('2020-11-11T12:58:49.610362Z').toLocal());
      final updated = DateFormat('d/M/yyyy HH:mm')
          .format(DateTime.fromMillisecondsSinceEpoch(1641006011156));
      final lastPublished = DateFormat('d/M/yyyy HH:mm')
          .format(DateTime.parse('2021-12-31T13:08:37Z').toLocal());
      expect(entity.channelUrl, "https://youtube.com/channel/channelId");
      expect(entity.publishedAtString, published);
      expect(entity.publishedAtStringForComparison, "2020-11-11");
      expect(entity.updatedAtString, updated);
      expect(entity.lastPublishedVideoAtString, lastPublished);
      expect(entity.subscribersString, '1,000');
      expect(entity.viewsString, '1,000');
    });
    test('published at conversions with null value', () {
      final _json = '''
    {
      "channel_id":"channelId",
      "title":"test",
      "description":"test",
      "thumbnail_icon_url":"https://",
      "subscribers":1000,
      "views":1000,
      "comments":null,
      "videos":1,
      "uploads":"UU",
      "published_at":null,
      "last_published_video_at":null,
      "updated_at":1641006011156,
      "is_rebranded":false
    }
''';
      final entity = ChannelInfo.fromJson(json.decode(_json));
      expect(entity.publishedAtString, '-');
      expect(entity.publishedAtStringForComparison, '-');
      expect(entity.lastPublishedVideoAtString, '-');
    });
    test('published at conversions with empty string', () {
      final _json = '''
    {
      "channel_id":"channelId",
      "title":"test",
      "description":"test",
      "thumbnail_icon_url":"https://",
      "subscribers":1000,
      "views":1000,
      "comments":null,
      "videos":1,
      "uploads":"UU",
      "published_at":"",
      "last_published_video_at":"",
      "updated_at":1641006011156,
      "is_rebranded":false
    }
''';
      final entity = ChannelInfo.fromJson(json.decode(_json));
      expect(entity.publishedAtString, '-');
      expect(entity.publishedAtStringForComparison, '-');
      expect(entity.lastPublishedVideoAtString, '-');
    });
  });
}
