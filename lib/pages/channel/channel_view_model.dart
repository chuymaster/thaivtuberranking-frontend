import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/channel/channel_repository.dart';
import 'package:thaivtuberranking/pages/channel/entity/channel_chart_data.dart';
import 'package:thaivtuberranking/pages/home/entity/channel_info.dart';
import 'package:thaivtuberranking/services/result.dart';

class ChannelViewModel extends ChangeNotifier {
  final _repository = ChannelRepository();

  Result viewState = Result.loading();
  Result chartDataState = Result.loading();

  void getChannelInfo(String channelId) async {
    viewState = Result.loading();
    notifyListeners();
    viewState = await _repository.getChannelInfo(channelId);
    chartDataState = await _repository.getChannelChartData(channelId);
    notifyListeners();
  }

  ChannelInfo? get channelInfo {
    if (viewState is SuccessState) {
      return (viewState as SuccessState).value;
    } else {
      return null;
    }
  }

  ChannelChartData? get chartData {
    if (chartDataState is SuccessState) {
      return (chartDataState as SuccessState).value;
    } else {
      return null;
    }
  }

  String get title {
    return channelInfo?.channelName ?? "";
  }
}
