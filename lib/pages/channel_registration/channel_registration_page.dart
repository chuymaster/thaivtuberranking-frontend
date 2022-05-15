import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaivtuberranking/common/component/center_circular_progress_indicator.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/common/screenFactor.dart';
import 'package:thaivtuberranking/common/strings.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

import '../../main.dart';
import 'channel_registration_view_model.dart';
import 'component/description_box.dart';

class ChannelRegistrationPage extends StatefulWidget {
  static const String route = '/register';

  final List<String> vTuberChannelIdList;

  const ChannelRegistrationPage({Key? key, required this.vTuberChannelIdList})
      : super(key: key);
  @override
  _ChannelRegistrationPageState createState() =>
      _ChannelRegistrationPageState();
}

class _ChannelRegistrationPageState extends State<ChannelRegistrationPage> {
  late final _viewModel =
      ChannelRegistrationViewModel(widget.vTuberChannelIdList);

  @override
  void initState() {
    super.initState();

    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.screenLoaded, {
      AnalyticsParameterName.screenName: AnalyticsPageName.channelRegistration
    });

    _viewModel.addListener(() {
      if (_viewModel.viewState is ErrorState) {
        _viewModel.showErrorDialog(context);
      } else if (_viewModel.viewState is SuccessState) {
        _viewModel.navigateToCompletePage(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var body = ChangeNotifierProvider(
      create: (context) => _viewModel,
      child: Consumer<ChannelRegistrationViewModel>(
        builder: (context, viewModel, _) {
          if (viewModel.shouldShowLoadingIndicator) {
            return CenterCircularProgressIndicator();
          } else {
            return ListView(
              children: [
                _channelRegistrationBox,
                Padding(
                  padding: EdgeInsets.all(8),
                ),
                DescriptionBox(),
                Padding(
                  padding: EdgeInsets.all(8),
                ),
              ],
            );
          }
        },
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: Text("แจ้งเพิ่มแชนแนล VTuber"),
        ),
        body: Center(
            child: SizedBox(
                width: getContentWidth(context),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: body,
                ))));
  }

  Widget get _typeRadio {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Radio(
              value: OriginType.OriginalOnly,
              groupValue: _viewModel.currentOriginType,
              onChanged: (OriginType? value) {
                _viewModel.onOriginTypeChanged(value);
              },
            ),
            ThaiText(
              text: OriginType.OriginalOnly.toString(),
              fontSize: 12,
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: OriginType.All,
              groupValue: _viewModel.currentOriginType,
              onChanged: (OriginType? value) {
                _viewModel.onOriginTypeChanged(value);
              },
            ),
            ThaiText(
              text: OriginType.All.toString(),
              fontSize: 12,
            ),
          ],
        )
      ],
    );
  }

  Widget get _channelRegistrationBox {
    List<Widget> columnWidgets = [];
    columnWidgets.add(Padding(
      child: ThaiText(text: "โปรดกรอกแชนแนล ID (ขึ้นต้นด้วย UC)"),
      padding: EdgeInsets.fromLTRB(0, 16, 8, 8),
    ));
    columnWidgets.add(Padding(
      child: _channelIdTextFormField,
      padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
    ));

    // โชว์ลิงค์ไปที่แชนแนลยูทูปให้เช็คก่อนส่ง
    if (_viewModel.isRegisterButtonEnabled) {
      TextStyle defaultStyle =
          TextStyle(color: Colors.black, fontWeight: FontWeight.bold);
      TextStyle defaultRedStyle =
          TextStyle(color: Colors.red, fontWeight: FontWeight.bold);
      TextStyle linkStyle = TextStyle(color: Colors.blue);

      // ประเภทช่อง
      columnWidgets.add(Text(
        "โปรดเลือกประเภทของช่องที่ต้องการแจ้ง",
        style: defaultStyle,
      ));
      columnWidgets.add(_typeRadio);
      columnWidgets.add(Padding(padding: EdgeInsets.all(8)));

      columnWidgets.add(RichText(
          text: TextSpan(style: defaultRedStyle, children: [
        TextSpan(text: 'โปรดตรวจสอบแชนแนลอีกครั้งก่อนส่งข้อมูล\n'),
        TextSpan(
            text: _viewModel.inputChannelUrl,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                MyApp.analytics.sendAnalyticsEvent(
                    AnalyticsEvent.tapChannelUrlBeforeRegister,
                    {'channel_id': _viewModel.inputChannelId});
                UrlLauncher.launchURL(_viewModel.inputChannelUrl);
              }),
      ])));

      columnWidgets.add(Padding(padding: EdgeInsets.all(8)));
    }

    columnWidgets
        .add(Align(alignment: Alignment.centerRight, child: _submitButton));
    return Form(
        key: _viewModel.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: columnWidgets,
        ));
  }

  Widget get _channelIdTextFormField {
    return TextFormField(
      maxLength: _viewModel.channelIdLength,
      decoration: InputDecoration(hintText: "UCqhhWjpw23dWhJ5rRwCCrMA"),
      onChanged: (text) => {_viewModel.validateInputText()},
      validator: (value) => _viewModel.validateFormValue(value),
      controller: _viewModel.textEditingController,
    );
  }

  Widget get _submitButton {
    return ElevatedButton(
        child: ThaiText(
          text: "ส่งข้อมูล",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        onPressed: _viewModel.isRegisterButtonEnabled
            ? () {
                MyApp.analytics.sendAnalyticsEvent(
                    AnalyticsEvent.registerChannel,
                    {'channel_id': _viewModel.textEditingController.text});
                _viewModel.registerChannel();
              }
            : null);
  }
}
