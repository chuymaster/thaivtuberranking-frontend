import 'package:flutter_test/flutter_test.dart';
import 'package:thaivtuberranking/pages/home/entity/activity_type.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/pages/home/home_view_model.dart';

void main() {
  group('Initialization', () {
    test('Initial values are as expected', () async {
      final viewModel = HomeViewModel();
      expect(viewModel.tabIndex, 0);
      expect(viewModel.isBottomNavigationBarHidden, false);
      expect(viewModel.originType, OriginType.OriginalOnly);
    });
  });
  group('getFilteredChannelList', () {
    test('Get only original channel list', () {
      final viewModel = HomeViewModel();
      viewModel.activityType = ActivityType.All;
      final channelList = [
        ChannelInfo(
            channelId: "1",
            channelName: "",
            subscribers: 0,
            views: 0,
            iconUrl: "",
            publishedAt: "",
            lastPublishedVideoAt: "",
            description: "",
            isRebranded: false,
            updatedAt: 0),
        ChannelInfo(
            channelId: "2",
            channelName: "",
            subscribers: 0,
            views: 0,
            iconUrl: "",
            publishedAt: "",
            lastPublishedVideoAt: "",
            description: "",
            isRebranded: true,
            updatedAt: 0)
      ];

      expect(
          viewModel
              .getFilteredChannelList(channelList)
              .map((e) => e.channelId)
              .toList(),
          ["1"]);
    });
    test('Get all channel list', () {
      final viewModel = HomeViewModel();
      viewModel.activityType = ActivityType.All;
      final channelList = [
        ChannelInfo(
            channelId: "1",
            channelName: "",
            subscribers: 0,
            views: 0,
            iconUrl: "",
            publishedAt: "",
            lastPublishedVideoAt: "",
            description: "",
            isRebranded: false,
            updatedAt: 0),
        ChannelInfo(
            channelId: "2",
            channelName: "",
            subscribers: 0,
            views: 0,
            iconUrl: "",
            publishedAt: "",
            lastPublishedVideoAt: "",
            description: "",
            isRebranded: true,
            updatedAt: 0)
      ];

      viewModel.originType = OriginType.All;
      expect(
          viewModel
              .getFilteredChannelList(channelList)
              .map((e) => e.channelId)
              .toList(),
          ["1", "2"]);
    });
  });

  group('tabIndex setter', () {
    test('Tab index is changed', () {
      int listenerCallCount = 0;
      final viewModel = HomeViewModel()
        ..addListener(() {
          listenerCallCount += 1;
        });
      viewModel.tabIndex = 1;
      expect(viewModel.tabIndex, 1);
      expect(listenerCallCount, 1);
    });
  });
  group('originType setter', () {
    test('OriginType is changed', () {
      int listenerCallCount = 0;
      final viewModel = HomeViewModel()
        ..addListener(() {
          listenerCallCount += 1;
        });
      viewModel.originType = OriginType.All;
      expect(viewModel.originType, OriginType.All);
      expect(listenerCallCount, 1);
    });
  });
  group('isBottomNavigationBarHidden setter', () {
    test('listener is notified', () {
      int listenerCallCount = 0;
      final viewModel = HomeViewModel()
        ..addListener(() {
          listenerCallCount += 1;
        });
      viewModel.isBottomNavigationBarHidden = true;
      expect(viewModel.isBottomNavigationBarHidden, true);
      viewModel.isBottomNavigationBarHidden = false;
      expect(viewModel.isBottomNavigationBarHidden, false);
      expect(listenerCallCount, 2);
    });
    test('listener is notified only once if value is not changed', () {
      int listenerCallCount = 0;
      final viewModel = HomeViewModel()
        ..addListener(() {
          listenerCallCount += 1;
        });
      viewModel.isBottomNavigationBarHidden = true;
      viewModel.isBottomNavigationBarHidden = true;
      expect(viewModel.isBottomNavigationBarHidden, true);
      expect(listenerCallCount, 1);
    });
  });
}
