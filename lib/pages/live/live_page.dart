import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';

class LivePage extends StatefulWidget {
  const LivePage({Key? key}) : super(key: key);

  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ThaiText(text: "ไม่มีวิดีโอ"),
          ThaiText(text: "ไม่มีวิดีโอ")
        ],
      ),
    );
  }
}
