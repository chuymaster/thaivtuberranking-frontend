import 'package:thaivtuberranking/pages/channel/entity/channel_chart_data.dart';
import '../home/entity/channel_info.dart';
import '../../services/result.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ChannelRepository {
  Future<Result> getChannelInfo(String channelId) async {
    Uri channelDetailUri = Uri.parse(
        "https://storage.googleapis.com/thaivtuberranking.appspot.com/v2/channel_data/detail/$channelId.json");
    try {
      final response = await http.get(channelDetailUri);

      if (response.statusCode == 200) {
        final channelInfo =
            json.decode(utf8.decode(response.bodyBytes))['result'];
        return Result<ChannelInfo>.success(ChannelInfo.fromJson(channelInfo));
      } else {
        return Result.error(response.statusCode.toString());
      }
    } catch (error) {
      return Result.error(error.toString());
    }
  }

  Future<Result> getChannelChartData(String channelId) async {
    Uri url = Uri.parse(
        "https://storage.googleapis.com/thaivtuberranking.appspot.com/v2/channel_data/chart_data/$channelId.json");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes))['result'];
        return Result<ChannelChartData>.success(
            ChannelChartData.fromJson(data));
      } else {
        return Result.error(response.statusCode.toString());
      }
    } catch (error) {
      return Result.error(error.toString());
    }
  }
}
