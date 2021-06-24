import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/announcement_banner.dart';
import 'package:thaivtuberranking/common/component/center_circular_progress_indicator.dart';
import 'package:thaivtuberranking/common/component/error_dialog.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/channel_ranking/channel_ranking_page.dart';
import 'package:thaivtuberranking/pages/home/component/drawer_menu.dart';
import 'package:thaivtuberranking/pages/home/component/search_icon_button.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_container_page.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:thaivtuberranking/pages/add/add_page.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';
import 'dart:core';
import 'entity/origin_type.dart';
import 'entity/channel_info.dart';
import 'home_repository.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  static const String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OriginType _currentOriginType = OriginType.OriginalOnly;
  final _repository = HomeRepository();
  List<ChannelInfo> _channelList = [];
  bool _isLoading = true;
  bool _didPressDeleteChannelAnnouncement = false;

  String _lastUpdated = "";

  int _currentIndex = 0;

  String _title = "จัดอันดับวิดีโอ VTuber ไทย";

  // MARK:- Functions

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.home});

    loadData();
  }

  void loadData() async {
    final didPressDeleteChannelAnnouncement =
        await _repository.getDidPressDeleteChannelAnnouncement();
    setState(() {
      _didPressDeleteChannelAnnouncement = didPressDeleteChannelAnnouncement;
    });

    final result = await _repository.getVTuberChannelData();
    if (result is SuccessState) {
      setState(() {
        _channelList = result.value;
        _lastUpdated = _getFilteredChannelList()
            .reduce((current, next) =>
                current.updatedAt > next.updatedAt ? current : next)
            .getUpdatedAt();
        _isLoading = false;
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

  List<ChannelInfo> _getFilteredChannelList() {
    switch (_currentOriginType) {
      case OriginType.OriginalOnly:
        return _channelList.where((element) => (!element.isRebranded)).toList();
      case OriginType.All:
        return _channelList;
    }
  }

  /// Build All
  @override
  Widget build(BuildContext context) {
    return _buildScaffold();
  }

  Widget _buildScaffold() {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            _title,
            style: TextStyle(fontFamily: ThaiText.kanit),
          ),
          actions: [SearchIconButton(channelList: _getFilteredChannelList())]),
      drawer: DrawerMenu(
          currentOriginType: _currentOriginType,
          lastUpdatedAt: _lastUpdated,
          onChangeOriginType: (originType) => {
                setState(() {
                  this._currentOriginType = originType;
                })
              },
          onTapAddChannelMenu: () => {this._navigateToAddPage("drawer_menu")}),
      body: _didPressDeleteChannelAnnouncement
          ? _buildBottomNavigationBarChildren()[_currentIndex]
          : Stack(
              children: [
                _buildBottomNavigationBarChildren()[_currentIndex],
                _buildDeleteChannelAnnouncement()
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.ondemand_video), label: "วิดีโอ"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin), label: "แชนแนล"),
          ],
          onTap: _onBottomNavigationBarTabTapped),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle),
        tooltip: 'แจ้งเพิ่มแชนแนล VTuber',
        onPressed: () => _navigateToAddPage('appbar_add_button'),
      ),
    );
  }

  Widget _buildDeleteChannelAnnouncement() {
    return Positioned.fill(
        bottom: 0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            child: AnnouncementBanner(onPressed: () {
              MyApp.analytics.sendAnalyticsEvent(
                  AnalyticsEvent.click_delete_channel_announcement,
                  {"from": "home"});
              UrlLauncher.launchURL(
                  "https://www.notion.so/Public-d92d99d2b88a4747814834bcbdd9989f");
              _repository.pressDeleteChannelAnnouncement();
              setState(() {
                _didPressDeleteChannelAnnouncement = true;
              });
            }),
            height: 48,
          ),
        ));
  }

  void _onBottomNavigationBarTabTapped(int index) {
    MyApp.analytics
        .sendAnalyticsEvent(AnalyticsEvent.change_bottom_tab, {"index": index});
    setState(() {
      _currentIndex = index;
      // เปลี่ยนชื่อ title ตาม tab
      if (index == 0) {
        _title = "จัดอันดับวิดีโอ VTuber ไทย";
      } else {
        _title = "จัดอันดับแชนแนล VTuber ไทย";
      }
    });
  }

  void _navigateToAddPage(String location) {
    var channelIdList = _channelList.map((e) => e.channelId).toList();

    Navigator.pushNamed(context, AddPage.route, arguments: channelIdList);
    MyApp.analytics.sendAnalyticsEvent(
        AnalyticsEvent.view_add_page, {'location': location});
  }

  List<Widget> _buildBottomNavigationBarChildren() {
    Widget channelRankingPage = CenterCircularProgressIndicator();
    if (!_isLoading) {
      channelRankingPage = ChannelRankingPage(
        channelList: _getFilteredChannelList(),
      );
    }
    return [
      VideoRankingContainerPage(
        originType: _currentOriginType,
      ),
      channelRankingPage,
    ];
  }
}
