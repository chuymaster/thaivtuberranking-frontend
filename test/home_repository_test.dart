import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:thaivtuberranking/pages/home/home_repository.dart';
import 'package:thaivtuberranking/services/result.dart';

import 'home_repository_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('getChannelList', () {
    test('returns channel list if the http call completes successfully',
        () async {
      // GIVEN
      final client = MockClient();
      final repository = HomeRepository(client);

      Uri channelListJson = Uri.parse(
          "https://storage.googleapis.com/thaivtuberranking.appspot.com/channel_data/list.json");

      when(client.get(channelListJson))
          .thenAnswer((_) async => http.Response('''
{
   "result":[
      [
         {
            "channel_id":"UCAnKhwx493i5myddnJFF_gg",
            "title":"test",
            "description":"test",
            "thumbnail_icon_url":"https://yt3.ggpht.com/_omfQkzNb_u2x8ldqJ9IwoZlCCYEQQm-cfkfjfuqkSgKZIvmwF2i4G5CdN-zUQtuM8cfBqEo3w=s240-c-k-c0x00ffffff-no-rj",
            "subscribers":23800,
            "views":829124,
            "comments":null,
            "videos":156,
            "uploads":"UUAnKhwx493i5myddnJFF_gg",
            "published_at":"2020-11-11T12:58:49.610362Z",
            "last_published_video_at":"2021-12-31T13:08:37Z",
            "updated_at":1641006011156,
            "is_rebranded":false
         }
      ]
   ]
}
            ''', 200));

      final result = await repository.getChannelList();
      expect(result, isA<SuccessState<dynamic>>());
    });
    test('returns error http call completes with error', () async {
      // TODO
    });
  });
}
