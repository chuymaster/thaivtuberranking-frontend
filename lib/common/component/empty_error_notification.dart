import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';

class EmptyErrorNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ThaiText(
              text: L10n.strings.error_empty_channel_description,
              color: Colors.black54,
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ThaiText(
                  text: L10n.strings.error_empty_channel_contact,
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
