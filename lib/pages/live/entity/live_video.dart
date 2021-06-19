import 'package:intl/intl.dart';

enum LiveStatus { None, Live, Upcoming, Past }

class LiveVideo {
  final String id;
  final String title;
  final String channelId;
  final String channelTitle;
  final String channelThumbnailImageUrl;
  final bool channelIsRebranded;
  final String description;
  final String thumbnailImageUrl;
  final String publishedAt;
  final LiveStatus liveStatus;
  final String? liveSchedule;
  final String? liveStart;
  final String? liveEnd;
  final int? liveConcurrentViewerCount;
  final _formatter = new NumberFormat("#,###");

  LiveVideo(
      this.id,
      this.title,
      this.channelId,
      this.channelTitle,
      this.channelThumbnailImageUrl,
      this.channelIsRebranded,
      this.description,
      this.thumbnailImageUrl,
      this.publishedAt,
      this.liveStatus,
      this.liveSchedule,
      this.liveStart,
      this.liveEnd,
      this.liveConcurrentViewerCount);

  factory LiveVideo.fromJson(Map<String, dynamic> json) {
    return LiveVideo(
        json['id'],
        json['title'],
        json['channel_id'],
        json['channel_title'],
        json['channel_thumbnail_image_url'],
        json['channel_is_rebranded'] ?? false,
        json['description'],
        json['thumbnail_image_url'],
        json['published_at'],
        LiveStatus.values[json['live_status']],
        json['live_schedule'] ?? null,
        json['live_start'] ?? null,
        json['live_end'] ?? null,
        json['live_concurrent_viewer_count'] ?? null);
  }

  DateTime? getPublishedVideoAt() {
    if (publishedAt.isEmpty) {
      return null;
    }
    return DateTime.parse(publishedAt);
  }

  String getPublishedVideoAtString() {
    if (publishedAt.isEmpty) {
      return '-';
    }
    return DateFormat('d/M/yyyy HH:mm')
        .format(DateTime.parse(publishedAt).toLocal());
  }

  String getLiveStartAtString() {
    if (liveStart == null) {
      return '-';
    }
    return DateFormat('d/M/yyyy HH:mm')
        .format(DateTime.parse(liveStart!).toLocal());
  }

  String getLiveScheduleString() {
    if (liveSchedule == null) {
      return '-';
    }
    return DateFormat('d/M/yyyy HH:mm')
        .format(DateTime.parse(liveSchedule!).toLocal());
  }

  String getConcurrentViewerCount() {
    if (liveConcurrentViewerCount != null) {
      return _formatter.format(liveConcurrentViewerCount);
    } else {
      return '-';
    }
  }

  String getVideoUrl() {
    return 'http://youtube.com/watch?v=$id';
  }

  String makeSmallChannelThumbnailImageUrl() {
    return channelThumbnailImageUrl.replaceAll("s800", "s240");
  }
}
