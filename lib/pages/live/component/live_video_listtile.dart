import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/live/entity/live_video.dart';
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
    List<Widget> columnChildren = [];
    columnChildren.add(ThaiText(
      text: item.title,
      fontWeight: FontWeight.bold,
    ));
    columnChildren.addAll(_videoDescription);
    columnChildren.addAll([
      Padding(
        padding: EdgeInsets.all(2),
      ),
      InkWell(
          child: Row(
            children: [
              _channelThumbnailImage,
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
    ]);
    return ListTile(
      title: Row(
        children: [
          _videoThumbnailImage,
          Padding(
            padding: EdgeInsets.all(8),
          ),
          Expanded(
              child: Column(
            children: columnChildren,
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

  Widget get _channelThumbnailImage {
    return ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: FadeInImage.memoryNetwork(
          height: 32,
          width: 32,
          placeholder: kTransparentImage,
          image: item.makeSmallChannelThumbnailImageUrl(),
          imageErrorBuilder: (context, error, stackTrace) {
            return Icon(Icons.error_outline);
          },
          fit: BoxFit.fill,
          fadeInDuration: Duration(milliseconds: 300),
        ));
  }

  Widget get _videoThumbnailImage {
    return FadeInImage.memoryNetwork(
      height: 88.0,
      width: 160.0,
      placeholder: kTransparentImage,
      image: item.thumbnailImageUrl,
      fit: BoxFit.fitWidth,
      fadeInDuration: Duration(milliseconds: 300),
    );
  }

  List<Widget> get _videoDescription {
    switch (item.liveStatus) {
      case LiveStatus.Live:
        return [
          ThaiText(
            text: 'เริ่ม ' + item.getLiveStartAtString(),
            color: Colors.black54,
            fontSize: 12,
          ),
          ThaiText(
            text: 'ดูพร้อมกัน ' + item.getConcurrentViewerCount() + ' คน',
            color: Colors.black54,
            fontSize: 12,
          ),
        ];
      case LiveStatus.Upcoming:
        return [
          ThaiText(
            text: 'เริ่ม ' + item.getLiveScheduleString(),
            color: Colors.black54,
            fontSize: 12,
          ),
        ];
      default:
        return [];
    }
  }
}
