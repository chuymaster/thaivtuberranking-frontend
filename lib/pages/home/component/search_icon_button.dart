import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:thaivtuberranking/common/screenFactor.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:thaivtuberranking/pages/channel/channel_page.dart';
import 'package:thaivtuberranking/pages/home/component/vtuber_ranking_list.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';

class SearchIconButton extends StatelessWidget {
  final List<ChannelInfo> channelList;

  const SearchIconButton({super.key, required this.channelList});

  @override
  Widget build(BuildContext context) {
    channelList.sort((a, b) {
      return b.subscribers.compareTo(a.subscribers);
    });
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
                searchLabel: L10n.strings.search_bar_placeholder,
                suggestion: Center(
                  child: Text(L10n.strings.search_text_input_prompt),
                ),
                failure: Center(
                  child: Text(L10n.strings.search_text_not_found),
                ),
                filter: (channelInfo) {
                  return [channelInfo.channelName];
                },
                builder: (channelInfo) {
                  return Center(
                      child: SizedBox(
                    width: getContentWidth(context),
                    child: RankingListTile(
                      item: channelInfo,
                      displayRank: 0,
                      subscribers: channelInfo.subscribersString,
                      views: channelInfo.viewsString,
                      published: channelInfo.publishedAtString,
                      updated: channelInfo.lastPublishedVideoAtString,
                      onTap: (channelInfo) {
                        Navigator.pushNamed(context, ChannelPage.route,
                            arguments: channelInfo.channelId);
                        MyApp.analytics
                            .sendAnalyticsEvent(AnalyticsEvent.viewDetail, {
                          'channel_id': channelInfo.channelId,
                          'channel_name': channelInfo.channelName,
                          'location': 'search_page'
                        });
                      },
                      onTapYouTubeIcon: (channelInfo) {
                        UrlLauncher.launchURL(channelInfo.channelUrl);
                        MyApp.analytics
                            .sendAnalyticsEvent(AnalyticsEvent.clickVTuberUrl, {
                          'name': channelInfo.channelName,
                          'url': channelInfo.channelUrl,
                          'location': 'search_youtube_icon'
                        });
                      },
                    ),
                  ));
                },
              ));
        });
  }
}
