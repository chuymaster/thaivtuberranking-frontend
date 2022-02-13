import 'dart:math';

import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/pages/home/entity/filter_item.dart';

class ChannelRankingViewModel {
  final List<ChannelInfo> channelList;
  final int _itemPerPage = 20;

  final List<FilterItem> filterItems = <FilterItem>[
    FilterItem(Filter.Subscriber),
    FilterItem(Filter.View),
    FilterItem(Filter.PublishedDate),
    FilterItem(Filter.UpdatedDate)
  ];

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
    Filter filter = filterItems[filterIndex].filter;

    switch (filter) {
      case Filter.Subscriber:
        // sort desc (b > a)
        displayChannelList
            .sort((a, b) => b.totalSubscribers.compareTo(a.totalSubscribers));
        break;
      case Filter.View:
        displayChannelList.sort((a, b) => b.totalViews.compareTo(a.totalViews));
        break;
      case Filter.PublishedDate:
        displayChannelList.sort((a, b) => b
            .getPublishedAtForComparison()
            .compareTo(a.getPublishedAtForComparison()));
        break;
      case Filter.UpdatedDate:
        displayChannelList.sort((a, b) => b
            .getLastPublishedVideoAtString()
            .compareTo(a.getLastPublishedVideoAtString()));
        break;
    }

    int endIndex = min(channelList.length, startIndex + _itemPerPage);
    return displayChannelList.getRange(startIndex, endIndex).toList();
  }
}
