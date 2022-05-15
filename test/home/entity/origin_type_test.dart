import 'package:flutter_test/flutter_test.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';

void main() {
  group('OriginType enum tests', () {
    test('toString', () {
      expect(OriginType.OriginalOnly.toString(), "VTuber เต็มตัว");
      expect(OriginType.All.toString(), "VTuber ทั้งหมด");
    });
  });
}
