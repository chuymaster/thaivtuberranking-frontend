import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';
import '../entity/origin_type.dart';

class DrawerOriginTypeRadioFilter extends StatefulWidget {
  final OriginType currentOriginType;
  final Function(OriginType) onChanged;

  const DrawerOriginTypeRadioFilter(
      {super.key, required this.currentOriginType, required this.onChanged});

  @override
  _DrawerOriginTypeRadioFilterState createState() =>
      _DrawerOriginTypeRadioFilterState();
}

class _DrawerOriginTypeRadioFilterState
    extends State<DrawerOriginTypeRadioFilter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(16, 8, 4, 8),
          child: ThaiText(
            text: "ประเภทแชนแนล",
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                  value: OriginType.OriginalOnly,
                  groupValue: widget.currentOriginType,
                  onChanged: (OriginType? value) {
                    if (value != null) {
                      setState(() {
                        widget.onChanged(value);
                      });
                    }
                  },
                ),
                ThaiText(text: L10n.strings.fullVTuber),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: OriginType.All,
                  groupValue: widget.currentOriginType,
                  onChanged: (OriginType? value) {
                    if (value != null) {
                      setState(() {
                        widget.onChanged(value);
                      });
                    }
                  },
                ),
                ThaiText(text: L10n.strings.allVTuber),
              ],
            )
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: ThaiText(
              text: "'" +
                  L10n.strings.fullVTuber +
                  "' หมายถึงแชนแนลที่เดบิวต์ตัวเองเป็น VTuber และทำคอนเทนต์ VTuber ตั้งแต่ต้น ไม่ได้เปลี่ยนมาจากคอนเทนต์อื่น",
              fontSize: 12,
              color: Colors.black54),
        )
      ],
    );
  }
}
