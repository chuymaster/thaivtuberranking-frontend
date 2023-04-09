import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/home/component/drawer_activity_type_radio_filter.dart';
import 'package:thaivtuberranking/pages/home/entity/activity_type.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
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

  const DrawerMenu(
      {super.key,
      required this.currentOriginType,
      required this.currentActivityType,
      required this.lastUpdatedAt,
      required this.onChangeOriginType,
      required this.onChangeActivityType,
      required this.onTapAddChannelMenu});

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
              text: prefix + "Thai VTubers Directory",
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: ThaiText.kanit,
            ),
            accountEmail: ThaiText(
              text:
                  "เว็บนี้จัดทำเพื่อส่งเสริมวงการ VTuber ไทย\nผ่านการเรียบเรียงรายชื่อแชนแนล VTuber คนไทยบนยูทูป",
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
                    text: "ข้อมูลอัปเดต " + widget.lastUpdatedAt,
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
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 8, 4, 8),
                child: ThaiText(
                  text: "เมนู",
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: ThaiText(text: "แจ้งเพิ่มแชนแนล"),
                trailing: Icon(Icons.add),
                onTap: () => {widget.onTapAddChannelMenu()},
              ),
              ListTile(
                title:
                    ThaiText(text: "แจ้งปัญหา/แจ้งข้อมูลแชนแนลผิด/เสนอฟีเจอร์"),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  var url = "https://twitter.com/chuymaster";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
                },
              ),
              ListTile(
                title: ThaiText(text: "เกณฑ์การลบแชนแนลโดยอัตโนมัติ"),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  var url =
                      "https://www.notion.so/Public-d92d99d2b88a4747814834bcbdd9989f";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
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
                  text: "ข้อมูลสำหรับนักพัฒนา",
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: ThaiText(text: "API Document"),
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
                title: ThaiText(text: "Release Notes"),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  var url =
                      "https://www.notion.so/Public-Release-Notes-fddbe59f838949038fcaa4d774a4f2fc";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
                },
              ),
              ListTile(
                title: ThaiText(text: "บล็อกผู้พัฒนา"),
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
          Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(16, 8, 4, 8),
                child: ThaiText(
                  text: "แหล่งข้อมูล VTuber",
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: ThaiText(text: "Twitter #VTuberTH"),
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
        ],
      ),
    );
  }
}
