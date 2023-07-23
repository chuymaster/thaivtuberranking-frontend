import 'package:flutter_test/flutter_test.dart';
import 'package:thaivtuberranking/pages/home/entity/filter.dart';

void main() {
  group('Filter enum tests', () {
    test('toString', () {
      expect(Filter.Subscriber.toString(), "ผู้ติดตาม");
      expect(Filter.View.toString(), "Views");
      expect(Filter.PublishedDate.toString(), "วันเปิดแชนแนล");
      expect(() => Filter.values[3], throwsA(isA<RangeError>()));
    });
  });
}
