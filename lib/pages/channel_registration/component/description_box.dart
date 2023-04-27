import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/strings.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

class DescriptionBox extends StatelessWidget {
  static TextStyle _defaultStyle = TextStyle(color: Colors.black);
  static TextStyle _titleStyle =
      TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16);
  static TextStyle _linkStyle = TextStyle(color: Colors.blue);

  final firstTextSpan = TextSpan(style: _defaultStyle, children: [
    TextSpan(
        text:
            "\n\nแชนแนล ID คือรหัสตามหลัง URL ของแชนแนล เช่น https://www.youtube.com/channel/"),
    TextSpan(
        text: "UCqhhWjpw23dWhJ5rRwCCrMA",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[800]))
  ]);
  final secondTextSpan = TextSpan(style: _defaultStyle, children: [
    TextSpan(
        text:
            "สำหรับช่องที่ URL ไม่ได้ขึ้นต้นด้วย UC สามารถตรวจสอบ ID ของแชนแนลได้"),
    TextSpan(
        text: "ที่เว็บไซต์นี้",
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
          Text("แชนแนล ID คืออะไร?", style: _titleStyle),
          SelectableText.rich(
            firstTextSpan,
            style: _defaultStyle,
          ),
          Text.rich(
            secondTextSpan,
            style: _defaultStyle,
          ),
          _columnSpace,
          Text(
            "ประเภทของแชนแนลที่อนุญาต",
            style: _titleStyle,
          ),
          _columnSpace,
          Text("1. ${Strings.fullVTuber}"),
          _columnSpace,
          Text(
              "- แชนแนลที่นำแสดงโดยโมเดล VTuber (โมเดล Live2D หรือ 3D) เป็นหลักตั้งแต่คอนเทนต์แรก และมีโมเดล VTuber เป็นตัวเอกของคอนเทนต์"),
          _columnSpace,
          Text("2. ${Strings.fullVTuber}"),
          _columnSpace,
          Text(
              "- แชนแนลที่นำโมเดล VTuber มาแสดงเป็นหลักหลังจากเปิดแชนแนลและอัพโหลดคอนเทนต์อื่นไปแล้ว จะปรากฏในการรายชื่อหมวด ${Strings.allVTuber} เท่านั้น"),
          _columnSpace,
          Text(
              "ทั้งสองกรณีต้องเป็นแชนแนลที่ทำโดยคนไทย มุ่งเน้นกลุ่มผู้ชมคนไทยเป็นหลัก และมีคอนเทนต์อัพโหลดแล้ว ทีมงานจึงจะสามารถพิจารณาได้"),
          _columnSpace,
        ],
      ),
    );
  }

  Widget get _columnSpace {
    return SizedBox(height: 16.0);
  }
}
