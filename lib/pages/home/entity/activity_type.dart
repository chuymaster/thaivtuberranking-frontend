import 'package:flutter/material.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';

enum ActivityType {
  ActiveOnly,
  All;

  @override
  String toString() {
    switch (this) {
      case ActiveOnly:
        return L10n.strings.navigation_menu_radio_box_active_only;
      case All:
        return L10n.strings.navigation_menu_radio_box_active_and_inactive;
      default:
        throw Exception("Unknown enum type $this");
    }
  }

  String get tooltip {
    switch (this) {
      case ActiveOnly:
        return L10n.strings.home_tooltip_display_channel(this.toString());
      case All:
        return L10n.strings.home_tooltip_display_channel(this.toString());
      default:
        throw Exception("Unknown enum type $this");
    }
  }

  Icon get icon {
    switch (this) {
      case ActiveOnly:
        return const Icon(Icons.visibility_off_rounded);
      case All:
        return const Icon(Icons.visibility_rounded);
      default:
        throw Exception("Unknown enum type $this");
    }
  }
}
