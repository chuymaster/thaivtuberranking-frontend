import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:thaivtuberranking/services/result.dart';

import 'entity/channel_info.dart';

class HomeRepository {
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
        "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/list.json");

    try {
      final response = await http.get(channelListJson);

      List<ChannelInfo> _itemList = [];

      if (response.statusCode == 200) {
        final channelListChunk =
            json.decode(utf8.decode(response.bodyBytes))['result'];
        for (List<dynamic> channelList in channelListChunk) {
          for (Map<String, dynamic> channel in channelList) {
            var info = ChannelInfo.fromJson(channel);
            _itemList.add(info);
          }
        }
      } else {
        return Result.error(response.statusCode.toString());
      }

      /// Remove duplicated channel ID
      Map<String, ChannelInfo> mp = {};
      for (var item in _itemList) {
        mp[item.channelId] = item;
      }
      _itemList = mp.values.toList();

      return Result<List<ChannelInfo>>.success(_itemList);
    } catch (error) {
      return Result.error(error.toString());
    }
  }
}
