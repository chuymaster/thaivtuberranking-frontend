import 'dart:math';

import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/custom_constraints.dart';
import 'package:thaivtuberranking/pages/channel/channel_page.dart';
import 'package:thaivtuberranking/pages/channel_ranking/channel_ranking_repository.dart';
import 'package:thaivtuberranking/pages/home/component/page_selection.dart';
import 'package:thaivtuberranking/pages/home/component/vtuber_ranking_list.dart';
import 'package:thaivtuberranking/pages/home/entity/filter_item.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

import '../../main.dart';

class ChannelRankingPage extends StatefulWidget {
  final List<ChannelInfo> channelList;

  const ChannelRankingPage({Key? key, required this.channelList})
      : super(key: key);

  @override
  _ChannelRankingPageState createState() => _ChannelRankingPageState();
}

class _ChannelRankingPageState extends State<ChannelRankingPage>
    with SingleTickerProviderStateMixin {
  final _repository = ChannelRankingRepository();

  int channelCount = 0;
  int currentPageNumber = 1;
  int maxPageNumber = 1;
  final int _itemPerPage = 20;

  List<Tab> _tabBarTabs = [];
  late int _tabBarInitialIndex;

  late TabController _tabController;
  ScrollController _scrollController = ScrollController();

  final List<FilterItem> filterItems = <FilterItem>[
    FilterItem(Filter.Subscriber),
    FilterItem(Filter.View),
    FilterItem(Filter.PublishedDate),
    FilterItem(Filter.UpdatedDate)
  ];

  @override
  void initState() {
    super.initState();

    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.channel_ranking});

    // สร้าง widget สำหรับแต่ละ tabs
    filterItems.forEach((element) {
      _tabBarTabs.add(Tab(text: element.text));
    });

    loadData();
  }

  void loadData() async {
    final value = await _repository.getFilterIndex();
    setState(() {
      setMaxPageNumber();
      _tabBarInitialIndex = value;
      _tabController = TabController(
          vsync: this,
          length: _tabBarTabs.length,
          initialIndex: _tabBarInitialIndex);
    });
  }

  int getOffset() {
    return (currentPageNumber - 1) * _itemPerPage;
  }

  /// ลิสต์อันดับที่ผ่านการ filter แล้ว ใช้โชว์จริง
  List<ChannelInfo> displayItemList(Filter filter) {
    List<ChannelInfo> _itemList = widget.channelList;

    switch (filter) {
      case Filter.Subscriber:
        // sort desc (b > a)
        _itemList
            .sort((a, b) => b.totalSubscribers.compareTo(a.totalSubscribers));
        break;
      case Filter.View:
        _itemList.sort((a, b) => b.totalViews.compareTo(a.totalViews));
        break;
      case Filter.PublishedDate:
        _itemList.sort((a, b) => b
            .getPublishedAtForComparison()
            .compareTo(a.getPublishedAtForComparison()));
        break;
      case Filter.UpdatedDate:
        _itemList.sort(
            (a, b) => b.lastPublishedVideoAt.compareTo(a.lastPublishedVideoAt));
        break;
    }

    int end = min(_itemList.length, getOffset() + _itemPerPage);

    return _itemList.getRange(getOffset(), end).toList();
  }

  void setMaxPageNumber() {
    channelCount = widget.channelList.length;
    maxPageNumber = (channelCount / _itemPerPage).ceil();
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
            tabs: _tabBarTabs,
          ),
          color: Theme.of(context).colorScheme.primary,
        ),
        constraints: BoxConstraints.expand());

    return DefaultTabController(
      length: _tabBarTabs.length,
      child: Builder(
        builder: (BuildContext context) {
          final TabController? tabController = DefaultTabController.of(context);
          tabController?.addListener(() {
            if (!tabController.indexIsChanging) {
              FilterItem newItem = filterItems[tabController.index];
              MyApp.analytics.sendAnalyticsEvent(
                  AnalyticsEvent.set_filter, {'text': newItem.text});
              // เวลาเปลี่ยนฟิลเตอร์เรียงอันดับ
              setState(() {
                // เซฟฟิลเตอร์ที่เลือกไว้ใช้ตอนโหลดแอพใหม่
                _repository.setFilterIndex(tabController.index);
              });
            }
          });

          return Scaffold(
            appBar: PreferredSize(
              child: Container(child: tabBar),
              preferredSize: Size.fromHeight(40),
            ),
            body: _buildTabBarView(_tabBarTabs),
          );
        },
      ),
    );
  }

  Widget _buildVTuberRankingList(Filter filter) {
    PageSelection pageSelection = PageSelection(
      currentPageNumber: currentPageNumber,
      maxPageNumber: maxPageNumber,
      onPageChanged: (destinationPageNumber) {
        MyApp.analytics.sendAnalyticsEvent(
            AnalyticsEvent.change_page, {'page_number': destinationPageNumber});
        setState(() {
          _scrollController.animateTo(
              _scrollController.position.minScrollExtent,
              duration: Duration(milliseconds: 100),
              curve: Curves.easeOut);
          currentPageNumber = destinationPageNumber;
        });
      },
    );

    return Center(
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          VTuberRankingList(
            itemList: displayItemList(filter),
            pageSelection: pageSelection,
            rankOffset: getOffset(),
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
      ),
      constraints: CustomConstraints.pageBoxConstraints,
    ));
  }

  Widget _buildTabBarView(List<Tab> tabs) {
    List<Widget> rankingList = [];

    tabs.asMap().forEach((index, value) {
      rankingList.add(_buildVTuberRankingList(filterItems[index].filter));
    });

    return TabBarView(children: rankingList);
  }
}
