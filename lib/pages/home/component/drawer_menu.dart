import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/announcement_banner.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/environment_setting.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

import '../../../main.dart';
import 'drawer_origin_type_radio_filter.dart';

class DrawerMenu extends StatefulWidget {
  final OriginType currentOriginType;
  final String lastUpdatedAt;
  final Function(OriginType) onChangeOriginType;
  final Function onTapAddChannelMenu;

  const DrawerMenu(
      {super.key,
      required this.currentOriginType,
      required this.lastUpdatedAt,
      required this.onChangeOriginType,
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
                    text: "ข้อมูลอัพเดต " + widget.lastUpdatedAt,
                    fontSize: 13,
                  ))),
          Card(
            child: DrawerOriginTypeRadioFilter(
              currentOriginType: widget.currentOriginType,
              onChanged: (newType) {
                if (newType != widget.currentOriginType) {
                  var typeLog = newType.toString();
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.setType, {'type': typeLog});
                  widget.onChangeOriginType(newType);
                }
              },
            ),
          ),
          Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Container(child: AnnouncementBanner(onPressed: () {
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.clickDeleteChannelAnnouncement,
                      {"from": "drawer"});
                  UrlLauncher.launchURL(
                      "https://www.notion.so/Public-d92d99d2b88a4747814834bcbdd9989f");
                })),
              ),
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
              ListTile(
                title: ThaiText(text: "สนับสนุนผู้พัฒนา"),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  var url = "https://ko-fi.com/chuymaster";
                  UrlLauncher.launchURL(url);
                  MyApp.analytics.sendAnalyticsEvent(
                      AnalyticsEvent.openDrawerUrl, {'url': url});
                },
                tileColor: Colors.orange[50],
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
                  text: "ข้อมูลอื่นๆ",
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: ThaiText(text: "VTuberTH Twitter List"),
                trailing: Icon(Icons.open_in_new),
                onTap: () {
                  var url = "https://twitter.com/i/lists/1349029647896350726";
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
