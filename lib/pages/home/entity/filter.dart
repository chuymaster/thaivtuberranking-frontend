import 'package:thaivtuberranking/l10n/L10n.dart';

enum Filter {
  Subscriber,
  View,
  PublishedDate;

  @override
  String toString() {
    switch (this) {
      case Subscriber:
        return L10n.strings.channel_list_tab_subscribers;
      case View:
        return L10n.strings.channel_list_tab_views;
      case PublishedDate:
        return L10n.strings.channel_list_tab_published;
      default:
        throw Exception("Unknown enum type $this");
    }
  }
}
