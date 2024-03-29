import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:thaivtuberranking/services/result.dart';

class ChannelRegistrationRepository {
  Future<Result> sendAddChannelRequest(String channelId, String type) async {
    Uri addChannelRequestUrl = Uri.parse(
        "https://us-central1-thaivtuberranking.cloudfunctions.net/postChannelRequest");
    try {
      Response response = await http.post(addChannelRequestUrl,
          body: {'channel_id': channelId, 'type': type});

      if (response.statusCode == 200) {
        return Result<void>.success(Null);
      } else {
        return Result.error(response.statusCode.toString());
      }
    } catch (error) {
      return Result.error(error.toString());
    }
  }
}
