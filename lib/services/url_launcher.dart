import 'package:url_launcher/url_launcher.dart';

class UrlLauncher {
  static launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }
}
