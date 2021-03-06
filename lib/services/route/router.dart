import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/search/search_page.dart';
import 'string_extension.dart';
import 'routing_data.dart';
import '../../pages/add/add_complete_page.dart';
import '../../pages/add/add_page.dart';
import '../../pages/channel/channel_page.dart';
import '../../pages/error/error_page.dart';
import '../../pages/home/home_page.dart';

// For test: channel?channel_id=UCqhhWjpw23dWhJ5rRwCCrMA

/// Source from https://www.filledstacks.com/post/flutter-navigation-cheatsheet-a-guide-to-named-routing/
/// and https://www.filledstacks.com/post/flutter-web-advanced-navigation/
Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  RoutingData routingData = settings.name.getRoutingData;

  switch (routingData.route) {
    case ChannelPage.route:
      String channelId = routingData["channel_id"];
      if (channelId == null) {
        channelId = settings.arguments as String;
      }
      if (channelId != null) {
        String routeName = ChannelPage.route + "?channel_id=" + channelId;

        return MaterialPageRoute(
            builder: (context) => ChannelPage(
                  channelId: channelId,
                ),
            settings: RouteSettings(name: routeName));
      } else {
        return MaterialPageRoute(
            builder: (context) => _buildNotFoundPage(routingData.route),
            settings: RouteSettings(name: ErrorPage.route));
      }
      break;
    case HomePage.route:
      return MaterialPageRoute(
          builder: (context) => HomePage(),
          settings: RouteSettings(name: HomePage.route));
    case AddPage.route:
      var vTuberChannelIdList = settings.arguments;
      return MaterialPageRoute(
          builder: (context) => AddPage(
                vTuberChannelIdList: vTuberChannelIdList,
              ),
          settings: RouteSettings(name: AddPage.route));
    case AddCompletePage.route:
      return MaterialPageRoute(
          builder: (context) => AddCompletePage(),
          settings: RouteSettings(name: AddCompletePage.route));
    case SearchPage.route:
      if (settings.arguments != null) {
        var args = settings.arguments as List;
        return MaterialPageRoute(
            builder: (context) => SearchPage(
                  channelList: args[0],
                  originType: args[1],
                ),
            settings: RouteSettings(name: SearchPage.route));
      }
      return MaterialPageRoute(
          builder: (context) => SearchPage(),
          settings: RouteSettings(name: SearchPage.route));

    default:
      return MaterialPageRoute(
          builder: (context) => _buildNotFoundPage(routingData.route),
          settings: RouteSettings(name: ErrorPage.route));
  }
}

Widget _buildNotFoundPage(String route) {
  return ErrorPage(
    name: 'Not Found',
    errorMessage:
        "ไม่พบเพจที่ต้องการเปิด (" + route + ").\nโปรดตรวจสอบ URL อีกครั้ง",
  );
}
