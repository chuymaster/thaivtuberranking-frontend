import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:html';

class AdSenseListTile extends StatefulWidget {
  @override
  _AdSenseListTileState createState() => _AdSenseListTileState();
}

class _AdSenseListTileState extends State<AdSenseListTile> {
  Widget _htmlWidget;

  @override
  void initState() {
    super.initState();

    DivElement divElement = DivElement();

    ScriptElement element = ScriptElement()
      ..async = true
      ..src = "https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js";

    ParagraphElement element2 = ParagraphElement()
      ..className = "adsbygoogle"
      ..style.display = 'block'
      ..dataset['ad-client'] = "ca-pub-5299011462076924"
      ..dataset['ad-slot'] = "6730649097"
      ..dataset['ad-format'] = "auto"
      ..dataset['full-width-responsive'] = "true";

    ScriptElement element3 = ScriptElement()
      ..text = "(adsbygoogle = window.adsbygoogle || []).push({});";

    divElement.insertAllBefore([element, element2, element3], null);

    // ต้อง ignore ไม่งั้น compile ไม่ผ่าน
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'ads_script',
      (int viewId) => divElement,
    );

    _htmlWidget = HtmlElementView(
      key: UniqueKey(),
      viewType: 'ads_script',
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
      child: _htmlWidget,
      width: width,
      height: 96,
    );
  }

//   <script async src="https://pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
// <ins class="adsbygoogle"
//      style="display:block"
//      data-ad-client="ca-pub-5299011462076924"
//      data-ad-slot="1282595887"
//      data-ad-format="auto"
//      data-full-width-responsive="true"></ins>
// <script>
//      (adsbygoogle = window.adsbygoogle || []).push({});
// </script>
//     ''';
}
