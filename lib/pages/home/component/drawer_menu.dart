import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';
import 'package:thaivtuberranking/pages/home/component/drawer_activity_type_radio_filter.dart';
import 'package:thaivtuberranking/pages/home/component/drawer_language_selection.dart';
import 'package:thaivtuberranking/pages/home/entity/activity_type.dart';
import 'package:thaivtuberranking/pages/home/entity/app_language.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/providers/locale_provider.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/environment_setting.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

import '../../../main.dart';
import 'drawer_origin_type_radio_filter.dart';

class DrawerMenu extends StatefulWidget {
  final OriginType currentOriginType;
  final ActivityType currentActivityType;
  final String lastUpdatedAt;
  final Function(OriginType) onChangeOriginType;
  final Function(ActivityType) onChangeActivityType;
  final Function onTapAddChannelMenu;
  final LocaleProvider localeProvider;

  const DrawerMenu(
      {super.key,
      required this.currentOriginType,
      required this.currentActivityType,
      required this.lastUpdatedAt,
      required this.onChangeOriginType,
      required this.onChangeActivityType,
      required this.onTapAddChannelMenu,
      required this.localeProvider});

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
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
              text: L10n.strings.navigation_menu_info_site_title(prefix),
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: ThaiText.kanit,
            ),
            accountEmail: ThaiText(
              text: L10n.strings.navigation_menu_info_site_description,
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
                    text: L10n.strings.navigation_menu_info_last_updated_at(widget.lastUpdatedAt),
                    fontSize: 13,
                  ))),
          Card(
            child: DrawerOriginTypeRadioFilter(
              currentOriginType: widget.currentOriginType,
              onChanged: (newType) {
                if (newType != widget.currentOriginType) {
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.setOriginType, {'type': newType.name});
                  widget.onChangeOriginType(newType);
                }
              },
            ),
          ),
          Card(
            child: DrawerActivityTypeRadioFilter(
              currentActivityType: widget.currentActivityType,
              onChanged: (newType) {
                if (newType != widget.currentActivityType) {
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.setActivityType, {'type': newType.name});
                  widget.onChangeActivityType(newType);
                }
              },
            ),
          ),
          Card(
            child: DrawerLanguageSelection(localeProvider: widget.localeProvider,)
          ),
          Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 8, 4, 8),
                child: ThaiText(
                  text: L10n.strings.navigation_menu_menu_title,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: ThaiText(text: L10n.strings.navigation_menu_menu_add_new_channel),
                trailing: Icon(Icons.add),
                onTap: () => {widget.onTapAddChannelMenu()},
              ),
              ListTile(
                title:
                    ThaiText(text: L10n.strings.navigation_menu_menu_report_problems),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  var url = "https://twitter.com/chuymaster";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
                },
              ),
              ListTile(
                title: ThaiText(text: L10n.strings.navigation_menu_menu_deletion_criterias),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  var url =
                      "https://chuysan.notion.site/Public-d92d99d2b88a4747814834bcbdd9989f";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
                },
              ),
              ListTile(
                title: ThaiText(text: L10n.strings.navigation_menu_menu_disclaimer),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  var url =
                      "https://chuysan.notion.site/Public-f97473612ebc4166b1e8293624fb9062";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
                },
              ),
            ],
          )),
          Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 8, 4, 8),
                child: ThaiText(
                  text: L10n.strings.navigation_menu_menu_discover_thai_vtuber,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: ThaiText(text: "VTuberThaiInfo", color: Colors.blue, fontWeight: FontWeight.bold),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  var url = "https://vtuberthaiinfo.com/";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
                },
              ),
              ListTile(
                title: ThaiText(text: "X #VTuberTH"),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  var url = "https://twitter.com/hashtag/VtuberTH";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
                },
              ),
              ListTile(
                title:
                    ThaiText(text: "VTuber Indonesia / Malaysia / Philippines"),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  var url = "https://vtuber.asia/";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
                },
              ),
            ],
          )),
          Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 8, 4, 8),
                child: ThaiText(
                  text: L10n.strings.navigation_menu_menu_for_developers,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: ThaiText(text: L10n.strings.navigation_menu_menu_api_document),
                trailing: Icon(Icons.developer_mode),
                onTap: () {
                  var url =
                      "https://github.com/chuymaster/thaivtuberranking-docs";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
                },
              ),
              ListTile(
                title: ThaiText(text: L10n.strings.navigation_menu_menu_client_app_repo),
                trailing: Icon(Icons.developer_mode),
                onTap: () {
                  var url =
                      "https://github.com/chuymaster/thaivtuberranking-frontend";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
                },
              ),
              ListTile(
                title: ThaiText(text: L10n.strings.navigation_menu_menu_release_notes),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  var url =
                      "https://chuysan.notion.site/Public-Release-Notes-fddbe59f838949038fcaa4d774a4f2fc";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
                },
              ),
              ListTile(
                title: ThaiText(text: L10n.strings.navigation_menu_menu_developer_blog),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  var url = "https://chuysan.com/";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
                },
              ),
            ],
          )),
        ],
      ),
    );
  }
}
