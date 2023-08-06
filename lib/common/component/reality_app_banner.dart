import 'package:flutter/material.dart';
import 'package:thaivtuberranking/common/component/thai_text.dart';

class RealityAdListTile extends StatelessWidget {
  const RealityAdListTile({
    super.key,
    required this.onTap,
  });

  final Function onTap;
  @override
  Widget build(BuildContext context) {
    var image = Container(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(45),
          child: Image.asset('assets/images/reality_app_icon.png')),
      padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
      width: 90.0,
    );

    return Container(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: ListTile(
        title: Row(
          children: [
            image,
            Padding(
              padding: EdgeInsets.all(8),
            ),
            Expanded(
                child: Column(
              children: [
                ThaiText(
                    text: 'REALITY - Become an Anime Avatar',
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis),
                ThaiText(text: 'สร้างอวาตาร์อนิเมะมาไลฟ์แบบ VTuber เลย!'),
              ],
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
            ))
          ],
        ),
        onTap: () {
          onTap();
        },
      ),
    );
  }
}
