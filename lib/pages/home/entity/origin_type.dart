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
}
