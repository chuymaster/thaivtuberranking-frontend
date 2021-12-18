import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaivtuberranking/common/component/center_circular_progress_indicator.dart';
import 'package:thaivtuberranking/common/component/empty_error_notification.dart';
import 'package:thaivtuberranking/common/component/retryable_error_view.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/channel_ranking/channel_ranking_page.dart';
import 'package:thaivtuberranking/pages/home/component/drawer_menu.dart';
import 'package:thaivtuberranking/pages/home/component/search_icon_button.dart';
import 'package:thaivtuberranking/pages/home/home_view_model.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_container_page.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:thaivtuberranking/pages/add/add_page.dart';
import 'dart:core';
import 'entity/origin_type.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  static const String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  OriginType _currentOriginType = OriginType.OriginalOnly;
  final _viewModel = HomeViewModel();

  String _lastUpdated = "";

  int _currentIndex = 0;

  String _title = "จัดอันดับวิดีโอ VTuber ไทย";

  bool _isBottomNavigationBarHidden = false;

  // MARK:- Functions

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.home});

    _viewModel.getChannelList();
  }

  /// Build All
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer<HomeViewModel>(builder: (context, viewModel, _) {
        if (viewModel.viewState is LoadingState) {
          return CenterCircularProgressIndicator();
        } else if (viewModel.viewState is ErrorState) {
          final errorMessage = (viewModel.viewState as ErrorState).msg;
          return RetryableErrorView(
              message: errorMessage,
              retryAction: () {
                viewModel.getChannelList();
              });
        } else if (viewModel.channelList.isEmpty) {
          return EmptyErrorNotification();
        } else {
          return Scaffold(
            appBar: _appBar,
            drawer: _drawerMenu,
            body: _buildBottomNavigationBarChildren()[_currentIndex],
            bottomNavigationBar: _bottomNavigationBar,
            floatingActionButton: _floatingActionButton,
          );
        }
      }),
    );
  }

  PreferredSizeWidget get _appBar {
    return AppBar(
        title: Text(
          _title,
          style: TextStyle(fontFamily: ThaiText.kanit),
        ),
        actions: [
          SearchIconButton(
              channelList:
                  _viewModel.getFilteredChannelList(_currentOriginType))
        ]);
  }

  Widget get _drawerMenu {
    return DrawerMenu(
        currentOriginType: _currentOriginType,
        lastUpdatedAt: _lastUpdated,
        onChangeOriginType: (originType) => {
              setState(() {
                this._currentOriginType = originType;
              })
            },
        onTapAddChannelMenu: () => {this._navigateToAddPage("drawer_menu")});
  }

  Widget get _bottomNavigationBar {
    return Container(
        height: _isBottomNavigationBarHidden ? 0 : 56,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.ondemand_video), label: "วิดีโอ"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin), label: "แชนแนล"),
          ],
          onTap: (index) {
            MyApp.analytics.sendAnalyticsEvent(
                AnalyticsEvent.change_bottom_tab, {"index": index});
            setState(() {
              _currentIndex = index;
              // เปลี่ยนชื่อ title ตาม tab
              if (index == 0) {
                _title = "จัดอันดับวิดีโอ VTuber ไทย";
              } else {
                _title = "จัดอันดับแชนแนล VTuber ไทย";
              }
            });
          },
        ));
  }

  Widget get _floatingActionButton {
    return FloatingActionButton(
      child: Icon(Icons.add_circle),
      tooltip: 'แจ้งเพิ่มแชนแนล VTuber',
      onPressed: () => _navigateToAddPage('appbar_add_button'),
    );
  }

  void _navigateToAddPage(String location) {
    var channelIdList = _viewModel.channelList.map((e) => e.channelId).toList();

    Navigator.pushNamed(context, AddPage.route, arguments: channelIdList);
    MyApp.analytics.sendAnalyticsEvent(
        AnalyticsEvent.view_add_page, {'location': location});
  }

  List<Widget> _buildBottomNavigationBarChildren() {
    return [
      VideoRankingContainerPage(
        originType: _currentOriginType,
        didScrollDown: () {
          if (!_isBottomNavigationBarHidden) {
            _isBottomNavigationBarHidden = true;
            setState(() {});
          }
        },
        didScrollUp: () {
          if (_isBottomNavigationBarHidden) {
            _isBottomNavigationBarHidden = false;
            setState(() {});
          }
        },
      ),
      ChannelRankingPage(
        channelList: _viewModel.getFilteredChannelList(_currentOriginType),
        didScrollDown: () {
          if (!_isBottomNavigationBarHidden) {
            _isBottomNavigationBarHidden = true;
            setState(() {});
          }
        },
        didScrollUp: () {
          if (_isBottomNavigationBarHidden) {
            _isBottomNavigationBarHidden = false;
            setState(() {});
          }
        },
      ),
    ];
  }
}
