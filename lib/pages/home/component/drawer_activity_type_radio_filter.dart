import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import '../entity/activity_type.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';

class DrawerActivityTypeRadioFilter extends StatefulWidget {
  final ActivityType currentActivityType;
  final Function(ActivityType) onChanged;

  const DrawerActivityTypeRadioFilter(
      {super.key, required this.currentActivityType, required this.onChanged});

  @override
  DrawerActivityTypeRadioFilterState createState() =>
      DrawerActivityTypeRadioFilterState();
}

class DrawerActivityTypeRadioFilterState
    extends State<DrawerActivityTypeRadioFilter> {
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
            text: L10n.strings.navigation_menu_text_active_type,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                  value: ActivityType.ActiveOnly,
                  groupValue: widget.currentActivityType,
                  onChanged: (ActivityType? value) {
                    if (value != null) {
                      setState(() {
                        widget.onChanged(value);
                      });
                    }
                  },
                ),
                ThaiText(text: ActivityType.ActiveOnly.toString()),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: ActivityType.All,
                  groupValue: widget.currentActivityType,
                  onChanged: (ActivityType? value) {
                    if (value != null) {
                      setState(() {
                        widget.onChanged(value);
                      });
                    }
                  },
                ),
                ThaiText(text: ActivityType.All.toString()),
              ],
            )
          ],
        ),
        Container(
          padding: EdgeInsets.fromLTRB(16, 8, 8, 8),
          child: ThaiText(
              text: L10n.strings.navigation_menu_text_active_type_explanation,
              fontSize: 12,
              color: Colors.black54),
        )
      ],
    );
  }
}
