import 'package:flutter/material.dart';
import 'package:thaivtuberranking/pages/add/add_repository.dart';
import 'package:thaivtuberranking/services/result.dart';

class ChannelRegistrationViewModel extends ChangeNotifier {
  final _repository = AddRepository();

  Result viewState = Result.idle();

  void registerChannel(String channelId, String type) async {
    viewState = Result.loading();
    notifyListeners();
    viewState = await _repository.sendAddChannelRequest(channelId, type);
    notifyListeners();
  }
}
