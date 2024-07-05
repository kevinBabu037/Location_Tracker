import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

class MapLauncher {
  static Future<void> launchMap(double latitude, double longitude) async {
    final String url = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";

    try {
      Uri uri =Uri.parse(url);
      await launchUrl(uri);
    } catch (e) {
      log("fail to load");
    }
  }
}
