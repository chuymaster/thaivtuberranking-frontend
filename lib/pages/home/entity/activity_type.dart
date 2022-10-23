import 'package:flutter/material.dart';

enum ActivityType {
  ActiveOnly,
  All;

  @override
  String toString() {
    switch (this) {
      case ActiveOnly:
        return "แชนแนลที่ยังอัปเดตอยู่";
      case All:
        return "แชนแนลที่อัปเดตและไม่อัปเดต";
      default:
        throw Exception("Unknown enum type $this");
    }
  }

  String get tooltip {
    switch (this) {
      case ActiveOnly:
        return "กำลังแสดง" + this.toString();
      case All:
        return "กำลังแสดง" + this.toString();
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
