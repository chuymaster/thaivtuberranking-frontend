import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:thaivtuberranking/common/component/empty_error_notification.dart';
import 'package:thaivtuberranking/pages/channel/channel_page.dart';
import 'package:thaivtuberranking/pages/channel_ranking/channel_ranking_view_model.dart';
import 'package:thaivtuberranking/pages/home/component/page_selection.dart';
import 'package:thaivtuberranking/pages/home/component/vtuber_ranking_list.dart';
import 'package:thaivtuberranking/pages/home/entity/filter_item.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

import '../../main.dart';

class ChannelRankingPage extends StatefulWidget {
  final List<ChannelInfo> channelList;
  final VoidCallback didScrollDown;
  final VoidCallback didScrollUp;

  const ChannelRankingPage(
      {Key? key,
      required this.channelList,
      required this.didScrollDown,
      required this.didScrollUp})
      : super(key: key);

  @override
  _ChannelRankingPageState createState() => _ChannelRankingPageState();
}

class _ChannelRankingPageState extends State<ChannelRankingPage>
    with SingleTickerProviderStateMixin {
  late final _viewModel = ChannelRankingViewModel(widget.channelList);
  late final List<Tab> _tabs = _viewModel.filterItems
      .map((e) => Tab(
            text: e.text,
          ))
      .toList();
  late final TabController _tabController;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.channel_ranking});

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        widget.didScrollDown();
      } else {
        widget.didScrollUp();
      }
    });

    _tabController =
        TabController(vsync: this, length: _tabs.length, initialIndex: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tabBar = Container(
        child: Material(
          child: TabBar(
            isScrollable: true,
            indicatorColor: Colors.orangeAccent,
            tabs: _tabs,
          ),
          color: Theme.of(context).colorScheme.primary,
        ),
        constraints: BoxConstraints.expand());

    Widget body;
    if (widget.channelList.isEmpty) {
      body = EmptyErrorNotification();
    } else {
      body = _tabBarView;
    }

    return DefaultTabController(
      length: _tabs.length,
      child: Builder(
        builder: (BuildContext context) {
          final TabController? tabController = DefaultTabController.of(context);
          tabController?.addListener(() {
            if (!tabController.indexIsChanging) {
              FilterItem newItem = _viewModel.filterItems[tabController.index];
              MyApp.analytics.sendAnalyticsEvent(
                  AnalyticsEvent.set_filter, {'text': newItem.text});
            }
          });
          return Scaffold(
            appBar: PreferredSize(
              child: Container(child: tabBar),
              preferredSize: Size.fromHeight(40),
            ),
            body: body,
          );
        },
      ),
    );
  }

  Widget get _tabBarView {
    List<Widget> rankingList = [];
    _tabs.asMap().forEach((index, _) {
      rankingList.add(_buildTabBarView(index));
    });

    return TabBarView(children: rankingList);
  }

  Widget _buildTabBarView(int filterIndex) {
    PageSelection pageSelection = PageSelection(
      currentPageNumber: _viewModel.currentPageNumber,
      maxPageNumber: _viewModel.maxPageNumber,
      onPageChanged: (destinationPageNumber) {
        MyApp.analytics.sendAnalyticsEvent(
            AnalyticsEvent.change_page, {'page_number': destinationPageNumber});
        setState(() {
          _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeOut);
          _viewModel.setPageNumber(destinationPageNumber);
        });
      },
    );

    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        VTuberRankingList(
          itemList: _viewModel.getDisplayChannelList(filterIndex),
          pageSelection: pageSelection,
          rankOffset: _viewModel.startIndex,
          scrollController: _scrollController,
          onTapCell: (channelInfo) {
            Navigator.pushNamed(context, ChannelPage.route,
                arguments: channelInfo.channelId);
            MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.view_detail, {
              'channel_id': channelInfo.channelId,
              'channel_name': channelInfo.channelName
            });
          },
          onTapYouTubeIcon: (channelInfo) {
            UrlLauncher.launchURL(channelInfo.getChannelUrl());
            MyApp.analytics
                .sendAnalyticsEvent(AnalyticsEvent.click_vtuber_url, {
              'name': channelInfo.channelName,
              'url': channelInfo.getChannelUrl(),
              'location': 'top_youtube_icon'
            });
          },
        ),
      ],
    ));
  }
}
