import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html';

class YouTubeVideoHtmlView extends StatefulWidget {
  final String videoId;
  final double width;
  final double height;

  const YouTubeVideoHtmlView({Key key, this.videoId, this.width, this.height})
      : super(key: key);

  @override
  _YouTubeVideoHtmlViewState createState() => _YouTubeVideoHtmlViewState();
}

class _YouTubeVideoHtmlViewState extends State<YouTubeVideoHtmlView> {
  // Most codes are from https://github.com/AseemWangoo/experiments_with_web/blob/master/lib/iframe/iframe.dart
  IFrameElement _iframeElement = IFrameElement();
  Widget _iframeWidget;

  @override
  void initState() {
    super.initState();

    _iframeElement.height = '${widget.width}';
    _iframeElement.width = '${widget.height}';

    _iframeElement.src = 'https://www.youtube.com/embed/${widget.videoId}';
    _iframeElement.style.border = 'none';

    // ต้อง ignore ไม่งั้น compile ไม่ผ่าน
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iframeElement,
    );

    _iframeWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'iframeElement',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: _iframeWidget,
      width: widget.width,
      height: widget.height,
    );
  }
}
