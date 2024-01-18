import 'package:flutter_test/flutter_test.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';

void main() {
  group('OriginType enum tests', () {
    testWidgets('toString', (tester) async {
      await tester.pumpWidget(L10n.makeMockWidget(() {}));
      await tester.pumpAndSettle();

      expect(OriginType.OriginalOnly.toString(), L10n.strings.common_type_full_vtuber);
      expect(OriginType.All.toString(), L10n.strings.common_type_all_vtuber);
    });
    test('parameterValue', () {
      expect(OriginType.OriginalOnly.parameterValue, "1");
      expect(OriginType.All.parameterValue, "2");
    });
  });
}
