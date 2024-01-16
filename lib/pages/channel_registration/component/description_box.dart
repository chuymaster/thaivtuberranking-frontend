import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

class DescriptionBox extends StatelessWidget {
  static TextStyle _defaultStyle = TextStyle(color: Colors.black);
  static TextStyle _titleStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);
  static TextStyle _linkStyle = TextStyle(color: Colors.blue);

  final firstTextSpan = TextSpan(style: _defaultStyle, children: [
    TextSpan(
        text: L10n.strings.channel_registration_text_id_explanation_1),
    TextSpan(
        text: "UCqhhWjpw23dWhJ5rRwCCrMA",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[800]))
  ]);
  final secondTextSpan = TextSpan(style: _defaultStyle, children: [
    TextSpan(
        text: L10n.strings.channel_registration_text_id_explanation_2,
        style: _linkStyle,
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            UrlLauncher.launchURL(
                "https://commentpicker.com/youtube-channel-id.php");
          }),
  ]);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Align children to the left
        children: [
          Text(L10n.strings.channel_registration_title_id_explanation, style: _titleStyle),
          SelectableText.rich(
            firstTextSpan,
            style: _defaultStyle,
          ),
          Text.rich(
            secondTextSpan,
            style: _defaultStyle,
          ),
          _columnSpace,
          Text(L10n.strings.channel_registration_title_type_explanation,
            style: _titleStyle,
          ),
          _columnSpace,
          Text("1. ${L10n.strings.common_type_full_vtuber}"),
          _columnSpace,
          Text(L10n.strings.channel_registration_text_full_vtuber_explanation),
          _columnSpace,
          Text("2. ${L10n.strings.common_type_all_vtuber}"),
          _columnSpace,
          Text(L10n.strings.channel_registration_text_all_vtuber_explanation),
          _columnSpace,
          Text(L10n.strings.channel_registration_text_type_explanation),
          _columnSpace,
        ],
      ),
    );
  }

  Widget get _columnSpace {
    return SizedBox(height: 16.0);
  }
}
