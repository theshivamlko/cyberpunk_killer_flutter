import 'dart:typed_data' as typed_data;

import 'package:flutter/services.dart' show rootBundle;

class Utils {
  static bool inRectRange(int x, int y, int dx, int dy, double top,
      double bottom, double left, double right) {
    double y1 = top * y;
    double y2 = bottom * y;

    double x1 = left * x;
    double x2 = right * x;

    return (dy > y1 && dy < y2) && (dx > x1 && dx < x2);
  }

  static Future<typed_data.ByteData> loadImageBundleBytes(
      String imagePath) async {
    typed_data.ByteData imageBytes;
    try {
      imageBytes = await rootBundle.load(imagePath);
    } catch (e) {
      print('loadImageBundleBytes $e');
    }
    return imageBytes;
  }
}
