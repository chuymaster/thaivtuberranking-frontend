import 'package:flutter/material.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';

/// ประเภทที่มาของแชนแนล - ออริจินัล/รีแบรนด์
enum OriginType {
  OriginalOnly,
  All;

  @override
  String toString() {
    switch (this) {
      case OriginalOnly:
        return L10n.strings.common_type_full_vtuber;
      case All:
        return L10n.strings.common_type_all_vtuber;
      default:
        throw Exception("Unknown enum type $this");
    }
  }

  String get parameterValue {
    switch (this) {
      case OriginalOnly:
        return "1";
      case All:
        return "2";
      default:
        throw Exception("Unknown enum type $this");
    }
  }

  String get tooltip {
    switch (this) {
      case OriginalOnly:
        return L10n.strings.home_tooltip_display_only_channel(L10n.strings.common_type_full_vtuber);
      case All:
        return L10n.strings.home_tooltip_display_channel(L10n.strings.common_type_all_vtuber);
      default:
        throw Exception("Unknown enum type $this");
    }
  }

  Icon get icon {
    switch (this) {
      case OriginalOnly:
        return const Icon(Icons.group);
      case All:
        return const Icon(Icons.groups);
      default:
        throw Exception("Unknown enum type $this");
    }
  }
}
