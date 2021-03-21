// import 'package:flutter/material.dart';
// import 'dart:ui' as ui;
// import 'dart:html';

// class AdsView extends StatefulWidget {
//   @override
//   _AdsViewState createState() => _AdsViewState();
// }

// class _AdsViewState extends State<AdsView> {
//   Widget _htmlWidget;

//   @override
//   void initState() {
//     super.initState();
//     // HTMLElement reference: https://api.flutter.dev/flutter/dart-html/HtmlElement-class.html

//     DivElement divElement = DivElement();

//     ScriptElement element = ScriptElement()
//       ..async = true
//       ..src = "https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js";

//     ParagraphElement element2 = ParagraphElement()
//       ..className = "adsbygoogle"
//       ..style.display = 'inline-block'
//       ..style.width = '300px'
//       ..style.height = '200px'
//       ..dataset['ad-client'] = "ca-pub-5299011462076924"
//       ..dataset['ad-slot'] = "6730649097";

//     ScriptElement element3 = ScriptElement()
//       ..text = "(adsbygoogle = window.adsbygoogle || []).push({});";

//     divElement.insertAllBefore([element, element2, element3], null);

//     // ต้อง ignore ไม่งั้น compile ไม่ผ่าน
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       'ads_script',
//       (int viewId) => divElement,
//     );

//     _htmlWidget = HtmlElementView(
//       key: UniqueKey(),
//       viewType: 'ads_script',
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: _htmlWidget,
//       width: 300,
//       height: 200,
//     );
//   }
// }
