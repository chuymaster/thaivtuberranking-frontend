import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:thaivtuberranking/common/component/center_circular_progress_indicator.dart';
import 'package:thaivtuberranking/common/component/empty_error_notification.dart';
import 'package:thaivtuberranking/common/component/retryable_error_view.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:thaivtuberranking/pages/channel/channel_page.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/video_ranking/component/video_ranking_list.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_repository.dart';
import 'package:thaivtuberranking/pages/video_ranking/video_ranking_view_model.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

class VideoRankingPage extends StatefulWidget {
  final OriginType originType;
  final VideoRankingType rankingType;
  final VoidCallback didScrollDown;
  final VoidCallback didScrollUp;

  const VideoRankingPage(
      {Key? key,
      required this.originType,
      required this.rankingType,
      required this.didScrollDown,
      required this.didScrollUp})
      : super(key: key);
  @override
  _VideoRankingPageState createState() => _VideoRankingPageState();
}

class _VideoRankingPageState extends State<VideoRankingPage> {
  late VideoRankingViewModel _viewModel =
      VideoRankingViewModel(widget.rankingType, widget.originType);
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.screenLoaded,
        {AnalyticsParameterName.screenName: AnalyticsPageName.videoRanking});
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        widget.didScrollDown();
      } else {
        widget.didScrollUp();
      }
    });
    _viewModel.getVideoRanking();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => _viewModel,
        child: Consumer<VideoRankingViewModel>(
          builder: (context, videoRankingViewModel, _) {
            if (videoRankingViewModel.viewState is LoadingState) {
              return CenterCircularProgressIndicator();
            } else if (videoRankingViewModel.viewState is ErrorState) {
              final errorMessage =
                  (videoRankingViewModel.viewState as ErrorState).msg;
              return RetryableErrorView(
                  message: errorMessage,
                  retryAction: () {
                    _viewModel.getVideoRanking();
                  });
            } else if (videoRankingViewModel.filteredVideoRanking.isEmpty) {
              return EmptyErrorNotification();
            } else {
              return Align(
                child: Container(
                  child: _videoRankingWidget,
                ),
                alignment: Alignment.topCenter,
              );
            }
          },
        ));
  }

  Widget get _videoRankingWidget {
    return VideoRankingList(
      scrollController: _scrollController,
      videoRankingList: _viewModel.filteredVideoRanking,
      onTap: (item) {
        UrlLauncher.launchURL(item.getVideoUrl());
        MyApp.analytics.sendAnalyticsEvent(
            AnalyticsEvent.openVideoUrl, {'url': item.getVideoUrl()});
      },
      onTapChannelName: (item) {
        Navigator.pushNamed(context, ChannelPage.route,
            arguments: item.channelId);
        MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.viewDetail,
            {'channel_id': item.channelId, 'channel_name': item.channelTitle});
      },
    );
  }
}
