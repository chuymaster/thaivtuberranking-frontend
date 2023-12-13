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

  static AppLocalizations get strings {
    return _instance._localizations;
  }
}
