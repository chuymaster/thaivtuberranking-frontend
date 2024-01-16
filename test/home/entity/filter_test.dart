import 'package:flutter_test/flutter_test.dart';
import 'package:thaivtuberranking/pages/home/entity/filter.dart';
import 'package:thaivtuberranking/l10n/L10n.dart';

void main() {
  group('Filter enum tests', () {
    testWidgets('toString', (tester) async {
      await tester.pumpWidget(L10n.makeMockWidget(() {}));
      await tester.pumpAndSettle();
      expect(Filter.Subscriber.toString(), L10n.strings.channel_list_tab_subscribers);
      expect(Filter.View.toString(), L10n.strings.channel_list_tab_views);
      expect(Filter.PublishedDate.toString(), L10n.strings.channel_list_tab_published);
      expect(() => Filter.values[3], throwsA(isA<RangeError>()));
    });
  });
}
