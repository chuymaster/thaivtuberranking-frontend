import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:thaivtuberranking/pages/live/entity/live_video.dart';
import 'package:thaivtuberranking/services/result.dart';

class LiveRepository {
  Future<Result> getLiveVideos() async {
    Uri liveVideosUri = Uri.parse(
        "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/live_videos.json");

    try {
      final response = await http.get(liveVideosUri);

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
