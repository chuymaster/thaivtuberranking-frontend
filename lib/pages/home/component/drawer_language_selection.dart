import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/pages/home/entity/app_language.dart';
import 'package:thaivtuberranking/providers/locale_provider.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';

class DrawerLanguageSelection extends StatefulWidget {
  final LocaleProvider localeProvider;

  const DrawerLanguageSelection({super.key, required this.localeProvider});

  @override
  DrawerLanguageSelectionState createState() =>
      DrawerLanguageSelectionState();
}

class DrawerLanguageSelectionState
    extends State<DrawerLanguageSelection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(4)
        ),
        Container(
          padding: EdgeInsets.fromLTRB(16, 8, 4, 8),
          child: ThaiText(
            text: L10n.strings.navigation_menu_text_language,
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Radio(
                  value: AppLanguage.Thai,
                  groupValue: widget.localeProvider.appLanguage,
                  onChanged: (AppLanguage? value) {
                    if (value != null) {
                      widget.localeProvider.appLanguage = value;
                    }
                  },
                ),
                ThaiText(text: AppLanguage.Thai.toString()),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: AppLanguage.English,
                  groupValue: widget.localeProvider.appLanguage,
                  onChanged: (AppLanguage? value) {
                    if (value != null) {
                      widget.localeProvider.appLanguage = value;
                    }
                  },
                ),
                ThaiText(text: AppLanguage.English.toString()),
              ],
            ),
            Row(
              children: [
                Radio(
                  value: AppLanguage.Japanese,
                  groupValue: widget.localeProvider.appLanguage,
                  onChanged: (AppLanguage? value) {
                    if (value != null) {
                      widget.localeProvider.appLanguage = value;
                    }
                  },
                ),
                ThaiText(text: AppLanguage.Japanese.toString()),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(4)
        ),
      ],
    );
  }
}
