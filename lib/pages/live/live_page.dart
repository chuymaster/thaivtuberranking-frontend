import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/center_circular_progress_indicator.dart';
import 'package:thaivtuberranking/common/component/custom_constraints.dart';
import 'package:thaivtuberranking/common/component/error_dialog.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/live/component/live_video_listtile.dart';
import 'package:thaivtuberranking/pages/live/entity/live_video.dart';
import 'package:thaivtuberranking/pages/live/live_repository.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

class LivePage extends StatefulWidget {
  final OriginType originType;
  const LivePage({Key? key, required this.originType}) : super(key: key);

  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  final LiveRepository _repository = LiveRepository();
  List<LiveVideo> _liveVideos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.live});
    loadData();
  }

  void loadData() async {
    final result = await _repository.getLiveVideos();
    if (result is SuccessState) {
      final List<LiveVideo> liveVideos = result.value;

      setState(() {
        _liveVideos = liveVideos;
        _isLoading = false;
      });
    } else if (result is ErrorState) {
      ErrorDialog.showErrorDialog(
          'ไม่สามารถโหลดข้อมูลไลฟ์ได้\nโปรดลองใหม่ในภายหลัง',
          result.msg,
          context);
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_isLoading) {
      body = CenterCircularProgressIndicator();
    } else {
      body = _buildLiveVideosWidget();
      // body = Column(
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     _liveTitleText,
      //     _buildLiveVideosWidget(),
      //     _upcomingTitleText,
      //     _buildEmptyWidget(),
      //   ],
      // );
    }
    return Center(
      child: Container(
        child: body,
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

  Widget _buildLiveVideosWidget() {
    if (_liveVideos.isEmpty) {
      return _buildEmptyWidget();
    } else {
      int itemCount = _liveVideos.length;
      var listView = ListView.builder(
        itemBuilder: (context, index) {
          return Container(
              child: Ink(
                  color: (index % 2 != 0 ? Colors.blue[50] : Colors.white),
                  child: LiveVideoListTile(
                    item: _liveVideos[index],
                    onTap: (liveVideo) {
                      UrlLauncher.launchURL(liveVideo.getVideoUrl());
                      // TODO:- add log
                    },
                    onTapChannelName: (channelId) {
                      // TODO:- open channel page
                    },
                  )));
        },
        itemCount: itemCount,
      );

      return Container(
        child: listView,
      );
    }
  }
}
