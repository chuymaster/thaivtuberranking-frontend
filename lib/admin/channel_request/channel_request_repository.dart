import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import '../../../services/result.dart';
import '../authentication.dart';
import '../endpoint.dart';
import 'entity/channel_request.dart';

class ChannelRequestRepository {
  final int _limit = 100;

  Future<Result> getChannelRequests() async {
    Uri uri = Uri.parse(Endpoint.getChannelRequestList);
    try {
      final accessToken = await Authentication.instance.accessToken;
      final response = await http.get(uri,
          headers: {HttpHeaders.authorizationHeader: "Bearer $accessToken"});

      if (response.statusCode == 200) {
        final List<dynamic> jsons =
            json.decode(utf8.decode(response.bodyBytes));
        List<ChannelRequest> channelRequests =
            jsons.map((e) => ChannelRequest.fromJson(e)).toList();
        channelRequests.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        return Result<List<ChannelRequest>>.success(
            channelRequests.take(_limit).toList());
      } else {
        return Result.error(response.statusCode.toString());
      }
    } catch (error) {
      return Result.error(error.toString());
    }
  }

  Future<Result> postChannelRequest(ChannelRequest channelRequest) async {
    Uri uri = Uri.parse(Endpoint.postChannelRequest);
    try {
      final accessToken = await Authentication.instance.accessToken;
      final response = await http.post(uri,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $accessToken"
          },
          body: channelRequest.toUpdateChannelRequestJson());

      if (response.statusCode == 200) {
        return Result<void>.success(null);
      } else {
        return Result.error(response.statusCode.toString());
      }
    } catch (error) {
      return Result.error(error.toString());
    }
  }

  Future<Result> deleteChannelRequest(String channelId) async {
    Uri uri = Uri.parse(Endpoint.deleteChannelRequest);
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

  Future<Result> postChannel(ChannelRequest channelRequest) async {
    Uri uri = Uri.parse(Endpoint.postChannel);
    try {
      final accessToken = await Authentication.instance.accessToken;
      final response = await http.post(uri,
          headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
            HttpHeaders.acceptHeader: "application/json",
            HttpHeaders.authorizationHeader: "Bearer $accessToken"
          },
          body: channelRequest.toNewChannelJson());

      if (response.statusCode == 200) {
        return Result<void>.success(null);
      } else {
        return Result.error(response.statusCode.toString());
      }
    } catch (error) {
      return Result.error(error.toString());
    }
  }
}
