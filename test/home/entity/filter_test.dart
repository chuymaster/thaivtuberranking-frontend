import 'package:flutter_test/flutter_test.dart';
import 'package:thaivtuberranking/pages/home/entity/filter.dart';

void main() {
  group('Filter enum tests', () {
    test('toString', () {
      expect(Filter.Subscriber.toString(), "เรียงตามจำนวนผู้ติดตาม");
      expect(Filter.View.toString(), "เรียงตามจำนวนการดู");
      expect(Filter.PublishedDate.toString(), "เรียงตามวันเปิดแชนแนลล่าสุด");
      expect(() => Filter.values[3], throwsA(isA<RangeError>()));
    });
  });
}
