import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/center_circular_progress_indicator.dart';
import 'package:thaivtuberranking/common/component/custom_constraints.dart';
import 'package:thaivtuberranking/common/component/empty_error_notification.dart';
import 'package:thaivtuberranking/common/component/error_dialog.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:thaivtuberranking/pages/channel/channel_page.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/video_ranking/component/video_ranking_list.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_repository.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';
import 'entity/video_ranking.dart';

class VideoRankingPage extends StatefulWidget {
  final OriginType originType;
  final VideoRankingType rankingType;

  const VideoRankingPage({Key key, this.originType, this.rankingType})
      : super(key: key);
  @override
  _VideoRankingPageState createState() => _VideoRankingPageState();
}

class _VideoRankingPageState extends State<VideoRankingPage> {
  final _repository = VideoRankingRepository();
  List<VideoRanking> _ranking = [];
  var _isLoading = true;

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.video_ranking});
    loadData();
  }

  void loadData() async {
    final result = await _repository.getVideoRanking(widget.rankingType);
    if (result is SuccessState) {
      setState(() {
        _ranking = result.value;
        _isLoading = false;
      });
    } else if (result is ErrorState) {
      ErrorDialog.showErrorDialog(
          "ไม่สามารถโหลดข้อมูลวิดีโอได้\nโปรดลองใหม่ในภายหลัง",
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

  List<VideoRanking> _getFilteredVideoList() {
    switch (widget.originType) {
      case OriginType.OriginalOnly:
        return _ranking.where((element) => (!element.isRebranded)).toList();
      case OriginType.All:
        return _ranking;
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (_isLoading) {
      body = CenterCircularProgressIndicator();
    } else {
      List<VideoRanking> videoRankingList = _getFilteredVideoList();
      if (videoRankingList.isEmpty) {
        body = EmptyErrorNotification();
      } else {
        body = VideoRankingList(
          videoRankingList: _getFilteredVideoList(),
          onTap: (item) {
            UrlLauncher.launchURL(item.getVideoUrl());
            MyApp.analytics.sendAnalyticsEvent(
                AnalyticsEvent.open_video_url, {'url': item.getVideoUrl()});
          },
          onTapChannelName: (item) {
            Navigator.pushNamed(context, ChannelPage.route,
                arguments: item.channelId);
            MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.view_detail, {
              'channel_id': item.channelId,
              'channel_name': item.channelTitle
            });
          },
        );
      }
    }
    return Align(
      child: Container(
        child: body,
        constraints: CustomConstraints.pageBoxConstraints,
      ),
      alignment: Alignment.topCenter,
    );
  }
}
