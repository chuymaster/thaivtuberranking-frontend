import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:thaivtuberranking/pages/channel/channel_page.dart';
import 'package:thaivtuberranking/pages/home/component/vtuber_ranking_list.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

class SearchIconButton extends StatelessWidget {
  final List<ChannelInfo> channelList;

  const SearchIconButton({Key? key, required this.channelList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          showSearch(
              context: context,
              delegate: SearchPage<ChannelInfo>(
                onQueryUpdate: (query) {
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.search, {"query": query});
                },
                items: channelList,
                searchLabel: "ค้นหาแชนแนล",
                suggestion: Center(
                  child: Text('พิมพ์ชื่อแชนแนลที่อยากค้นหา'),
                ),
                failure: Center(
                  child: Text("ไม่พบผลลัพธ์"),
                ),
                filter: (channelInfo) {
                  return [channelInfo.channelName];
                },
                builder: (channelInfo) {
                  return RankingListTile(
                    item: channelInfo,
                    displayRank: 0,
                    subscribers: channelInfo.getSubscribers(),
                    views: channelInfo.getViews(),
                    published: channelInfo.getPublishedAt(),
                    updated: channelInfo.getLastPublishedVideoAtString(),
                    onTap: (channelInfo) {
                      Navigator.pushNamed(context, ChannelPage.route,
                          arguments: channelInfo.channelId);
                      MyApp.analytics
                          .sendAnalyticsEvent(AnalyticsEvent.view_detail, {
                        'channel_id': channelInfo.channelId,
                        'channel_name': channelInfo.channelName,
                        'location': 'search_page'
                      });
                    },
                    onTapYouTubeIcon: (channelInfo) {
                      UrlLauncher.launchURL(channelInfo.getChannelUrl());
                      MyApp.analytics
                          .sendAnalyticsEvent(AnalyticsEvent.click_vtuber_url, {
                        'name': channelInfo.channelName,
                        'url': channelInfo.getChannelUrl(),
                        'location': 'search_youtube_icon'
                      });
                    },
                  );
                },
              ));
        });
  }
}
