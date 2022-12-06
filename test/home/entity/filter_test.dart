import 'package:flutter_test/flutter_test.dart';
import 'package:thaivtuberranking/pages/home/entity/filter.dart';

void main() {
  group('Filter enum tests', () {
    test('toString', () {
      expect(Filter.Subscriber.toString(), "จำนวนผู้ติดตาม");
      expect(Filter.View.toString(), "จำนวนการดู");
      expect(Filter.PublishedDate.toString(), "วันเปิดแชนแนล");
      expect(() => Filter.values[3], throwsA(isA<RangeError>()));
    });
  });
}
