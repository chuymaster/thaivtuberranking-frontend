import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/home/home_page.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';

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
          title: Text(L10n.strings.channel_registration_complete_text_title),
        ),
        body: Align(
            alignment: Alignment.topCenter,
            child: Container(
                child: ListView(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: ThaiText(
                          text: L10n.strings.channel_registration_complete_text_description),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                    ),
                    FilledButton(
                      child: ThaiText(
                        text: L10n.strings.channel_registration_complete_button_home,
                        color: Theme.of(context).colorScheme.onPrimary,
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
