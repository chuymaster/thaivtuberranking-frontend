import 'package:flutter_test/flutter_test.dart';
import 'package:http/src/client.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/pages/home/home_repository.dart';
import 'package:thaivtuberranking/pages/home/home_view_model.dart';
import 'package:thaivtuberranking/services/result.dart';

import 'home_repository_test.mocks.dart';

void main() {
  group('getChannelList', () {
    test(
        'viewState is updated to loading and success when getChannelList has completed',
        () async {
      final viewModel = HomeViewModel();
      viewModel.repository = MockHomeRepository(MockClient());
      expect(viewModel.viewState, isA<LoadingState>());

      List<Result> results = [];
      viewModel.addListener(() {
        results.add(viewModel.viewState);
      });

      await viewModel.getChannelList();

      expect(results, [isA<LoadingState>(), isA<SuccessState>()]);
      expect(viewModel.channelList.length, 1);
      expect(viewModel.channelIdList, ['id']);
    });
  });
}

class MockHomeRepository extends AbstractHomeRepository {
  MockHomeRepository(Client client) : super(client);

  @override
  Future<Result> getChannelList() async {
    List<ChannelInfo> channelList = [];
    channelList.add(ChannelInfo(
        channelId: "id",
        channelName: "name",
        totalSubscribers: 0,
        totalViews: 0,
        iconUrl: "https://",
        publishedAt: "",
        lastPublishedVideoAt: "",
        description: "description",
        isRebranded: false,
        updatedAt: 0));
    return Result.success(channelList);
  }
}
