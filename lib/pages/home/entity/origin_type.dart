import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/strings.dart';

/// ประเภทที่มาของแชนแนล - ออริจินัล/รีแบรนด์
enum OriginType {
  OriginalOnly,
  All;

  @override
  String toString() {
    switch (this) {
      case OriginalOnly:
        return Strings.fullVTuber;
      case All:
        return Strings.allVTuber;
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
        return "กำลังแสดงเฉพาะ " + Strings.fullVTuber;
      case All:
        return "กำลังแสดง " + Strings.allVTuber;
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
