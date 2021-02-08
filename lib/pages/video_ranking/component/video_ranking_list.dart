import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/video_ranking/component/adsense_listtile.dart';
import 'package:thaivtuberranking/pages/video_ranking/component/video_ranking_listtile.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking.dart';

class VideoRankingList extends StatelessWidget {
  final List<VideoRanking> videoRankingList;

  final Function(VideoRanking) onTap;
  final Function(VideoRanking) onTapChannelName;
  const VideoRankingList(
      {Key key, this.videoRankingList, this.onTap, this.onTapChannelName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var adInterval = 10;
    // int totalAds = (videoRankingList.length / adInterval).floor();
    int itemCount = videoRankingList.length + 1;

    var listView = ListView.builder(
      itemBuilder: (context, index) {
        // if (index > 0 && index % adInterval == 0) {
        if (index == videoRankingList.length) {
          return AdSenseListTile();
        } else {
          // var i = index - (index / adInterval).floor();
          var i = index;
          return Container(
              child: Ink(
                  color: (i % 2 != 0 ? Colors.blue[50] : Colors.white),
                  child: VideoRankingListTile(
                    item: videoRankingList[i],
                    displayRank: i + 1,
                    onTap: onTap,
                    onTapChannelName: onTapChannelName,
                  )));
        }
      },
      itemCount: itemCount,
    );

    return Container(
      child: listView,
    );
  }
}
