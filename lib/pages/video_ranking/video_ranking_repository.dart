import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:thaivtuberranking/services/result.dart';

import 'entity/video_ranking.dart';

enum VideoRankingType { OneDay, ThreeDay, SevenDay }

abstract class AbstractVideoRankingRepository {
  final http.Client client;
  const AbstractVideoRankingRepository(this.client);
  Future<Result> getVideoRanking(VideoRankingType type) async {
    throw UnimplementedError();
  }
}

class VideoRankingRepository extends AbstractVideoRankingRepository {
  Uri _oneDayRankingJson = Uri.parse(
      "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/one_day_ranking.json");
  Uri _threeDayRankingJson = Uri.parse(
      "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/three_days_ranking.json");
  Uri _sevenDayRankingJson = Uri.parse(
      "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/seven_days_ranking.json");

  VideoRankingRepository(http.Client client) : super(client);

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
      final response = await client.get(url);

      List<VideoRanking> _itemList = [];

      if (response.statusCode == 200) {
        final rankingList =
            json.decode(utf8.decode(response.bodyBytes))['result'];
        for (Map<String, dynamic> ranking in rankingList) {
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
