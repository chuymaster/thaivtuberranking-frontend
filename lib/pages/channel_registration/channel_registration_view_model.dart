import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/error_dialog.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/services/result.dart';

import 'channel_registration_complete_page.dart';
import 'channel_registration_repository.dart';

class ChannelRegistrationViewModel extends ChangeNotifier {
  final _repository = ChannelRegistrationRepository();
  final List<String> _channelIdList;

  // Form key for input https://flutter.dev/docs/cookbook/forms/validation
  final formKey = GlobalKey<FormState>();
  final textEditingController = TextEditingController();
  final int channelIdLength = 24; // แชนแนล YouTube ยาว 24 ตัวอักษร
  OriginType currentOriginType = OriginType.OriginalOnly;
  bool _isInputValidated = false;

  Result viewState = Result.idle();

  ChannelRegistrationViewModel(this._channelIdList);

  String get inputChannelId {
    return textEditingController.text;
  }

  String get inputChannelUrl {
    return "https://youtube.com/channel/" + inputChannelId;
  }

  bool get isRegisterButtonEnabled {
    return (viewState is IdleState || viewState is ErrorState) &&
        _isInputValidated;
  }

  bool get shouldShowLoadingIndicator {
    return (viewState is LoadingState || viewState is SuccessState);
  }

  void registerChannel() async {
    viewState = Result.loading();
    notifyListeners();
    viewState = await _repository.sendAddChannelRequest(
        inputChannelId, currentOriginType.parameterValue);
    notifyListeners();
  }

  void validateInputText() {
    final currentState = formKey.currentState;
    if (currentState != null) {
      _isInputValidated = currentState.validate();
      notifyListeners();
    }
  }

  String? validateFormValue(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'โปรดกรอกแชนแนล ID';
      } else if (!value.startsWith('UC')) {
        return 'แชนแนล ID ต้องขึ้นต้นด้วย UC';
      } else if (value.length != channelIdLength) {
        return 'แชนแนล ID ต้องมีความยาว $channelIdLength ตัวอักษร';
      } else if (_channelIdList.contains(value)) {
        return ChannelRegistrationErrorMessage.alreadyAdded;
      }
    }
    return null;
  }

  void onOriginTypeChanged(OriginType? value) {
    if (value != null) {
      currentOriginType = value;
      notifyListeners();
    }
  }

  void navigateToCompletePage(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
        context, ChannelRegistrationCompletePage.route, (route) => false);
  }

  void showErrorDialog(BuildContext context) {
    String errorMessage = (viewState as ErrorState).msg;
    ErrorDialog.showErrorDialog(
        ChannelRegistrationErrorMessage.failedToSubmit, errorMessage, context);
    viewState = Result.idle();
    notifyListeners();
  }
}

class ChannelRegistrationErrorMessage {
  static const String alreadyAdded = "แชนแนลนี้อยู่ในฐานข้อมูลจัดอันดับแล้ว";
  static const String failedToSubmit =
      "เกิดปัญหาในการส่งข้อมูล กรุณาลองใหม่ในภายหลัง";
}
