import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/admin/admin_auth_gate/admin_auth_gate_page.dart';
import 'package:thaivtuberranking/pages/channel_registration/channel_registration_complete_page.dart';
import 'package:thaivtuberranking/pages/channel_registration/channel_registration_page.dart';
import 'string_extension.dart';
import 'routing_data.dart';
import '../../pages/channel/channel_page.dart';
import '../../pages/error/error_page.dart';
import '../../pages/home/home_page.dart';

// For test: channel?channel_id=UCqhhWjpw23dWhJ5rRwCCrMA

/// Source from https://www.filledstacks.com/post/flutter-navigation-cheatsheet-a-guide-to-named-routing/
/// and https://www.filledstacks.com/post/flutter-web-advanced-navigation/
Route<dynamic> generateRoute(RouteSettings settings) {
  // Here we'll handle all the routing
  RoutingData? routingData = settings.name?.getRoutingData;

  if (routingData != null) {
    switch (routingData.route) {
      case ChannelPage.route:
        String? channelId = routingData["channel_id"];
        if (channelId == null) {
          channelId = settings.arguments as String?;
        }
        if (channelId != null) {
          String routeName = ChannelPage.route + "?channel_id=" + channelId;

          return MaterialPageRoute(
              builder: (context) => ChannelPage(
                    channelId: channelId!,
                  ),
              settings: RouteSettings(name: routeName));
        } else {
          return MaterialPageRoute(
              builder: (context) => _buildNotFoundPage(routingData.route),
              settings: RouteSettings(name: ErrorPage.route));
        }
      case HomePage.route:
        return MaterialPageRoute(
            builder: (context) => HomePage(),
            settings: RouteSettings(name: HomePage.route));
      case ChannelRegistrationPage.route:
        return MaterialPageRoute(
            builder: (context) => ChannelRegistrationPage(),
            settings: RouteSettings(name: ChannelRegistrationPage.route));
      case ChannelRegistrationCompletePage.route:
        return MaterialPageRoute(
            builder: (context) => ChannelRegistrationCompletePage(),
            settings:
                RouteSettings(name: ChannelRegistrationCompletePage.route));
      case AdminAuthGatePage.route:
        return MaterialPageRoute(
            builder: (context) => AdminAuthGatePage(),
            settings: RouteSettings(name: AdminAuthGatePage.route));
      default:
        return MaterialPageRoute(
            builder: (context) => _buildNotFoundPage(routingData.route),
            settings: RouteSettings(name: ErrorPage.route));
    }
  } else {
    return MaterialPageRoute(
        builder: (context) => HomePage(),
        settings: RouteSettings(name: HomePage.route));
  }
}

Widget _buildNotFoundPage(String route) {
  return ErrorPage(
    name: 'Not Found',
    errorMessage:
        "ไม่พบเพจที่ต้องการเปิด (" + route + ").\nโปรดตรวจสอบ URL อีกครั้ง",
  );
}
