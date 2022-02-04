import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/strings.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

class DescriptionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle defaultStyle = TextStyle(color: Colors.black);
    TextStyle linkStyle = TextStyle(color: Colors.blue);

    return Center(
      child: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
                padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                child: SelectableText.rich(
                  TextSpan(style: defaultStyle, children: [
                    TextSpan(
                      text: "แชนแนล ID คืออะไร?",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    TextSpan(
                        text:
                            "\n\nแชนแนล ID คือรหัสตามหลัง URL ของแชนแนล เช่น https://www.youtube.com/channel/"),
                    TextSpan(
                        text: "UCqhhWjpw23dWhJ5rRwCCrMA",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[800])),
                    TextSpan(
                        text:
                            "\n\nสำหรับช่องที่ URL ไม่ได้ขึ้นต้นด้วย UC สามารถตรวจสอบ ID ของแชนแนลได้"),
                    TextSpan(
                        text: "ที่เว็บไซต์นี้",
                        style: linkStyle,
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            UrlLauncher.launchURL(
                                "https://commentpicker.com/youtube-channel-id.php");
                          }),
                    TextSpan(
                      text: "\n\nประเภทของแชนแนลที่อนุญาต",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    TextSpan(
                      text: "\n\n1. " +
                          Strings.fullVtuber +
                          "\n- แชนแนลที่นำแสดงโดยโมเดล VTuber (โมเดล Live2D หรือ 3D) เป็นหลักตั้งแต่คอนเทนต์แรก และมีโมเดล VTuber เป็นตัวเอกของคอนเทนต์",
                    ),
                    TextSpan(
                        text: "\n\n2. " +
                            Strings.halfVtuber +
                            "\n- แชนแนลที่นำโมเดล VTuber มาแสดงเป็นหลักหลังจากเปิดแชนแนลและอัพโหลดคอนเทนต์อื่นไปแล้ว จะปรากฏในการจัดอันดับหมวด " +
                            Strings.allVtuber +
                            "เท่านั้น"),
                    TextSpan(
                        text:
                            "\n\nทั้งสองกรณีต้องเป็นแชนแนลที่ทำโดยคนไทย มุ่งเน้นกลุ่มผู้ชมคนไทยเป็นหลัก และมีคอนเทนต์อัพโหลดแล้ว ทีมงานจึงจะสามารถพิจารณาได้"),
                    TextSpan(
                        style: TextStyle(color: Colors.red[400]),
                        text:
                            "\n\n**ไม่รับแชนแนลแคสเกมที่ไม่ได้แสดงด้วยโมเดล VTuber ของตัวเองเป็นหลักหรือแชนแนลที่ทำคอนเทนต์เกี่ยวกับ VTuber โดยที่ตัวเองไม่ใช่ VTuber**"),
                  ]),
                )),
          ],
        ),
      ),
    );
  }
}
