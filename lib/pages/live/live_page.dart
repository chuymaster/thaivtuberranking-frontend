import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/custom_constraints.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/services/analytics.dart';

class LivePage extends StatefulWidget {
  final OriginType originType;
  const LivePage({Key? key, required this.originType}) : super(key: key);

  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.live});
  }

  @override
  Widget build(BuildContext context) {
    Widget body;

    return Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _liveTitleText,
            _buildEmptyWidget(),
            _upcomingTitleText,
            _buildEmptyWidget(),
          ],
        ),
        constraints: CustomConstraints.pageBoxConstraints,
      ),
    );
  }

  Widget _liveTitleText = Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThaiText(
          text: "Live",
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        Divider(),
      ],
    ),
    padding: EdgeInsets.all(8),
  );

  Widget _upcomingTitleText = Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ThaiText(
          text: "Coming Soon",
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        Divider(),
      ],
    ),
    padding: EdgeInsets.all(8),
  );

  Widget _buildEmptyWidget() {
    return SizedBox(
        height: 200,
        child: Container(
          child: Align(
              alignment: Alignment.center,
              child: ThaiText(
                text: "ไม่มีวิดีโอ",
                color: Colors.black54,
              )),
        ));
  }
}
