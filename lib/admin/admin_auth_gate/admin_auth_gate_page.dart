import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:flutter/material.dart';
import 'package:thaivtuberranking/admin/channel_management/channel_management_page.dart';

import '../../common/component/confirm_dialog.dart';
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
        return _buildAuthorizedContentView(context);
      },
    );
  }

  Widget _buildAuthorizedContentView(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text("我が名はめぐみん！"),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Channel Requests",
                ),
                Tab(
                  text: "Channel Management",
                )
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout),
                tooltip: 'Logout',
                onPressed: () {
                  ConfirmDialog.show("Confirm Logout",
                      "Would you like to logout?", _logout, context);
                },
              ),
            ],
          ),
          body: const TabBarView(children: [
            const ChannelRequestPage(),
            const ChannelManagementPage()
          ]),
        ));
  }

  void _logout() {
    Authentication.instance.logout();
  }
}
