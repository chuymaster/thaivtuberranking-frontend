import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/home/entity/app_language.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale; // Null on initialization

  LocaleProvider(this._locale);

  Locale? get locale => _locale;
  set locale(Locale? newLocale) {
    _locale = newLocale;
  }

  AppLanguage get appLanguage {
    if (locale?.languageCode == AppLanguage.Thai.languageCode) {
      return AppLanguage.Thai;
    } else if (locale?.languageCode == AppLanguage.Japanese.languageCode) {
      return AppLanguage.Japanese;
    } else {
      return AppLanguage.English;
    }
  }
  
  set appLanguage(AppLanguage newAppLanguage) {
    _locale = Locale(newAppLanguage.languageCode);
    notifyListeners();
  }
}