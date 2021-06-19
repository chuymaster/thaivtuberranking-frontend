import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/common/strings.dart';
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
      {Key? key,
      required this.currentOriginType,
      required this.lastUpdatedAt,
      required this.onChangeOriginType,
      required this.onTapAddChannelMenu})
      : super(key: key);

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
                  widget.onChangeOriginType(newType);
                }
              },
            ),
          ),
          ListTile(
            title: ThaiText(text: "แจ้งเพิ่มแชนแนล"),
            trailing: Icon(Icons.add),
            onTap: () => {widget.onTapAddChannelMenu()},
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
              var url = "https://github.com/chuymaster/thaivtuberranking-docs";
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
