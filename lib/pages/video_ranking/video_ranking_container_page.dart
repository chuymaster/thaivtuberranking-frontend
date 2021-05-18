import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_page.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_repository.dart';
import 'package:thaivtuberranking/services/analytics.dart';

import '../../main.dart';

class VideoRankingContainerPage extends StatefulWidget {
  final OriginType originType;

  const VideoRankingContainerPage({Key? key, required this.originType})
      : super(key: key);
  @override
  _VideoRankingContainerPageState createState() =>
      _VideoRankingContainerPageState();
}

class _VideoRankingContainerPageState extends State<VideoRankingContainerPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabBarTabs = [
    Tab(
      text: "24 ชั่วโมงที่ผ่านมา",
    ),
    Tab(
      text: "3 วันที่ผ่านมา",
    ),
    Tab(
      text: "7 วันที่ผ่านมา",
    )
  ];

  int _tabBarInitialIndex = 0;

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded, {
      AnalyticsParameterName.page_name:
          AnalyticsPageName.video_ranking_container
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

    var tabBody = TabBarView(children: [
      VideoRankingPage(
        originType: widget.originType,
        rankingType: VideoRankingType.OneDay,
      ),
      VideoRankingPage(
        originType: widget.originType,
        rankingType: VideoRankingType.ThreeDay,
      ),
      VideoRankingPage(
        originType: widget.originType,
        rankingType: VideoRankingType.SevenDay,
      ),
    ]);

    return DefaultTabController(
      length: _tabBarTabs.length,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context)!;
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {
              MyApp.analytics.sendAnalyticsEvent(
                  AnalyticsEvent.change_video_ranking_tab,
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
