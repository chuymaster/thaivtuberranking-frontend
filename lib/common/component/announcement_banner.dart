import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';

class AnnouncementBanner extends StatelessWidget {
  const AnnouncementBanner({super.key, required this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(color: Colors.orange[800]),
        child: MaterialButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.white,
                ),
                Align(
                    alignment: Alignment.center,
                    child: ThaiText(
                      text: L10n.strings.announcement_text_delete_channel,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ),
            onPressed: () {
              this.onPressed();
            }),
      ),
    );
  }
}
