import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/video_ranking/component/video_ranking_listtile.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking.dart';

class VideoRankingList extends StatelessWidget {
  final List<VideoRanking> videoRankingList;

  final Function(VideoRanking) onTap;
  final Function(VideoRanking) onTapChannelName;
  const VideoRankingList(
      {Key? key,
      required this.videoRankingList,
      required this.onTap,
      required this.onTapChannelName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemCount = videoRankingList.length;

    var listView = ListView.builder(
      itemBuilder: (context, index) {
        return Container(
            child: Ink(
                color: (index % 2 != 0 ? Colors.blue[50] : Colors.white),
                child: VideoRankingListTile(
                  item: videoRankingList[index],
                  displayRank: index + 1,
                  onTap: onTap,
                  onTapChannelName: onTapChannelName,
                )));
      },
      itemCount: itemCount,
    );

    return Container(
      child: listView,
    );
  }
}
