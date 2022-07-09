// import 'package:backoffice/pages/channel_request/channel_request_repository.dart';
// import 'package:backoffice/pages/channel_request/entity/channel_request.dart';
// import 'package:backoffice/services/authentication.dart';
// import 'package:backoffice/services/result.dart';
import 'package:flutter/material.dart';

import '../../../services/result.dart';
import '../authentication.dart';
import 'channel_request_repository.dart';
import 'entity/channel_request.dart';

class ChannelRequestViewModel extends ChangeNotifier {
  final ChannelRequestRepository _repository = ChannelRequestRepository();

  Result viewGetState = Result.idle();
  Result viewPostState = Result.idle();

  void getChannelRequests() async {
    viewGetState = Result.loading();
    notifyListeners();
    viewGetState = await _repository.getChannelRequests();
    notifyListeners();
  }

  void resetViewStates() {
    viewGetState = Result.idle();
    viewPostState = Result.idle();
  }

  void approveChannelRequests() async {
    for (ChannelRequest element in _selectedChannelRequests) {
      element.status = ChannelRequestStatus.accepted;
    }

    viewPostState = Result.loading();
    notifyListeners();

    Result? errorState;
    await Future.forEach(_selectedChannelRequests,
        (ChannelRequest element) async {
      final postChannelRequestState =
          await _repository.postChannelRequest(element);
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
      getChannelRequests();
    } else {
      viewPostState = errorState!;
      notifyListeners();
    }
  }

  void pendChannelRequests() async {
    for (ChannelRequest element in _selectedChannelRequests) {
      element.status = ChannelRequestStatus.pending;
    }

    viewPostState = Result.loading();
    notifyListeners();

    Result? errorState;
    await Future.forEach(_selectedChannelRequests,
        (ChannelRequest element) async {
      final postChannelRequestState =
          await _repository.postChannelRequest(element);
      if (postChannelRequestState is ErrorState) {
        errorState = postChannelRequestState;
      }
    });

    if (errorState == null) {
      viewPostState = Result.success(null);
      getChannelRequests();
    } else {
      viewPostState = errorState!;
      notifyListeners();
    }
  }

  void rejectChannelRequests() async {
    for (ChannelRequest element in _selectedChannelRequests) {
      element.status = ChannelRequestStatus.rejected;
    }

    viewPostState = Result.loading();
    notifyListeners();

    Result? errorState;
    await Future.forEach(_selectedChannelRequests,
        (ChannelRequest element) async {
      final postChannelRequestState =
          await _repository.postChannelRequest(element);
      if (postChannelRequestState is ErrorState) {
        errorState = postChannelRequestState;
      }
    });

    if (errorState == null) {
      viewPostState = Result.success(null);
      getChannelRequests();
    } else {
      viewPostState = errorState!;
      notifyListeners();
    }
  }

  void deleteChannelRequests() async {
    viewPostState = Result.loading();
    notifyListeners();

    Result? errorState;
    await Future.forEach(_selectedChannelRequests,
        (ChannelRequest element) async {
      final deleteChannelState =
          await _repository.deleteChannelRequest(element.channelId);
      if (deleteChannelState is ErrorState) {
        errorState = deleteChannelState;
      }
    });

    if (errorState == null) {
      viewPostState = Result.success(null);
      getChannelRequests();
    } else {
      viewPostState = errorState!;
      notifyListeners();
    }
  }

  void setSelectionAsOriginal() {
    for (var element in _selectedChannelRequests) {
      element.type = ChannelType.original;
    }
    notifyListeners();
  }

  void setSelectionAsHalf() {
    for (var element in _selectedChannelRequests) {
      element.type = ChannelType.half;
    }
    notifyListeners();
  }

  List<ChannelRequest> get _channelRequests {
    if (viewGetState is SuccessState) {
      return (viewGetState as SuccessState).value;
    } else {
      return [];
    }
  }

  bool get hasSelection {
    return _channelRequests.where((element) => element.isSelected).isNotEmpty;
  }

  List<ChannelRequest> get _selectedChannelRequests {
    return _channelRequests.where((element) => element.isSelected).toList();
  }

  int get selectedChannelRequestsCount {
    return _channelRequests.where((element) => element.isSelected).length;
  }

  void logout() {
    Authentication.instance.logout();
  }
}
