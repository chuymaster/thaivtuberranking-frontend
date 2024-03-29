import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/screenFactor.dart';
import 'package:thaivtuberranking/pages/video_ranking/component/video_ranking_listtile.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking.dart';

class VideoRankingList extends StatelessWidget {
  final List<VideoRanking> videoRankingList;
  final ScrollController scrollController;

  final Function(VideoRanking) onTap;
  final Function(VideoRanking) onTapChannelName;
  const VideoRankingList(
      {super.key,
      required this.videoRankingList,
      required this.onTap,
      required this.onTapChannelName,
      required this.scrollController});

  @override
  Widget build(BuildContext context) {
    int itemCount = videoRankingList.length;

    var listView = ListView.builder(
      controller: scrollController,
      itemBuilder: (context, index) {
        return Center(
            child: SizedBox(
                width: getContentWidth(context),
                child: Ink(
                    color: (index % 2 != 0 ? Colors.blue[50] : Colors.white),
                    child: VideoRankingListTile(
                      item: videoRankingList[index],
                      displayRank: index + 1,
                      onTap: onTap,
                      onTapChannelName: onTapChannelName,
                    ))));
      },
      itemCount: itemCount,
    );

    return Container(
      child: listView,
    );
  }
}
