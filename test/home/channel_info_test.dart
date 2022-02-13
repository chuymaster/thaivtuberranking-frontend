import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
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
      expect(entity.totalSubscribers, 1000);
      expect(entity.totalViews, 1000);
      expect(entity.iconUrl, 'https://');
      expect(entity.publishedAt, "2020-11-11T12:58:49.610362Z");
      expect(entity.lastPublishedVideoAt, "2021-12-31T13:08:37Z");
      expect(entity.description, 'test');
      expect(entity.isRebranded, false);
      expect(entity.updatedAt, 1641006011156);
    });
    test('computed properties', () {
      final entity = ChannelInfo.fromJson(json.decode(_json));
      expect(entity.getChannelUrl(), "https://youtube.com/channel/channelId");
      expect(entity.getPublishedAt(), "11/11/2020");
      expect(entity.getPublishedAtForComparison(), "2020-11-11");
      expect(entity.getUpdatedAt(), "1/1/2022 12:00");
      expect(entity.getLastPublishedVideoAtString(), "31/12/2021 22:08");
      expect(entity.getSubscribers(), '1,000');
      expect(entity.getViews(), '1,000');
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
      expect(entity.getPublishedAt(), '-');
      expect(entity.getPublishedAtForComparison(), '-');
      expect(entity.getLastPublishedVideoAtString(), '-');
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
      expect(entity.getPublishedAt(), '-');
      expect(entity.getPublishedAtForComparison(), '-');
      expect(entity.getLastPublishedVideoAtString(), '-');
    });
  });
}
