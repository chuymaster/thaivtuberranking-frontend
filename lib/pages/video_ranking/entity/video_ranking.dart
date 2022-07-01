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
        json['channel_id'],
        json['channel_title'],
        json['view_count'] ?? 0,
        json['comment_count'] ?? 0,
        json['dislike_count'] ?? 0,
        json['favorite_count'] ?? 0,
        json["like_count"] ?? 0,
        json['thumbnail_image_url'],
        json['published_at'],
        json['is_rebranded']);
    return videoRanking;
  }

  String get publishedAtString {
    if (publishedAt.isEmpty) {
      return '-';
    }
    return DateFormat('d/M/yyyy HH:mm')
        .format(DateTime.parse(publishedAt).toLocal());
  }

  String get views {
    return _formatter.format(viewCount);
  }

  String get videoUrl {
    return 'http://youtube.com/watch?v=$id';
  }
}
