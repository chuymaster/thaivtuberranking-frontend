import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:thaivtuberranking/common/component/center_circular_progress_indicator.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/channel/channel_page.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/live/component/live_video_listtile.dart';
import 'package:thaivtuberranking/pages/live/entity/live_video.dart';
import 'package:thaivtuberranking/pages/live/live_view_model.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';
import 'package:provider/provider.dart';

class LivePage extends StatefulWidget {
  final OriginType originType;
  final VoidCallback didScrollDown;
  final VoidCallback didScrollUp;

  const LivePage(
      {Key? key,
      required this.originType,
      required this.didScrollDown,
      required this.didScrollUp})
      : super(key: key);

  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  late LiveViewModel liveViewModel = LiveViewModel(widget.originType);
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.live});

    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        widget.didScrollDown();
      } else {
        widget.didScrollUp();
      }
    });
    liveViewModel.getLiveVideos();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => liveViewModel,
        child: Consumer<LiveViewModel>(
          builder: (context, liveViewModel, child) {
            // if (liveViewModel.errorMessage != null) {
            //   ErrorDialog.showErrorDialog(
            //       'ไม่สามารถโหลดข้อมูลไลฟ์ได้\nโปรดลองใหม่ในภายหลัง',
            //       liveViewModel.errorMessage,
            //       context);
            //   liveViewModel.clearErrorMessage();
            // }
            if (liveViewModel.isLoading) {
              return CenterCircularProgressIndicator();
            } else if (liveViewModel.filteredLiveVideos.isEmpty) {
              return _emptyVideoWidget;
            } else {
              return _liveVideosWidget;
            }
          },
        ));
  }

  Widget get _emptyVideoWidget {
    return Container(
      child: Align(
          alignment: Alignment.center,
          child: ThaiText(
            text: "ไม่มีวิดีโอ",
            color: Colors.black54,
          )),
    );
  }

  Widget get _liveVideosWidget {
    int itemCount = liveViewModel.filteredLiveVideos.length;
    var listView = ListView.builder(
      controller: _scrollController,
      itemBuilder: (context, index) {
        return Container(
            child: Ink(
                color: _buildRowColor(
                    index, liveViewModel.filteredLiveVideos[index]),
                child: LiveVideoListTile(
                  item: liveViewModel.filteredLiveVideos[index],
                  onTap: (liveVideo) {
                    UrlLauncher.launchURL(liveVideo.getVideoUrl());
                    MyApp.analytics.sendAnalyticsEvent(
                        AnalyticsEvent.open_video_url,
                        {'url': liveVideo.getVideoUrl()});
                  },
                  onTapChannelName: (liveVideo) {
                    Navigator.pushNamed(context, ChannelPage.route,
                        arguments: liveVideo.channelId);
                    MyApp.analytics.sendAnalyticsEvent(
                        AnalyticsEvent.view_detail, {
                      'channel_id': liveVideo.channelId,
                      'channel_name': liveVideo.channelTitle
                    });
                  },
                )));
      },
      itemCount: itemCount,
    );

    return Container(
      child: listView,
    );
  }

  Color? _buildRowColor(int index, LiveVideo liveVideo) {
    switch (liveVideo.liveStatus) {
      case LiveStatus.Live:
        return index % 2 != 0 ? Colors.orange[50] : Colors.orange[100];
      default:
        return index % 2 != 0 ? Colors.blue[50] : Colors.white;
    }
  }
}
