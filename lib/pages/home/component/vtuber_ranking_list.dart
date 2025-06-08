import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/common/screenFactor.dart';
import 'page_selection.dart';
import '../entity/channel_info.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';

class VTuberRankingList extends StatelessWidget {
  final List<ChannelInfo> itemList;
  final PageSelection pageSelection;
  final int rankOffset;
  final ScrollController scrollController;
  final Function(ChannelInfo) onTapCell;
  final Function(ChannelInfo) onTapYouTubeIcon;
  const VTuberRankingList(
      {super.key,
      required this.itemList,
      required this.rankOffset,
      required this.scrollController,
      required this.onTapCell,
      required this.onTapYouTubeIcon,
      required this.pageSelection});

  Widget buildRankingList() {
    int lastIndex = itemList.length + 1;
    return Expanded(
      child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            Widget child;
            if (index == 0 || index == lastIndex) {
              // แถวแรก/สุดท้ายให้เป็น page selection
              child = pageSelection;
            } else {
              int fixedIndex = index - 1;
              ChannelInfo item = itemList[fixedIndex];
              int rank = fixedIndex + 1;
              var subscribers = item.subscribersString;
              var views = item.viewsString;
              var published = item.publishedAtString;
              var displayRank = rank + rankOffset;
              var updated = item.lastPublishedVideoAtString;
              child = Container(
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
            return Center(
                child: SizedBox(width: getContentWidth(context), child: child));
          },
          controller: scrollController,
          itemCount: lastIndex + 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return buildRankingList();
  }
}

class RankingListTile extends StatelessWidget {
  const RankingListTile({
    super.key,
    required this.item,
    required this.displayRank,
    required this.subscribers,
    required this.views,
    required this.published,
    required this.updated,
    required this.onTap,
    required this.onTapYouTubeIcon,
  });

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
        ? L10n.strings.channel_list_text_rank(displayRank, item.channelName)
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
              ThaiText(text: L10n.strings.channel_info_subscribers_views(subscribers, views)),
              ThaiText(
                  text: L10n.strings.channel_info_updated_published(published, updated),
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
