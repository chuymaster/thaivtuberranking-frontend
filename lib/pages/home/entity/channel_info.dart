import 'package:intl/intl.dart';

class ChannelInfo {
  final String channelId;
  final String channelName;
  final int subscribers;
  final int views;
  final String iconUrl;
  final String? publishedAt;
  final String? lastPublishedVideoAt;
  final String description;
  final bool isRebranded;

  final int updatedAt;
  final _formatter = new NumberFormat("#,###");
  final _days_to_considered_channel_inactive = 90;

  ChannelInfo(
      {required this.channelId,
      required this.channelName,
      required this.subscribers,
      required this.views,
      required this.iconUrl,
      required this.publishedAt,
      required this.lastPublishedVideoAt,
      required this.description,
      required this.isRebranded,
      required this.updatedAt});

  factory ChannelInfo.fromJson(Map<String, dynamic> json) {
    return ChannelInfo(
        channelId: json['channel_id'],
        channelName: json['title'],
        subscribers: json['subscribers'] ?? 0,
        views: json['views'] ?? 0,
        iconUrl: json['thumbnail_icon_url'],
        publishedAt: json['published_at'],
        lastPublishedVideoAt: json['last_published_video_at'],
        description: json['description'] ?? "",
        isRebranded: json['is_rebranded'] ?? false,
        updatedAt: json['updated_at'] ?? 0);
  }

  String get channelUrl {
    return "https://youtube.com/channel/$channelId";
  }

  String get publishedAtString {
    if (publishedAt == null || publishedAt!.isEmpty) {
      return '-';
    }
    return DateFormat('d/M/yyyy')
        .format(DateTime.parse(publishedAt!).toLocal());
  }

  String get publishedAtStringForComparison {
    if (publishedAt == null || publishedAt!.isEmpty) {
      return '-';
    }
    return publishedAt!.split("T")[0];
  }

  /// Note: represents database updatedAt time, not YouTube updatedAt time
  String get updatedAtString {
    return DateFormat('d/M/yyyy HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(updatedAt));
  }

  String get lastPublishedVideoAtString {
    if (!this.hasVideo) {
      return '-';
    }
    return DateFormat('d/M/yyyy HH:mm')
        .format(DateTime.parse(lastPublishedVideoAt!).toLocal());
  }

  bool get hasVideo {
    if (lastPublishedVideoAt != null) {
      return lastPublishedVideoAt?.isNotEmpty ?? false;
    } else {
      return false;
    }
  }

  bool get isActive {
    if (hasVideo) {
      final now = DateTime.now();
      final lastPublishedVideoAtDateTime =
          DateTime.parse(lastPublishedVideoAt!);
      return now.difference(lastPublishedVideoAtDateTime).inDays <
          _days_to_considered_channel_inactive;
    } else {
      return false;
    }
  }

  String get subscribersString {
    return _formatter.format(subscribers);
  }

  String get viewsString {
    return _formatter.format(views);
  }

  /// Equatable

  @override
  bool operator ==(Object other) =>
      other is ChannelInfo && other.channelId == channelId;

  @override
  int get hashCode => channelId.hashCode;
}
