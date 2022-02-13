import 'package:intl/intl.dart';

class ChannelInfo {
  final String channelId;
  final String channelName;
  final int totalSubscribers;
  final int totalViews;
  final String iconUrl;
  final String? publishedAt;
  final String? lastPublishedVideoAt;
  final String description;
  final bool isRebranded;

  final int updatedAt;
  String featureVideoUrl = '';
  String twitterUserName = '';
  String facebookUserName = '';
  String facebookDisplayName = '';
  String contentDescription = '';
  String channelDescriptionDate = '';
  final _formatter = new NumberFormat("#,###");

  ChannelInfo(
      {required this.channelId,
      required this.channelName,
      required this.totalSubscribers,
      required this.totalViews,
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
        totalSubscribers: json['subscribers'] ?? 0,
        totalViews: json['views'] ?? 0,
        iconUrl: json['thumbnail_icon_url'],
        publishedAt: json['published_at'],
        lastPublishedVideoAt: json['last_published_video_at'],
        description: json['description'] ?? "",
        isRebranded: json['is_rebranded'] ?? false,
        updatedAt: json['updated_at'] ?? 0);
  }

  String getChannelUrl() {
    return "https://youtube.com/channel/$channelId";
  }

  String getPublishedAt() {
    if (publishedAt == null || publishedAt!.isEmpty) {
      return '-';
    }
    return DateFormat('d/M/yyyy')
        .format(DateTime.parse(publishedAt!).toLocal());
  }

  String getPublishedAtForComparison() {
    if (publishedAt == null || publishedAt!.isEmpty) {
      return '-';
    }
    return publishedAt!.split("T")[0];
  }

  /// เวลาที่ข้อมูลถูกอัพเดตบน database ไม่เกี่ยวกับข้อมูลยูทูป
  String getUpdatedAt() {
    return DateFormat('d/M/yyyy HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(updatedAt));
  }

  String getLastPublishedVideoAtString() {
    if (lastPublishedVideoAt == null || lastPublishedVideoAt!.isEmpty) {
      return '-';
    }
    return DateFormat('d/M/yyyy HH:mm')
        .format(DateTime.parse(lastPublishedVideoAt!).toLocal());
  }

  String getSubscribers() {
    return _formatter.format(totalSubscribers);
  }

  String getViews() {
    return _formatter.format(totalViews);
  }

  /// Equatable

  @override
  bool operator ==(Object other) =>
      other is ChannelInfo && other.channelId == channelId;

  @override
  int get hashCode => channelId.hashCode;
}
