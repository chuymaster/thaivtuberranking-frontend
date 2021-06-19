import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

class EmptyErrorNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ThaiText(
              text: "เกิดข้อผิดพลาดจึงไม่สามารถแสดงข้อมูลได้",
              color: Colors.black54,
            ),
            ThaiText(
              text:
                  "กรุณาตรวจสอบการเชื่อมต่ออินเทอร์เน็ต\nหรือแจ้งผู้พัฒนาเพื่อทำการแก้ไข",
              color: Colors.black54,
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ThaiText(
                  text: "ติดต่อ @chuymaster",
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                UrlLauncher.launchURL("https://twitter.com/chuymaster");
              },
            )
          ],
        ));
  }
}
