import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:thaivtuberranking/pages/channel/channel_page.dart';
import 'package:thaivtuberranking/pages/home/component/vtuber_ranking_list.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

import '../../main.dart';

// ignore: must_be_immutable
class ChannelSearchPage extends StatefulWidget {
  static const String route = '/search';
  final List<ChannelInfo> channelList;

  ChannelSearchPage({Key? key, required this.channelList}) : super(key: key);

  @override
  _ChannelSearchPageState createState() => _ChannelSearchPageState();
}

class _ChannelSearchPageState extends State<ChannelSearchPage> {
  @override
  void initState() {
    super.initState();
    widget.channelList.sort((a, b) {
      return b.totalSubscribers.compareTo(a.totalSubscribers);
    });
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.search});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ค้นหาแชนแนล"),
        ),
        body: Container(),
        floatingActionButton: _buildFloatingActionButton());
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
        tooltip: "ค้นหาแชนแนล",
        child: Icon(Icons.search),
        onPressed: () => showSearch(
            context: context,
            delegate: SearchPage<ChannelInfo>(
              onQueryUpdate: (query) {
                MyApp.analytics.sendAnalyticsEvent(
                    AnalyticsEvent.search, {"query": query});
              },
              items: widget.channelList,
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
            )));
  }
}
