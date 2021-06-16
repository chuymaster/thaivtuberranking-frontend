import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/live/entity/live_video.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking.dart';
import 'package:transparent_image/transparent_image.dart';

class LiveVideoListTile extends StatelessWidget {
  const LiveVideoListTile({
    Key? key,
    required this.item,
    required this.onTap,
    required this.onTapChannelName,
  }) : super(key: key);

  final LiveVideo item;
  final Function(LiveVideo) onTap;
  final Function(LiveVideo) onTapChannelName;

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

    var concurrentViews = item.getConcurrentViewerCount();
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
                text: item.title,
                fontWeight: FontWeight.bold,
              ),
              ThaiText(
                text: 'เริ่มไลฟ์ ' + item.getLiveStartAtString(),
                color: Colors.black54,
                fontSize: 12,
              ),
              ThaiText(
                text: 'ดูพร้อมกัน $concurrentViews คน',
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
