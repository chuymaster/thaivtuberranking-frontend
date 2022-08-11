import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../../../services/result.dart';
import '../authentication.dart';
import '../endpoint.dart';
import 'entity/channel.dart';

class ChannelManagementRepository {
  Future<Result> getChannelList() async {
    Uri uri = Uri.parse(Endpoint.getChannelList);
    try {
      final accessToken = await Authentication.instance.accessToken;
      final response = await http.get(uri,
          headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"});

      if (response.statusCode == 200) {
        final List<dynamic> jsons =
            json.decode(utf8.decode(response.bodyBytes));
        List<Channel> channelList =
            jsons.map((e) => Channel.fromJson(e)).toList();
        return Result<List<Channel>>.success(channelList.toList());
      } else {
        return Result.error(response.statusCode.toString());
      }
    } catch (error) {
      return Result.error(error.toString());
    }
  }

  Future<Result> postChannel(Channel channel) async {
    Uri uri = Uri.parse(Endpoint.postChannel);
    try {
      final accessToken = await Authentication.instance.accessToken;
      final response = await http.post(uri,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $accessToken"
          },
          body: channel.toUpdateChannelJson());

      if (response.statusCode == 200) {
        return Result<void>.success(null);
      } else {
        return Result.error(response.statusCode.toString());
      }
    } catch (error) {
      return Result.error(error.toString());
    }
  }

  Future<Result> deleteChannel(String channelId) async {
    Uri uri = Uri.parse(Endpoint.deleteChannel);
    try {
      final accessToken = await Authentication.instance.accessToken;
      final response = await http.post(uri, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $accessToken"
      }, body: {
        "channel_id": channelId
      });

      if (response.statusCode == 200) {
        return Result<void>.success(null);
      } else {
        return Result.error(response.statusCode.toString());
      }
    } catch (error) {
      return Result.error(error.toString());
    }
  }

  Future<Result> deleteObsoleteChannels() async {
    Uri uri = Uri.parse(Endpoint.deleteObsoleteChannels);
    try {
      final accessToken = await Authentication.instance.accessToken;
      final response = await http.post(uri, headers: {
        HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
        HttpHeaders.acceptHeader: "application/json",
        HttpHeaders.authorizationHeader: "Bearer $accessToken"
      });

      if (response.statusCode == 200) {
        return Result<String>.success(response.body);
      } else {
        return Result.error(response.statusCode.toString());
      }
    } catch (error) {
      return Result.error(error.toString());
    }
  }
}
