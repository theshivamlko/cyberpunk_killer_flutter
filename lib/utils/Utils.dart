import 'dart:io' as io;
import 'dart:typed_data' as typed_data;

import 'package:cyberpunkkillerapp/utils/AppConstant.dart' as AppConstant;
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart' show rootBundle;
import 'package:overlay_support/overlay_support.dart';

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

  static Future<bool> saveToFile(typed_data.Uint8List bytes) async {
    try {
      io.File file = io.File(
          '${AppConstant.appDocDir.path}/${DateTime.now().millisecondsSinceEpoch}.jpg');
      if (!file.existsSync()) file.createSync(recursive: true);
      file.writeAsBytesSync(bytes);
      return true;
    } catch (e) {
      print('loadImageBundleBytes $e');
    }
    return false;
  }

  /// showToast at top of screen [msg]
  static void showToast(String msg) {
    showSimpleNotification(
        material.Align(
            alignment: material.Alignment.bottomCenter,
            child: material.Text(msg,
                style: material.TextStyle(color: material.Colors.white,fontFamily: 'Avenir'),
                textAlign: material.TextAlign.center)),
        background: material.Colors.grey[800]);
  }
}
