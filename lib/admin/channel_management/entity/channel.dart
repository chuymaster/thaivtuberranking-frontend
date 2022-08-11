class Channel {
  final String channelId;
  final String title;
  final String thumbnailImageUrl;
  ChannelType type;

  bool isSelected = false;

  Channel({
    required this.channelId,
    required this.title,
    required this.thumbnailImageUrl,
    required this.type,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    ChannelType type = ChannelType.original;

    switch (json['is_rebranded'] as bool) {
      case true:
        type = ChannelType.original;
        break;
      case false:
        type = ChannelType.half;
        break;
    }
    return Channel(
        channelId: json['channel_id'] as String,
        title: json['title'] as String,
        thumbnailImageUrl: json['thumbnail_image_url'] as String,
        type: type);
  }

  String get channelUrl {
    return "https://youtube.com/channel/$channelId";
  }

  Map<String, dynamic> toUpdateChannelJson() =>
      {'channel_id': channelId, 'type': _channelTypeJsonValue};

  Map<String, dynamic> toDeleteChannelJson() => {'channel_id': channelId};

  String get _channelTypeJsonValue {
    switch (type) {
      case ChannelType.original:
        return "1";
      case ChannelType.half:
        return "2";
    }
  }
}

enum ChannelType { original, half }
