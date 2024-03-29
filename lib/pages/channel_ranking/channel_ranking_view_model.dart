import 'dart:math';

import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/pages/home/entity/filter.dart';

class ChannelRankingViewModel {
  final List<ChannelInfo> channelList;
  final int _itemPerPage = 20;

  final List<Filter> filters = Filter.values;

  int _currentPageNumber = 1;
  int get currentPageNumber {
    return _currentPageNumber;
  }

  int get maxPageNumber {
    return (channelList.length / _itemPerPage).ceil();
  }

  int get startIndex {
    return (_currentPageNumber - 1) * _itemPerPage;
  }

  ChannelRankingViewModel(this.channelList);

  void setPageNumber(int page) {
    _currentPageNumber = page;
  }

  List<ChannelInfo> getDisplayChannelList(int filterIndex) {
    List<ChannelInfo> displayChannelList = channelList;
    Filter filter = filters[filterIndex];

    switch (filter) {
      case Filter.Subscriber:
        // sort desc (b > a)
        displayChannelList
            .sort((a, b) => b.subscribers.compareTo(a.subscribers));
        break;
      case Filter.View:
        displayChannelList.sort((a, b) => b.views.compareTo(a.views));
        break;
      case Filter.PublishedDate:
        displayChannelList.sort((a, b) => b.publishedAtStringForComparison
            .compareTo(a.publishedAtStringForComparison));
        break;
    }

    int endIndex = min(channelList.length, startIndex + _itemPerPage);
    return displayChannelList.getRange(startIndex, endIndex).toList();
  }
}
