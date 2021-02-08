import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:thaivtuberranking/services/result.dart';

import 'entity/video_ranking.dart';

enum VideoRankingType { OneDay, ThreeDay, SevenDay }

class VideoRankingRepository {
  String _oneDayRankingJson =
      "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/one_day_ranking.json";
  String _threeDayRankingJson =
      "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/three_days_ranking.json";
  String _sevenDayRankingJson =
      "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/seven_days_ranking.json";

  Future<Result> getVideoRanking(VideoRankingType type) async {
    var url = _oneDayRankingJson;
    switch (type) {
      case VideoRankingType.OneDay:
        url = _oneDayRankingJson;
        break;
      case VideoRankingType.ThreeDay:
        url = _threeDayRankingJson;
        break;
      case VideoRankingType.SevenDay:
        url = _sevenDayRankingJson;
        break;
    }

    try {
      final response = await http.get(url);

      List<VideoRanking> _itemList = [];

      if (response.statusCode == 200) {
        final rankingList =
            json.decode(utf8.decode(response.bodyBytes))['result'];
        for (Map ranking in rankingList) {
          var info = VideoRanking.fromJson(ranking);
          _itemList.add(info);
        }
      } else {
        return Result.error(response.statusCode.toString());
      }
      return Result<List<VideoRanking>>.success(_itemList);
    } catch (error) {
      return Result.error(error.toString());
    }
  }
}
