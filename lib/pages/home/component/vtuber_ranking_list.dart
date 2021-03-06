import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'page_selection.dart';
import '../entity/channel_info.dart';
import 'package:transparent_image/transparent_image.dart';

class VTuberRankingList extends StatelessWidget {
  final List<ChannelInfo> itemList;
  final PageSelection pageSelection;
  final int rankOffset;
  final ScrollController scrollController;
  final Function(ChannelInfo) onTapCell;
  final Function(ChannelInfo) onTapYouTubeIcon;

  const VTuberRankingList(
      {Key key,
      this.itemList,
      this.rankOffset,
      this.scrollController,
      this.onTapCell,
      this.onTapYouTubeIcon,
      this.pageSelection})
      : super(key: key);

  Widget buildRankingList() {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            if (itemList.length == 0) {
              return Padding(
                padding: EdgeInsets.all(0),
              );
            } else if (index == 0 || index == itemList.length + 1) {
              // แถวแรก/สุดท้ายให้เป็น page selection
              return pageSelection;
            } else {
              int fixedIndex = index - 1;
              ChannelInfo item = itemList[fixedIndex];
              int rank = fixedIndex + 1;
              var subscribers = item.getSubscribers();
              var views = item.getViews();
              var published = item.getPublishedAt();
              var displayRank = rank + rankOffset;
              var updated = item.getLastPublishedVideoAtString();
              return Container(
                  child: Ink(
                      color: (fixedIndex % 2 != 0
                          ? Colors.blue[50]
                          : Colors.white),
                      child: RankingListTile(
                        item: item,
                        displayRank: displayRank,
                        subscribers: subscribers,
                        views: views,
                        published: published,
                        updated: updated,
                        onTap: onTapCell,
                        onTapYouTubeIcon: onTapYouTubeIcon,
                      )));
            }
          },
          controller: scrollController,
          separatorBuilder: (context, index) {
            return Divider(
              height: 4,
            );
          },
          itemCount: itemList.length + 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildRankingList();
  }
}

class RankingListTile extends StatelessWidget {
  const RankingListTile({
    Key key,
    @required this.item,
    @required this.displayRank,
    @required this.subscribers,
    @required this.views,
    @required this.published,
    @required this.updated,
    this.onTap,
    this.onTapYouTubeIcon,
  }) : super(key: key);

  final ChannelInfo item;
  final int displayRank;
  final String subscribers;
  final String views;
  final String published;
  final String updated;
  final Function(ChannelInfo) onTap;
  final Function(ChannelInfo) onTapYouTubeIcon;

  @override
  Widget build(BuildContext context) {
    var fadeInImage = ClipRRect(
        borderRadius: BorderRadius.circular(45),
        child: FadeInImage.memoryNetwork(
          height: 90.0,
          width: 90.0,
          placeholder: kTransparentImage,
          image: item.iconUrl,
          fit: BoxFit.contain,
          fadeInDuration: Duration(milliseconds: 300),
        ));

    var youtubeIcon = InkWell(
      child: Container(
        child: Image.asset('assets/images/youtube_button_grey.png'),
        padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
        width: 80.0,
      ),
      onTap: () {
        onTapYouTubeIcon(item);
      },
    );

    var imageWithYoutubeIcon = Column(
      children: [fadeInImage, youtubeIcon],
    );

    var rankText = displayRank > 0
        ? 'อันดับ $displayRank ' + item.channelName
        : item.channelName;

    return ListTile(
      // leading:
      title: Row(
        children: [
          imageWithYoutubeIcon,
          Padding(
            padding: EdgeInsets.all(8),
          ),
          Expanded(
              child: Column(
            children: [
              ThaiText(
                  text: rankText,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis),
              ThaiText(text: 'ผู้ติดตาม $subscribers คน'),
              ThaiText(text: 'ดู $views ครั้ง'),
              ThaiText(
                  text: 'คลิปล่าสุด $updated\nวันเปิดแชนแนล $published',
                  fontSize: 12,
                  color: Colors.black54),
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
