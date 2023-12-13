import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class L10n {
  static final L10n _instance = L10n._internal();
  late AppLocalizations _localizations;

  factory L10n() {
    return _instance;
  }

  L10n._internal();

  static void setLocalizations(AppLocalizations localizations) {
    _instance._localizations = localizations;
  }
  
  static String get fullVTuber {
    return _instance._localizations.fullVTuber;
  }

  static String get allVTuber {
    return _instance._localizations.allVTuber;
  }

  static String get megumin {
    return _instance._localizations.megumin;
  }


  static String getString(String key) {
    switch (key) {
      case 'fullVTuber':
        return _instance._localizations.fullVTuber;
      case 'allVTuber':
        return _instance._localizations.allVTuber;
      default:
        throw Exception("Localization key not found: $key");
    }
  }
}
