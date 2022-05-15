import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thaivtuberranking/common/component/center_circular_progress_indicator.dart';
import 'package:thaivtuberranking/common/component/retryable_error_view.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/common/screenFactor.dart';
import 'package:thaivtuberranking/pages/channel/channel_view_model.dart';
import 'package:thaivtuberranking/pages/channel/component/channel_chart_view.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:oktoast/oktoast.dart';

class ChannelPage extends StatefulWidget {
  ChannelPage({super.key, required this.channelId});

  static const String route = '/channel';

  final String channelId;

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  ChannelViewModel _viewModel = ChannelViewModel();

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.screenLoaded,
        {AnalyticsParameterName.screenName: AnalyticsPageName.channel});

    _viewModel.getChannelInfo(widget.channelId);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer<ChannelViewModel>(builder: (context, viewModel, _) {
        if (viewModel.viewState is LoadingState) {
          return Scaffold(
            body: CenterCircularProgressIndicator(),
            appBar: AppBar(),
          );
        } else if (viewModel.viewState is ErrorState) {
          final errorMessage = (viewModel.viewState as ErrorState).msg;
          return Scaffold(
              body: RetryableErrorView(
                  message: errorMessage,
                  retryAction: () =>
                      viewModel.getChannelInfo(widget.channelId)));
        } else {
          return Scaffold(
              appBar: PreferredSize(
                  preferredSize:
                      Size.fromHeight(44.0), // here the desired height
                  child: AppBar(
                    title: Text(_viewModel.title),
                  )),
              body: Align(
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                      width: getContentWidth(context),
                      child: SingleChildScrollView(
                          child: Container(
                              alignment: Alignment.topCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  _basicInfo,
                                  _description,
                                  Padding(padding: EdgeInsets.all(8)),
                                  _annotationText,
                                  _chartDataView,
                                  _rawDataLink
                                ],
                              ))))));
        }
      }),
    );
  }

  void _launchChannelUrl() {
    if (_viewModel.channelInfo != null) {
      UrlLauncher.launchURL(_viewModel.channelInfo!.channelUrl);
      MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.clickVtuberUrl, {
        'name': _viewModel.channelInfo!.channelName,
        'url': _viewModel.channelInfo!.channelUrl,
        'location': 'icon_url'
      });
    }
  }

  Widget get _shareButton {
    final icon = Icon(Icons.content_copy);
    final text = ThaiText(
        text: 'Copy URL ของหน้านี้', fontSize: 14, color: Colors.black54);
    final inkWell = InkWell(
      child: Row(
        children: [icon, text],
      ),
      onTap: () async {
        final id = widget.channelId;
        final channelUrl =
            "https://vtuber.chuysan.com/#/channel?channel_id=$id";
        await Clipboard.setData(new ClipboardData(text: channelUrl));
        showToast("Copy URL แล้ว");
        MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.copyChannelUrl,
            {"channel_id": widget.channelId, "url": channelUrl});
      },
    );
    return inkWell;
  }

  Widget get _annotationText {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: ThaiText(
          text: 'กราฟความเปลี่ยนแปลง',
          fontSize: 14,
          color: Colors.grey[500] ?? Colors.grey),
      alignment: Alignment.bottomLeft,
    );
  }

  Widget get _description {
    String description = 'ไม่มีคำอธิบาย';
    if (_viewModel.channelInfo != null &&
        _viewModel.channelInfo!.description.isNotEmpty) {
      description = _viewModel.channelInfo!.description;
    }

    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(16))),
      padding: EdgeInsets.all(16),
      child: ThaiText(
        text: description,
        overflow: TextOverflow.clip,
        fontSize: 13,
      ),
    );
  }

  Widget get _basicInfo {
    if (_viewModel.channelInfo != null) {
      final fadeInImage = ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: FadeInImage.memoryNetwork(
            height: 120.0,
            width: 120.0,
            placeholder: kTransparentImage,
            image: _viewModel.channelInfo!.iconUrl,
            fit: BoxFit.contain,
            fadeInDuration: Duration(milliseconds: 300),
          ));

      final youtubeIcon = Container(
        child: Image.asset('assets/images/youtube_button.png'),
        padding: EdgeInsets.all(4),
        width: 120.0,
      );

      final imageWithYoutubeIcon = Column(
        children: [fadeInImage, youtubeIcon],
      );

      final subscribers = _viewModel.channelInfo!.subscribersString;
      final views = _viewModel.channelInfo!.viewsString;
      final updated = _viewModel.channelInfo!.lastPublishedVideoAtString;
      final published = _viewModel.channelInfo!.publishedAtString;

      return Container(
          child: Row(children: [
            InkWell(
              child: imageWithYoutubeIcon,
              onTap: () => _launchChannelUrl(),
            ),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            Expanded(
              child: Column(
                children: [
                  InkWell(
                    child: ThaiText(
                        text: _viewModel.channelInfo!.channelName,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis),
                    onTap: () => _launchChannelUrl(),
                  ),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  ThaiText(
                      text: 'ผู้ติดตาม $subscribers คน\nดู $views ครั้ง',
                      fontSize: 16),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  ThaiText(
                      text: 'คลิปล่าสุด $updated\nวันเปิดแชนแนล $published',
                      fontSize: 14,
                      color: Colors.black54),
                  Padding(
                    padding: EdgeInsets.all(4),
                  ),
                  _shareButton
                ],
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            )
          ]),
          padding: EdgeInsets.all(16));
    } else {
      return Container();
    }
  }

  Widget get _chartDataView {
    if (_viewModel.chartData != null) {
      double width = getContentWidth(context);
      return ChannelChartView(
          channelChartData: _viewModel.chartData!,
          width: width,
          height: width * 9 / 16);
    } else {
      return Container();
    }
  }

  Widget get _rawDataLink {
    return Container(
      child: InkWell(
        child: ThaiText(
          text: "API",
          fontSize: 12,
          color: Colors.blue,
        ),
        onTap: () {
          UrlLauncher.launchURL(
              'https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/chart_data/' +
                  widget.channelId +
                  '.json');
          MyApp.analytics
              .sendAnalyticsEvent(AnalyticsEvent.clickChannelStatisticsApi, {
            'id': widget.channelId,
          });
        },
      ),
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
    );
  }
}
