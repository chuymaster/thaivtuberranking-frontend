import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thaivtuberranking/pages/channel/entity/channel_chart_data.dart';
import '../home/entity/channel_info.dart';
import '../../services/result.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class ChannelRepository {
  CollectionReference channelInfoRef =
      FirebaseFirestore.instance.collection('channel_info');

  Future<Result> getChannelInfo(String channelId) async {
    try {
      DocumentSnapshot channelSnapshot =
          await channelInfoRef.doc(channelId).get();
      var data = channelSnapshot.data();
      var channelInfo = new ChannelInfo(
          channelId: channelId,
          channelName: data['title'],
          totalSubscribers: data['subscribers'],
          totalViews: data['views'],
          iconUrl: data['thumbnail_icon_url'],
          publishedAt: data['published_at'] ?? "-",
          lastPublishedVideoAt: data['last_published_video_at'] ?? "-",
          description: data['description'],
          isRebranded: data['is_rebranded'] ?? false,
          updatedAt: data['updated_at'] ?? 0);

      QuerySnapshot videoSnapshot =
          await channelInfoRef.doc(channelId).collection('video').get();
      var videoDocs = videoSnapshot.docs;

      List<Video> videos = [];

      videoDocs.forEach((videoDoc) {
        var data = videoDoc.data();
        var video = new Video(videoDoc.id, data['title'], data['description'],
            data['published_at'], data['thumbnail_image_url']);
        videos.add(video);
      });

      channelInfo.videos = videos;

      return Result<ChannelInfo>.success(channelInfo);
    } catch (error) {
      return Result.error(error.toString());
    }
  }

  Future<Result> getChannelChartData(String channelId) async {
    String url =
        "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/chart_data/$channelId.json";

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body)['result'];
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
