import 'package:thaivtuberranking/common/strings.dart';

/// ประเภทที่มาของแชนแนล - ออริจินัล/รีแบรนด์
enum OriginType {
  OriginalOnly,
  All;

  @override
  String toString() {
    switch (this) {
      case OriginalOnly:
        return Strings.fullVtuber;
      case All:
        return Strings.allVtuber;
      default:
        throw Exception("Unknown enum type $this");
    }
  }
}
