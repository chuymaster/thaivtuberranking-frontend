// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thaivtuberranking/common/component/center_circular_progress_indicator.dart';
import 'package:thaivtuberranking/common/component/custom_constraints.dart';
import 'package:thaivtuberranking/common/component/error_dialog.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/channel/channel_repository.dart';
import 'package:thaivtuberranking/pages/channel/component/chart_view.dart';
import 'package:thaivtuberranking/pages/channel/entity/channel_chart_data.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';
import 'package:thaivtuberranking/main.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:oktoast/oktoast.dart';

import 'component/sample_chart.dart';

class ChannelPage extends StatefulWidget {
  ChannelPage({Key? key, required this.channelId}) : super(key: key);

  static const String route = '/channel';

  final String channelId;

  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  ChannelInfo? _channelInfo;
  ChannelChartData? _channelChartData;
  ChannelRepository _repository = ChannelRepository();

  late double width;
  late double height;

  @override
  void initState() {
    super.initState();
    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.channel});

    _initStateAsync();
  }

  void _initStateAsync() async {
    var result = await _repository.getChannelInfo(widget.channelId);

    // Basic Info
    if (result is SuccessState) {
      setState(() {
        this._channelInfo = (result.value as ChannelInfo);
      });
    } else if (result is ErrorState) {
      ErrorDialog.showErrorDialog(
          'ไม่สามารถโหลดข้อมูล Channel ได้\nโปรดตรวจสอบ ID หรือลองใหม่ในภายหลัง',
          result.msg,
          context);
    } else {
      // loading
    }

    // Chart Data
    var chartResult = await _repository.getChannelChartData(widget.channelId);
    if (chartResult is SuccessState) {
      setState(() {
        this._channelChartData = (chartResult.value as ChannelChartData);
      });
    } else if (result is ErrorState) {
      print(result.msg); // do nothing for error
    }
  }

  @override
  Widget build(BuildContext context) {
    width = min(600, MediaQuery.of(context).size.width) - 20;
    height = width * 9 / 16;

    Widget body;
    if (_channelInfo != null) {
      body = Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
              child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      buildBasicInfo(),
                      buildDescription(),
                      Padding(padding: EdgeInsets.all(8)),
                      // _buildAnnotationText('วิดีโอล่าสุด'),
                      // _buildYoutubeView(),
                      _buildAnnotationText('กราฟความเปลี่ยนแปลง'),
                      _buildChartDataView(),
                      // AdsView(),
                    ],
                  ),
                  constraints: CustomConstraints.pageBoxConstraints)));
    } else {
      body = CenterCircularProgressIndicator();
    }

    String title = _channelInfo?.channelName ?? "";

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(44.0), // here the desired height
          child: AppBar(
            title: Text(title),
          )),
      body: body,
    );
  }

  void launchChannelUrl() {
    if (_channelInfo != null) {
      UrlLauncher.launchURL(_channelInfo!.getChannelUrl());
      MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.click_vtuber_url, {
        'name': _channelInfo!.channelName,
        'url': _channelInfo!.getChannelUrl(),
        'location': 'icon_url'
      });
    }
  }

  Widget _buildShareButton() {
    final icon = Icon(Icons.content_copy);
    final text = ThaiText(
        text: 'Copy URL ของหน้านี้', fontSize: 14, color: Colors.black54);
    final inkWell = InkWell(
      child: Row(
        children: [icon, text],
      ),
      onTap: () async {
        final id = widget.channelId;
        final host = window.location.host;
        final channelUrl = "$host/#/channel?channel_id=$id";
        await Clipboard.setData(new ClipboardData(text: channelUrl));
        showToast("Copy URL แล้ว");
        MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.copy_channel_url,
            {"channel_id": widget.channelId, "url": channelUrl});
      },
    );
    return inkWell;
  }

  Widget _buildAnnotationText(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
      child: ThaiText(
          text: text, fontSize: 14, color: Colors.grey[500] ?? Colors.grey),
      alignment: Alignment.centerLeft,
    );
  }

  Widget buildDescription() {
    String description = 'ไม่มีคำอธิบาย';
    if (_channelInfo != null && _channelInfo!.description.isNotEmpty) {
      description = _channelInfo!.description;
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

  Widget buildBasicInfo() {
    if (_channelInfo != null) {
      var fadeInImage = ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: FadeInImage.memoryNetwork(
            height: 120.0,
            width: 120.0,
            placeholder: kTransparentImage,
            image: _channelInfo!.iconUrl,
            fit: BoxFit.contain,
            fadeInDuration: Duration(milliseconds: 300),
          ));

      var youtubeIcon = Container(
        child: Image.asset('assets/images/youtube_button.png'),
        padding: EdgeInsets.all(4),
        width: 120.0,
      );

      var imageWithYoutubeIcon = Column(
        children: [fadeInImage, youtubeIcon],
      );

      var subscribers = _channelInfo!.getSubscribers();
      var views = _channelInfo!.getViews();
      var updated = _channelInfo!.getLastPublishedVideoAtString();
      var published = _channelInfo!.getPublishedAt();

      return Container(
          child: Row(children: [
            InkWell(
              child: imageWithYoutubeIcon,
              onTap: () {
                launchChannelUrl();
              },
            ),
            Padding(
              padding: EdgeInsets.all(8),
            ),
            Expanded(
              child: Column(
                children: [
                  InkWell(
                    child: ThaiText(
                        text: _channelInfo!.channelName,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        overflow: TextOverflow.ellipsis),
                    onTap: () {
                      launchChannelUrl();
                    },
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
                  _buildShareButton()
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

  // Widget _buildYoutubeView() {
  //   try {
  //     var video = _channelInfo.getLatestVideo();
  //     var videoId = video.id;

  //     return YouTubeVideoHtmlView(
  //         videoId: videoId, width: width, height: height);
  //   } catch (e) {
  //     var videoView = Container(
  //       child: Center(child: ThaiText(text: 'No video')),
  //       color: Colors.grey[300],
  //     );

  //     return SizedBox(width: width, height: height, child: videoView);
  //   }
  // }

  Widget _buildChartDataView() {
    if (_channelChartData != null) {
      return LineChartSample2(
        channelChartData: _channelChartData!,
      );
      // return ChartView(
      //   channelChartData: _channelChartData!,
      //   width: width,
      //   height: height,
      // );
    } else {
      return Container();
    }
  }
}
