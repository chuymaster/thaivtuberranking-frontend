import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/services/result.dart';

abstract class AbstractChannelListRepository {
  final http.Client client;
  const AbstractChannelListRepository(this.client);
  Future<Result> getChannelList() async {
    throw UnimplementedError();
  }
}

class ChannelListRepository implements AbstractChannelListRepository {
  final http.Client client;
  ChannelListRepository(this.client);

  Future<Result> getChannelList() async {
    // Must set CORS for storage -  https://firebase.google.com/docs/storage/web/download-files
    /** 
        [
          {
            "origin": ["*"],
            "method": ["GET"],
            "maxAgeSeconds": 3600
          }
        ]
        gsutil cors set cors.json gs://thaivtuberranking.appspot.com
     */
    Uri channelListJson = Uri.parse(
        "https://storage.googleapis.com/thaivtuberranking.appspot.com/v2/channel_data/simple_list.json");

    try {
      final response = await client.get(channelListJson);

      if (response.statusCode == 200) {
        final List<dynamic> channelInfoList =
            json.decode(utf8.decode(response.bodyBytes))['result'];
        return Result<List<ChannelInfo>>.success(
            channelInfoList.map((e) => ChannelInfo.fromJson(e)).toList());
      } else {
        return Result.error(response.statusCode.toString());
      }
    } catch (error) {
      return Result.error(error.toString());
    }
  }
}
