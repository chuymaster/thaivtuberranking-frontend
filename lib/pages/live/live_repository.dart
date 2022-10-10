import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:thaivtuberranking/pages/live/entity/live_video.dart';
import 'package:thaivtuberranking/services/result.dart';

class LiveRepository {
  Future<Result> getLiveVideos() async {
    Uri liveUri = Uri.parse(
        "https://storage.googleapis.com/thaivtuberranking.appspot.com/v2/channel_data/live_videos.json");
    Uri upcomingUri = Uri.parse(
        "https://storage.googleapis.com/thaivtuberranking.appspot.com/v2/channel_data/upcoming_videos.json");

    try {
      final responses =
          await Future.wait([http.get(liveUri), http.get(upcomingUri)]);

      List<LiveVideo> liveVideos = _getLiveVideosFromResponse(responses[0]);
      List<LiveVideo> upcomingVideos = _getLiveVideosFromResponse(responses[1]);

      return Result<List<LiveVideo>>.success(liveVideos + upcomingVideos);
    } catch (error) {
      return Result.error(error.toString());
    }
  }

  List<LiveVideo> _getLiveVideosFromResponse(http.Response response) {
    List<LiveVideo> liveVideos = [];
    if (response.statusCode == 200) {
      final liveVideosJsons =
          json.decode(utf8.decode(response.bodyBytes))['result'];
      for (final json in liveVideosJsons) {
        liveVideos.add(LiveVideo.fromJson(json));
      }
      return liveVideos;
    } else {
      throw ("Response error: " + response.statusCode.toString());
    }
  }
}
