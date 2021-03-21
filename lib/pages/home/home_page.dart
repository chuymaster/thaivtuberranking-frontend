import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/center_circular_progress_indicator.dart';
import 'package:thaivtuberranking/common/component/error_dialog.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/common/strings.dart';
import 'package:thaivtuberranking/pages/channel_ranking/channel_ranking_page.dart';
import 'package:thaivtuberranking/pages/search/search_page.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_container_page.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/environment_setting.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:thaivtuberranking/pages/add/add_page.dart';
import 'component/drawer_origin_type_radio_filter.dart';
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
  var _isLoading = true;

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
    return [];
  }

  /// Build All
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            _title,
            style: TextStyle(fontFamily: ThaiText.kanit),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.pushNamed(context, SearchPage.route, arguments: [
                    _getFilteredChannelList(),
                    _currentOriginType
                  ]);
                }),
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                _navigateToAddPage('appbar_add_button');
              },
            ),
          ]),
      drawer: _buildDrawer(),
      body: _buildBottomNavigationBarChildren()[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.ondemand_video), title: Text("วิดีโอ")),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin), title: Text("แชนแนล"))
          ],
          onTap: _onBottomNavigationBarTabTapped),
    );
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
      channelRankingPage
    ];
  }

  Widget _buildDrawer() {
    String prefix = "";
    if (EnvironmentSetting.shared.deployEnvironment !=
        DeployEnvironment.Production) {
      prefix =
          "[" + EnvironmentSetting.shared.deployEnvironment.toString() + "] ";
    }
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: ThaiText(
              text: prefix + "Thai VTuber Ranking",
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: ThaiText.kanit,
            ),
            accountEmail: ThaiText(
              text:
                  "เว็บนี้จัดทำเพื่อส่งเสริมวงการ VTuber ไทย\nผ่านการจัดอันดับแชนแนลบนยูทูป",
              color: Colors.white,
              fontSize: 13,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset('assets/images/Icon-512.png'),
            ),
          ),
          Card(
              color: Colors.blue[50],
              child: ListTile(
                  leading: Icon(Icons.access_time),
                  title: ThaiText(
                    text: "ข้อมูลอัพเดต $_lastUpdated",
                    fontSize: 13,
                  ))),
          Card(
            child: DrawerOriginTypeRadioFilter(
              currentOriginType: _currentOriginType,
              onChanged: (newType) {
                var typeLog = "";
                switch (newType) {
                  case OriginType.OriginalOnly:
                    typeLog = Strings.fullVtuber;
                    break;
                  case OriginType.All:
                    typeLog = Strings.allVtuber;
                    break;
                }
                MyApp.analytics.sendAnalyticsEvent(
                    AnalyticsEvent.set_type, {'type': typeLog});
                setState(() {
                  _currentOriginType = newType;
                });
              },
            ),
          ),
          ListTile(
            title: ThaiText(text: "แจ้งเพิ่มแชนแนล"),
            trailing: Icon(Icons.add),
            onTap: () {
              _navigateToAddPage('drawer_menu');
            },
          ),
          ListTile(
            title: ThaiText(text: "แจ้งปัญหาหรือเสนอฟีเจอร์"),
            trailing: Icon(Icons.open_in_new),
            onTap: () {
              var url = "https://twitter.com/chuymaster";
              UrlLauncher.launchURL(url);
              MyApp.analytics.sendAnalyticsEvent(
                  AnalyticsEvent.open_drawer_url, {'url': url});
            },
          ),
          ListTile(
            title: ThaiText(text: "API Document"),
            trailing: Icon(Icons.developer_mode),
            onTap: () {
              var url =
                  "https://github.com/chuymaster/thai-vtuber-ranking-docs";
              UrlLauncher.launchURL(url);
              MyApp.analytics.sendAnalyticsEvent(
                  AnalyticsEvent.open_drawer_url, {'url': url});
            },
          ),
          ListTile(
            title: ThaiText(text: "Release Notes"),
            trailing: Icon(Icons.open_in_new),
            onTap: () {
              var url =
                  "https://www.notion.so/Public-Release-Notes-fddbe59f838949038fcaa4d774a4f2fc";
              UrlLauncher.launchURL(url);
              MyApp.analytics.sendAnalyticsEvent(
                  AnalyticsEvent.open_drawer_url, {'url': url});
            },
          ),
          ListTile(
            title: ThaiText(text: "บล็อกผู้พัฒนา"),
            trailing: Icon(Icons.open_in_new),
            onTap: () {
              var url = "https://chuysan.com/";
              UrlLauncher.launchURL(url);
              MyApp.analytics.sendAnalyticsEvent(
                  AnalyticsEvent.open_drawer_url, {'url': url});
            },
          ),
          ListTile(
            title: ThaiText(text: "ข้อมูล VTuber ไทยอ้างอิงจาก @PageABup"),
            trailing: Icon(Icons.open_in_new),
            onTap: () {
              var url =
                  "https://docs.google.com/spreadsheets/d/13V8K9cyBs8AtuAQM2Psfgt9vj9ZUe1gd2V45Fr1yEgk/";
              UrlLauncher.launchURL(url);
              MyApp.analytics.sendAnalyticsEvent(
                  AnalyticsEvent.open_drawer_url, {'url': url});
            },
          ),
          ListTile(
            title: ThaiText(text: "คำสงวนสิทธิ์"),
            trailing: Icon(Icons.open_in_new),
            onTap: () {
              var url =
                  "https://www.notion.so/f97473612ebc4166b1e8293624fb9062";
              UrlLauncher.launchURL(url);
              MyApp.analytics.sendAnalyticsEvent(
                  AnalyticsEvent.open_drawer_url, {'url': url});
            },
          ),
        ],
      ),
    );
  }
}
