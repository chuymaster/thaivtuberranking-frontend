import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/home/home_page.dart';
import 'package:thaivtuberranking/services/analytics.dart';

import '../../main.dart';

class AddCompletePage extends StatelessWidget {
  static const String route = '/add_completed';

  @override
  Widget build(BuildContext context) {
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.add_complete});

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
                              "ขอบคุณที่ส่งข้อมูลแชนแนล ทางทีมงานจะพิจารณาและนำเข้าสู่การจัดอันดับหากข้อมูลถูกต้อง"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    RaisedButton(
                      child: ThaiText(
                        text: "กลับสู่หน้าแรก",
                        color: Colors.white,
                      ),
                      color: Theme.of(context).accentColor,
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
