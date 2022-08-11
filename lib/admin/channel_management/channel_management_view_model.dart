import 'package:flutter/material.dart';

import '../../../services/result.dart';
import 'channel_management_repository.dart';
import 'entity/channel.dart';

class ChannelManagementViewModel extends ChangeNotifier {
  final ChannelManagementRepository _repository = ChannelManagementRepository();

  Result viewGetState = Result.idle();
  Result viewPostState = Result.idle();

  void getChannelList() async {
    viewGetState = Result.loading();
    notifyListeners();
    viewGetState = await _repository.getChannelList();
    notifyListeners();
  }

  void resetViewStates() {
    viewGetState = Result.idle();
    viewPostState = Result.idle();
  }

  void updateSelectedChannelList() async {
    viewPostState = Result.loading();
    notifyListeners();

    Result? errorState;
    await Future.forEach(_selectedChannelList, (Channel element) async {
      final postChannelRequestState = await _repository.postChannel(element);
      final postChannelState = await _repository.postChannel(element);

      if (postChannelRequestState is ErrorState) {
        errorState = postChannelRequestState;
      }
      if (postChannelState is ErrorState) {
        errorState = postChannelState;
      }
    });

    if (errorState == null) {
      viewPostState = Result.success(null);
      getChannelList();
    } else {
      viewPostState = errorState!;
      notifyListeners();
    }
  }

  void deleteChannelList() async {
    viewPostState = Result.loading();
    notifyListeners();

    Result? errorState;
    await Future.forEach(_selectedChannelList, (Channel element) async {
      final deleteChannelState =
          await _repository.deleteChannel(element.channelId);
      if (deleteChannelState is ErrorState) {
        errorState = deleteChannelState;
      }
    });

    if (errorState == null) {
      viewPostState = Result.success(null);
      getChannelList();
    } else {
      viewPostState = errorState!;
      notifyListeners();
    }
  }

  void deleteObsoleteChannel() async {
    viewPostState = Result.loading();
    notifyListeners();

    Result? errorState;
    final deleteChannelState = await _repository.deleteObsoleteChannels();
    if (deleteChannelState is ErrorState) {
      errorState = deleteChannelState;
    }
    if (errorState == null) {
      viewPostState = Result.success(null);
      getChannelList();
    } else {
      viewPostState = errorState;
      notifyListeners();
    }
  }

  void setSelectionAsOriginal() {
    for (var element in _selectedChannelList) {
      element.type = ChannelType.original;
    }
    notifyListeners();
  }

  void setSelectionAsHalf() {
    for (var element in _selectedChannelList) {
      element.type = ChannelType.half;
    }
    notifyListeners();
  }

  List<Channel> get _channelList {
    if (viewGetState is SuccessState) {
      return (viewGetState as SuccessState).value;
    } else {
      return [];
    }
  }

  bool get hasSelection {
    return _channelList.where((element) => element.isSelected).isNotEmpty;
  }

  List<Channel> get _selectedChannelList {
    return _channelList.where((element) => element.isSelected).toList();
  }

  int get selectedChannelListCount {
    return _channelList.where((element) => element.isSelected).length;
  }
}
