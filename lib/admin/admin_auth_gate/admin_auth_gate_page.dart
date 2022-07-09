import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../services/analytics.dart';
import '../authentication.dart';
import '../channel_request/channel_request_page.dart';

class AdminAuthGatePage extends StatelessWidget {
  static const String route = '/megumin';

  @override
  Widget build(BuildContext context) {
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.screenLoaded,
        {AnalyticsParameterName.screenName: AnalyticsPageName.adminAuthGate});
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            showAuthActionSwitch: false,
            providerConfigs: [
              GoogleProviderConfiguration(
                  clientId: Authentication.instance.options.appId),
            ],
            footerBuilder: (context, _) {
              return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    'Access is limited to only authorized person.💥',
                    style: TextStyle(color: Colors.grey),
                  ));
            },
          );
        }
        return const ChannelRequestPage();
      },
    );
  }
}
