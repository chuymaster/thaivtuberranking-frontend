import 'package:intl/intl.dart';

class ChannelRequest {
  final String channelId;
  final String title;
  final String thumbnailImageUrl;
  ChannelType type;
  ChannelRequestStatus status;
  final int updatedAt;

  bool isSelected = false;

  ChannelRequest(
      {required this.channelId,
      required this.title,
      required this.thumbnailImageUrl,
      required this.type,
      required this.status,
      required this.updatedAt});

  factory ChannelRequest.fromJson(Map<String, dynamic> json) {
    ChannelType type = ChannelType.original;
    ChannelRequestStatus status = ChannelRequestStatus.unconfirmed;

    switch (json['type'] as int) {
      case 1:
        type = ChannelType.original;
        break;
      case 2:
        type = ChannelType.half;
        break;
    }

    switch (json['status'] as int) {
      case 1:
        status = ChannelRequestStatus.unconfirmed;
        break;
      case 2:
        status = ChannelRequestStatus.accepted;
        break;
      case 3:
        status = ChannelRequestStatus.pending;
        break;
      case 4:
        status = ChannelRequestStatus.rejected;
        break;
    }

    return ChannelRequest(
        channelId: json['channel_id'] as String,
        title: json['title'] as String,
        thumbnailImageUrl: json['thumbnail_image_url'] as String,
        type: type,
        status: status,
        updatedAt: json['updated_at'] ?? 0);
  }

  String get channelUrl {
    return "https://youtube.com/channel/$channelId";
  }

  String get displayUpdatedAt {
    return DateFormat('d/M/yyyy HH:mm')
        .format(DateTime.fromMillisecondsSinceEpoch(updatedAt));
  }

  Map<String, dynamic> toUpdateChannelRequestJson() => {
        'channel_id': channelId,
        'type': _channelTypeJsonValue,
        'status': _channelStatusJsonValue
      };

  Map<String, dynamic> toNewChannelJson() => {
        'channel_id': channelId,
        'title': title,
        'thumbnail_image_url': thumbnailImageUrl,
        'type': _channelTypeJsonValue
      };

  String get _channelTypeJsonValue {
    switch (type) {
      case ChannelType.original:
        return "1";
      case ChannelType.half:
        return "2";
    }
  }

  String get _channelStatusJsonValue {
    switch (status) {
      case ChannelRequestStatus.unconfirmed:
        return "1";
      case ChannelRequestStatus.accepted:
        return "2";
      case ChannelRequestStatus.pending:
        return "3";
      case ChannelRequestStatus.rejected:
        return "4";
    }
  }
}

enum ChannelType { original, half }

enum ChannelRequestStatus { unconfirmed, accepted, pending, rejected }
