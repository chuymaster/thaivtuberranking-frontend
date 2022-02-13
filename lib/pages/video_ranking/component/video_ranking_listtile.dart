import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking.dart';
import 'package:transparent_image/transparent_image.dart';

class VideoRankingListTile extends StatelessWidget {
  const VideoRankingListTile({
    Key? key,
    required this.item,
    required this.onTap,
    required this.onTapChannelName,
    required this.displayRank,
  }) : super(key: key);

  final VideoRanking item;
  final int displayRank;
  final Function(VideoRanking) onTap;
  final Function(VideoRanking) onTapChannelName;

  @override
  Widget build(BuildContext context) {
    var fadeInImage = FadeInImage.memoryNetwork(
      height: 88.0,
      width: 160.0,
      placeholder: kTransparentImage,
      image: item.thumbnailImageUrl,
      fit: BoxFit.fitWidth,
      fadeInDuration: Duration(milliseconds: 300),
    );

    var views = item.views;
    return ListTile(
      title: Row(
        children: [
          fadeInImage,
          Padding(
            padding: EdgeInsets.all(8),
          ),
          Expanded(
              child: Column(
            children: [
              ThaiText(
                text: '$displayRank. ' + item.title,
                fontWeight: FontWeight.bold,
              ),
              ThaiText(
                text: 'ดู $views ครั้ง | ' + item.publishedAtString,
                color: Colors.black54,
                fontSize: 12,
              ),
              Padding(
                padding: EdgeInsets.all(2),
              ),
              InkWell(
                  child: Row(
                    children: [
                      Icon(Icons.ondemand_video),
                      Padding(
                        padding: EdgeInsets.all(2),
                      ),
                      Flexible(
                        child: ThaiText(
                          text: item.channelTitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    onTapChannelName(item);
                  }),
              Padding(
                padding: EdgeInsets.all(2),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
          ))
        ],
      ),
      onTap: () {
        onTap(item);
      },
    );
  }
}
