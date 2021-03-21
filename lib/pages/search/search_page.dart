import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/center_circular_progress_indicator.dart';
import 'package:thaivtuberranking/common/component/error_dialog.dart';
import 'package:thaivtuberranking/pages/channel/channel_page.dart';
import 'package:thaivtuberranking/pages/home/component/vtuber_ranking_list.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/home/home_repository.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

import '../../main.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  static const String route = '/search';
  List<ChannelInfo>? channelList;
  OriginType? originType;

  SearchPage({Key? key, this.channelList, this.originType}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SearchBarController<ChannelInfo> _searchBarController =
      SearchBarController();
  final _repository = HomeRepository();
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.search});

    if (widget.originType == null) {
      widget.originType = OriginType.OriginalOnly;
    }
    if (widget.channelList == null) {
      loadData();
    }
  }

  void loadData() async {
    final result = await _repository.getVTuberChannelData();
    if (result is SuccessState) {
      setState(() {
        widget.channelList = result.value;
      });
    } else if (result is ErrorState) {
      ErrorDialog.showErrorDialog(
          'ไม่สามารถโหลดข้อมูล VTuber ได้\nโปรดลองใหม่ในภายหลัง',
          result.msg,
          context);
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ค้นหาแชนแนล"),
        ),
        body: _isLoading
            ? CenterCircularProgressIndicator()
            : _buildSearchWidget());
  }

  Widget _buildSearchWidget() {
    _searchBarController.sortList((a, b) {
      return a.totalSubscribers.compareTo(b.totalSubscribers);
    });

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SearchBar<ChannelInfo>(
          searchBarController: _searchBarController,
          placeHolder: Text("พิมพ์ชื่อแชนแนลสองตัวอักษรขึ้นไป"),
          cancellationWidget: Text("ยกเลิก"),
          emptyWidget: Text("ไม่พบผลลัพธ์"),
          minimumChars: 2,
          onSearch: _search,
          onItemFound: (ChannelInfo channelInfo, int index) {
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
                MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.view_detail, {
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
        ),
      ),
    );
  }

  Future<List<ChannelInfo>> _search(String query) async {
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.search, {"query": query});

    await Future.delayed(Duration(milliseconds: 1));
    if (widget.channelList != null) {
      var filteredList = widget.channelList!
          .where((element) =>
              element.channelName.toLowerCase().contains(query.toLowerCase()))
          .toList();
      if (widget.originType == OriginType.OriginalOnly) {
        filteredList =
            filteredList.where((element) => !element.isRebranded).toList();
      }

      filteredList.sort((a, b) {
        return b.totalSubscribers.compareTo(a.totalSubscribers);
      });
      return filteredList;
    } else {
      return [];
    }
  }
}
