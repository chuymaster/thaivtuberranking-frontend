import 'package:intl/intl.dart';

class VideoRanking {
  final String id;
  final String title;
  final String channelId;
  final String channelTitle;
  final int viewCount;
  final int commentCount;
  final int dislikeCount;
  final int favoriteCount;
  final int likeCount;
  final String thumbnailImageUrl;
  final String publishedAt;
  final bool isRebranded;
  final _formatter = new NumberFormat("#,###");

  VideoRanking(
      this.id,
      this.title,
      this.channelId,
      this.channelTitle,
      this.viewCount,
      this.commentCount,
      this.dislikeCount,
      this.favoriteCount,
      this.likeCount,
      this.thumbnailImageUrl,
      this.publishedAt,
      this.isRebranded);

  factory VideoRanking.fromJson(Map<String, dynamic> json) {
    var videoRanking = VideoRanking(
        json['id'],
        json['title'],
        json['channelId'],
        json['channelTitle'],
        json['viewCount'] ?? 0,
        json['commentCount'] ?? 0,
        json['dislikeCount'] ?? 0,
        json['favoriteCount'] ?? 0,
        json["likeCount"] ?? 0,
        json['thumbnailImageUrl'],
        json['publishedAt'],
        json['isRebranded']);
    return videoRanking;
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

  String getViews() {
    return _formatter.format(viewCount);
  }

  String getVideoUrl() {
    return 'http://youtube.com/watch?v=$id';
  }
}
