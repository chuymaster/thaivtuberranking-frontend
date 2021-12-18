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

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  static const String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.home});

    _viewModel.getChannelList();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer<HomeViewModel>(builder: (context, viewModel, _) {
        if (viewModel.viewState is LoadingState) {
          return Scaffold(body: CenterCircularProgressIndicator());
        } else if (viewModel.viewState is ErrorState) {
          final errorMessage = (viewModel.viewState as ErrorState).msg;
          return Scaffold(
              body: RetryableErrorView(
                  message: errorMessage,
                  retryAction: () => viewModel.getChannelList()));
        } else if (viewModel.channelList.isEmpty) {
          return Scaffold(body: EmptyErrorNotification());
        } else {
          return Scaffold(
            appBar: _appBar,
            drawer: _drawerMenu,
            body: _body,
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
          _viewModel.tabIndex == 0
              ? "จัดอันดับวิดีโอ VTuber ไทย"
              : "จัดอันดับแชนแนล VTuber ไทย",
          style: TextStyle(fontFamily: ThaiText.kanit),
        ),
        actions: [
          SearchIconButton(channelList: _viewModel.filteredChannelList)
        ]);
  }

  Widget get _drawerMenu {
    return DrawerMenu(
        currentOriginType: _viewModel.originType,
        lastUpdatedAt: _viewModel.lastUpdated,
        onChangeOriginType: (originType) =>
            _viewModel.changeOriginType(originType),
        onTapAddChannelMenu: () => {this._navigateToAddPage("drawer_menu")});
  }

  Widget get _bottomNavigationBar {
    return Container(
        height: _viewModel.isBottomNavigationBarHidden ? 0 : 56,
        child: BottomNavigationBar(
          currentIndex: _viewModel.tabIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.ondemand_video), label: "วิดีโอ"),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_pin), label: "แชนแนล"),
          ],
          onTap: (index) {
            MyApp.analytics.sendAnalyticsEvent(
                AnalyticsEvent.change_bottom_tab, {"index": index});
            _viewModel.changeTabIndex(index);
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
    Navigator.pushNamed(context, AddPage.route,
        arguments: _viewModel.channelIdList);
    MyApp.analytics.sendAnalyticsEvent(
        AnalyticsEvent.view_add_page, {'location': location});
  }

  Widget get _body {
    if (_viewModel.tabIndex == 0) {
      return VideoRankingContainerPage(
          originType: _viewModel.originType,
          didScrollDown: () => _viewModel.hideBottomNavigationBar(),
          didScrollUp: () => _viewModel.showBottomNavigationBar());
    }
    return ChannelRankingPage(
        channelList: _viewModel.filteredChannelList,
        didScrollDown: () => _viewModel.hideBottomNavigationBar(),
        didScrollUp: () => _viewModel.showBottomNavigationBar());
  }
}
