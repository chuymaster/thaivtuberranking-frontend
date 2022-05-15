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
}
