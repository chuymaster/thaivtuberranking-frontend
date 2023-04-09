import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/home/home_page.dart';
import 'package:thaivtuberranking/services/analytics.dart';

import '../../main.dart';

class ChannelRegistrationCompletePage extends StatelessWidget {
  static const String route = '/register_complete';

  @override
  Widget build(BuildContext context) {
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.screenLoaded, {
      AnalyticsParameterName.screenName:
          AnalyticsPageName.channelRegistrationComplete
    });

    return Scaffold(
        appBar: AppBar(
          title: Text("แจ้งเพิ่มแชนแนลสำเร็จ"),
        ),
        body: Align(
            alignment: Alignment.topCenter,
            child: Container(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: ThaiText(
                          text:
                              "ขอบคุณที่ส่งข้อมูลแชนแนล ทางทีมงานจะพิจารณาและนำเข้าสู่ฐานข้อมูลหากข้อมูลถูกต้อง"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    ElevatedButton(
                      child: ThaiText(
                        text: "กลับสู่หน้าแรก",
                        color: Colors.white,
                      ),
                      onPressed: () {
                        // ไม่ให้กลับมาหน้านี้อีกรอบ https://stackoverflow.com/a/46713257/10322917
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomePage.route, (route) => false);
                      },
                    )
                  ],
                ),
                width: 300)));
  }
}
