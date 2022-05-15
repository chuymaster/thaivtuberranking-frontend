import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:thaivtuberranking/services/result.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking_type.dart';

import 'entity/video_ranking.dart';

abstract class AbstractVideoRankingRepository {
  final http.Client client;
  const AbstractVideoRankingRepository(this.client);
  Future<Result> getVideoRanking(VideoRankingType type) async {
    throw UnimplementedError();
  }
}

class VideoRankingRepository implements AbstractVideoRankingRepository {
  final http.Client client;

  VideoRankingRepository(this.client);

  Future<Result> getVideoRanking(VideoRankingType type) async {
    try {
      final response = await client.get(type.jsonUrl);

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
