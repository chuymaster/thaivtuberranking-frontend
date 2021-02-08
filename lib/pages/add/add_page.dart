import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/error_dialog.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';
import 'package:thaivtuberranking/common/strings.dart';
import 'package:thaivtuberranking/pages/home/entity/origin_type.dart';
import 'package:thaivtuberranking/services/analytics.dart';
import 'package:thaivtuberranking/services/result.dart';
import 'package:thaivtuberranking/services/url_launcher.dart';

import '../../main.dart';
import 'add_complete_page.dart';
import 'add_repository.dart';
import 'component/description_box.dart';

class AddPage extends StatefulWidget {
  static const String route = '/add';

  final List<String> vTuberChannelIdList;

  const AddPage({Key key, this.vTuberChannelIdList}) : super(key: key);
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // Form key for input https://flutter.dev/docs/cookbook/forms/validation
  final _formKey = GlobalKey<FormState>();

  final _textEditingController = TextEditingController();
  final _repository = AddRepository();
  bool _isSubmitButtonDisabled = true;
  bool _isValidated = false;

  var _currentOriginType = OriginType.OriginalOnly;

  @override
  void initState() {
    super.initState();

    MyApp.analytics.sendAnalyticsEvent(AnalyticsEvent.page_loaded,
        {AnalyticsParameterName.page_name: AnalyticsPageName.add});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แจ้งเพิ่มแชนแนล VTuber"),
      ),
      body: ListView(
        children: [
          _buildRequestAddChannelBox(),
          Padding(
            padding: EdgeInsets.all(8),
          ),
          DescriptionBox(),
          Padding(
            padding: EdgeInsets.all(8),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeRadio() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Radio(
              value: OriginType.OriginalOnly,
              groupValue: _currentOriginType,
              onChanged: (OriginType value) {
                setState(() {
                  _currentOriginType = value;
                });
              },
            ),
            ThaiText(
              text: Strings.fullVtuber,
              fontSize: 12,
            ),
          ],
        ),
        Row(
          children: [
            Radio(
              value: OriginType.All,
              groupValue: _currentOriginType,
              onChanged: (OriginType value) {
                setState(() {
                  _currentOriginType = value;
                });
              },
            ),
            ThaiText(
              text: Strings.halfVtuber,
              fontSize: 12,
            ),
          ],
        )
      ],
    );
  }

  void _validateInputText() {
    setState(() {
      _isValidated = _formKey.currentState.validate();
      _isSubmitButtonDisabled = !_formKey.currentState.validate();
    });
  }

  Widget _buildRequestAddChannelBox() {
    var channelIdLength = 24;
    var textFormField = TextFormField(
      maxLength: channelIdLength, // แชนแนล YouTube ยาว 24 ตัวอักษร
      decoration: InputDecoration(hintText: "UCqhhWjpw23dWhJ5rRwCCrMA"),
      onChanged: (text) => {_validateInputText()},
      validator: (value) {
        if (value.isEmpty) {
          return 'โปรดกรอกแชนแนล ID';
        } else if (!value.startsWith('UC')) {
          return 'แชนแนล ID ต้องขึ้นต้นด้วย UC';
        } else if (value.length != channelIdLength) {
          return 'แชนแนล ID ต้องมีความยาว $channelIdLength ตัวอักษร';
        } else if (widget.vTuberChannelIdList.contains(value)) {
          return AddErrorMessage.alreadyAdded;
        } else {
          return null;
        }
      },
      controller: _textEditingController,
    );

    var submitButton = RaisedButton(
      child: ThaiText(
        text: "ส่งข้อมูล",
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      color: Theme.of(context).accentColor,
      onPressed: _isSubmitButtonDisabled
          ? null
          : () {
              setState(() {
                _isSubmitButtonDisabled = true;
              });
              if (_formKey.currentState.validate()) {
                _requestAddChannel(_textEditingController.text);
              } else {
                setState(() {
                  _isSubmitButtonDisabled = false;
                });
              }
            },
    );

    List<Widget> columnWidgets = [];
    columnWidgets.add(Padding(
      child: ThaiText(text: "โปรดกรอกแชนแนล ID (ขึ้นต้นด้วย UC)"),
      padding: EdgeInsets.fromLTRB(0, 16, 8, 8),
    ));
    columnWidgets.add(Padding(
      child: textFormField,
      padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
    ));

    // โชว์ลิงค์ไปที่แชนแนลยูทูปให้เช็คก่อนส่ง
    if (_isValidated) {
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
      columnWidgets.add(_buildTypeRadio());
      columnWidgets.add(Padding(padding: EdgeInsets.all(8)));

      var channelUrl =
          "https://youtube.com/channel/" + _textEditingController.text;
      columnWidgets.add(RichText(
          text: TextSpan(style: defaultRedStyle, children: [
        TextSpan(text: 'โปรดตรวจสอบแชนแนลอีกครั้งก่อนส่งข้อมูล\n'),
        TextSpan(
            text: channelUrl,
            style: linkStyle,
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                MyApp.analytics.sendAnalyticsEvent(
                    AnalyticsEvent.tap_channel_url_before_submit_add_request,
                    {'channel_id': _textEditingController.text});
                UrlLauncher.launchURL(channelUrl);
              }),
      ])));

      columnWidgets.add(Padding(padding: EdgeInsets.all(8)));
    }

    columnWidgets
        .add(Align(alignment: Alignment.centerRight, child: submitButton));
    return Align(
        alignment: Alignment.center,
        child: Container(
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: columnWidgets,
              )),
          width: 300,
        ));
  }

  void _requestAddChannel(String id) async {
    MyApp.analytics.sendAnalyticsEvent(
        AnalyticsEvent.request_add_channel, {'channel_id': id});

    var type = 'undefined';
    switch (_currentOriginType) {
      case OriginType.OriginalOnly:
        type = 'original';
        break;
      case OriginType.All:
        type = 'all';
        break;
    }
    var result = await _repository.sendAddChannelRequest(id, type);

    if (result is SuccessState) {
      Navigator.pushNamedAndRemoveUntil(
          context, AddCompletePage.route, (route) => false);
      setState(() {
        _isSubmitButtonDisabled = false;
      });
    } else if (result is ErrorState) {
      _showError(AddErrorMessage.failedToSubmit, result.msg);
    } else {
      setState(() {
        _isSubmitButtonDisabled = true;
      });
    }
  }

  void _showError(String title, String description) {
    ErrorDialog.showErrorDialog(title, description, context);
    setState(() {
      _isSubmitButtonDisabled = false;
    });
  }
}

class AddErrorMessage {
  static const String alreadyAdded = "แชนแนลนี้อยู่ในฐานข้อมูลจัดอันดับแล้ว";
  static const String tooManyAttempts =
      "คุณกดปุ่มตรวจสอบถี่เกินไป โปรดลองใหม่ในอีก 30 วินาทีให้หลัง";
  static const String failedToConnectToYouTube =
      "ไม่สามารถเชื่อมต่อกับระบบ YouTube ได้ กรุณาลองใหม่ในภายหลัง";
  static const String failedToSubmit =
      "เกิดปัญหาในการส่งข้อมูล กรุณาลองใหม่ในภายหลัง";
}
