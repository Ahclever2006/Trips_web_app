
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class AssetLoader {
  static Future<dynamic> json(String path) async {
    final raw = await rootBundle.loadString(path);
    return jsonDecode(raw);
  }
}
