
enum AppLanguage {
  Thai,
  English,
  Japanese;

  String get languageCode {
    switch (this) {
      case Thai:
        return "th";
      case English:
        return "en";
      case Japanese:
        return "ja";
    }
  }

  @override
  String toString() {
    switch (this) {
      case Thai:
        return "ไทย";
      case English:
        return "English";
      case Japanese:
        return "日本語";
    }
  }

}