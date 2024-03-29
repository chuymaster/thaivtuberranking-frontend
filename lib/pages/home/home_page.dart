import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaivtuberranking/common/component/center_circular_progress_indicator.dart';
import 'package:thaivtuberranking/common/component/empty_error_notification.dart';
import 'package:thaivtuberranking/common/component/retryable_error_view.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/channel/component/action_button.dart';
import 'package:thaivtuberranking/pages/channel/component/expandable_fab.dart';
import 'package:thaivtuberranking/pages/channel_ranking/channel_ranking_page.dart';
import 'package:thaivtuberranking/pages/channel_registration/channel_registration_page.dart';
import 'package:thaivtuberranking/pages/home/component/drawer_menu.dart';
import 'package:thaivtuberranking/pages/home/component/search_icon_button.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/pages/home/home_view_model.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_container_page.dart';
import 'package:thaivtuberranking/providers/channel_list/channel_list_provider.dart';
import 'package:thaivtuberranking/providers/locale_provider.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';
import 'dart:core';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  static const String route = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _viewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.screenLoaded,
        {AnalyticsParameterName.screenName: AnalyticsPageName.home});
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer3<ChannelListProvider, LocaleProvider, HomeViewModel>(
          builder: (context, provider, localeProvider, viewModel, _) {
        if (provider.viewState is LoadingState) {
          return Scaffold(body: CenterCircularProgressIndicator());
        } else if (provider.viewState is ErrorState) {
          final errorMessage = (provider.viewState as ErrorState).msg;
          return Scaffold(
              body: RetryableErrorView(
                  message: errorMessage,
                  retryAction: () => provider.getChannelList()));
        } else if (provider.channelList.isEmpty) {
          return Scaffold(body: EmptyErrorNotification());
        } else {
          return Scaffold(
            appBar: _buildAppBar(provider.channelList),
            drawer: _buildDrawerMenu(provider.channelListLastUpdatedAt, localeProvider),
            body: _buildBody(provider.channelList),
            bottomNavigationBar: _bottomNavigationBar,
            floatingActionButton: _expandableFab,
          );
        }
      }),
    );
  }

  PreferredSizeWidget _buildAppBar(List<ChannelInfo> channelList) {
    return AppBar(
        title: Text(
          _viewModel.tabIndex == 0
              ? L10n.strings.home_title_channel_list
              : L10n.strings.home_title_video_list,
          style: TextStyle(fontFamily: ThaiText.kanit),
        ),
        actions: [
          SearchIconButton(
              channelList: _viewModel.getFilteredChannelList(channelList))
        ]);
  }

  Widget _buildDrawerMenu(String lastUpdatedAt, LocaleProvider localeProvider) {
    return DrawerMenu(
        currentOriginType: _viewModel.originType,
        currentActivityType: _viewModel.activityType,
        lastUpdatedAt: lastUpdatedAt,
        onChangeOriginType: (originType) => _viewModel.originType = originType,
        onChangeActivityType: (activityType) =>
            _viewModel.activityType = activityType,
        onTapAddChannelMenu: () =>
            {this._navigateToChannelRegistrationPage("drawer_menu")},
            localeProvider: localeProvider,);
  }

  Widget get _bottomNavigationBar {
    return Container(
        height: _viewModel.isBottomNavigationBarHidden ? 0 : 80,
        child: NavigationBar(
          selectedIndex: _viewModel.tabIndex,
          destinations: [
            NavigationDestination(
                icon: Icon(Icons.person_pin), label: L10n.strings.home_tab_channel),
            NavigationDestination(
                icon: Icon(Icons.ondemand_video), label: L10n.strings.home_tab_video),
          ],
          onDestinationSelected: (index) {
            MyApp.analytics.sendAnalyticsEvent(
                AnalyticsEvent.changeBottomTab, {"index": index});
            _viewModel.tabIndex = index;
          },
        ));
  }

  Widget get _expandableFab {
    return ExpandableFab(distance: 80.0, children: [
      ActionButton(
        onPressed: () =>
            _navigateToChannelRegistrationPage('appbar_add_button'),
        icon: const Icon(Icons.add_circle),
        tooltip: L10n.strings.navigation_menu_menu_add_new_channel,
      ),
      ActionButton(
          onPressed: () => _viewModel.toggleDisplayInactiveChannel(),
          icon: _viewModel.activityType.icon,
          tooltip: _viewModel.activityType.tooltip),
      ActionButton(
          onPressed: () => _viewModel.toggleChannelOriginType(),
          icon: _viewModel.originType.icon,
          tooltip: _viewModel.originType.tooltip)
    ]);
  }

  void _navigateToChannelRegistrationPage(String location) {
    Navigator.pushNamed(context, ChannelRegistrationPage.route);
    MyApp.analytics.sendAnalyticsEvent(
        AnalyticsEvent.viewChannelRegistrationPage, {'location': location});
  }

  Widget _buildBody(List<ChannelInfo> channelList) {
    // Attach `key` here to force reinit the page therefore passing new value from the viewModel.
    // REF: https://www.raywenderlich.com/22416843-unlocking-your-flutter-widgets-with-keys#toc-anchor-006
    if (_viewModel.tabIndex == 0) {
      return ChannelRankingPage(
          channelList: _viewModel.getFilteredChannelList(channelList),
          didScrollDown: () => {_viewModel.isBottomNavigationBarHidden = true},
          didScrollUp: () => {_viewModel.isBottomNavigationBarHidden = false},
          key: Key("ChannelRankingPage_" +
              _viewModel
                  .getFilteredChannelList(channelList)
                  .length
                  .toString()));
    }
    return VideoRankingContainerPage(
        originType: _viewModel.originType,
        didScrollDown: () => {_viewModel.isBottomNavigationBarHidden = true},
        didScrollUp: () => {_viewModel.isBottomNavigationBarHidden = false},
        key: Key(
            "VideoRankingContainerPage_" + _viewModel.originType.toString()));
  }
}
