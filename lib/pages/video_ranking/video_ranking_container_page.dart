import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/live/live_page.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_page.dart';
import 'package:thaivtuberranking/pages/video_ranking/entity/video_ranking_type.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';

import '../../main.dart';

class VideoRankingContainerPage extends StatefulWidget {
  final OriginType originType;
  final VoidCallback didScrollDown;
  final VoidCallback didScrollUp;

  const VideoRankingContainerPage(
      {super.key,
      required this.originType,
      required this.didScrollDown,
      required this.didScrollUp});
  @override
  _VideoRankingContainerPageState createState() =>
      _VideoRankingContainerPageState();
}

class _VideoRankingContainerPageState extends State<VideoRankingContainerPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabBarTabs = [
    Tab(text: L10n.strings.video_list_tab_live),
    Tab(text: L10n.strings.video_list_tab_one_day),
    Tab(text: L10n.strings.video_list_tab_three_days),
    Tab(text: L10n.strings.video_list_tab_seven_days)
  ];

  int _tabBarInitialIndex = 0;

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.screenLoaded, {
      AnalyticsParameterName.screenName: AnalyticsPageName.videoRankingContainer
    });

    _tabController = TabController(
        vsync: this,
        length: _tabBarTabs.length,
        initialIndex: _tabBarInitialIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tabBar = Material(
        child: TabBar(
      tabs: _tabBarTabs,
    ));

    var tabBody = TabBarView(children: [
      LivePage(
        originType: widget.originType,
        didScrollDown: () => widget.didScrollDown(),
        didScrollUp: () => widget.didScrollUp(),
      ),
      VideoRankingPage(
        originType: widget.originType,
        rankingType: VideoRankingType.OneDay,
        didScrollDown: () => widget.didScrollDown(),
        didScrollUp: () => widget.didScrollUp(),
      ),
      VideoRankingPage(
        originType: widget.originType,
        rankingType: VideoRankingType.ThreeDay,
        didScrollDown: () => widget.didScrollDown(),
        didScrollUp: () => widget.didScrollUp(),
      ),
      VideoRankingPage(
        originType: widget.originType,
        rankingType: VideoRankingType.SevenDay,
        didScrollDown: () => widget.didScrollDown(),
        didScrollUp: () => widget.didScrollUp(),
      ),
    ]);

    return DefaultTabController(
      length: _tabBarTabs.length,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context);
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              MyApp.analytics.sendAnalyticsEvent(
                  AnalyticsEvent.changeVideoRankingTab,
                  {'index': tabController.index});
            }
          });

          return Scaffold(
            appBar: PreferredSize(
              child: Container(child: tabBar),
              preferredSize: Size.fromHeight(40),
            ),
            body: tabBody,
          );
        },
      ),
    );
  }
}
