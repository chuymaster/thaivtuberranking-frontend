import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:thaivtuberranking/pages/live/entity/live_video.dart';
import 'package:thaivtuberranking/services/result.dart';

enum LiveVideoType { Live, Upcoming }

class LiveRepository {
  Future<Result> getLiveVideos(LiveVideoType type) async {
    String url =
        "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/";

    switch (type) {
      case LiveVideoType.Live:
        url += "live_videos.json";
        break;
      case LiveVideoType.Upcoming:
        url += "upcoming_videos.json";
        break;
    }

    Uri uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      List<LiveVideo> liveVideos = [];

      if (response.statusCode == 200) {
        final liveVideosJsons =
            json.decode(utf8.decode(response.bodyBytes))['result'];
        for (final json in liveVideosJsons) {
          liveVideos.add(LiveVideo.fromJson(json, "title", false));
        }
      } else {
        return Result.error(response.statusCode.toString());
      }

      return Result<List<LiveVideo>>.success(liveVideos);
    } catch (error) {
      return Result.error(error.toString());
    }
  }
}
