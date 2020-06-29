import 'dart:typed_data' as typed_data;

import 'package:cyberpunkkillerapp/Pixel.dart';
import 'package:cyberpunkkillerapp/callbacks/FilterInterface.dart';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'package:flutter/material.dart' as material;
import 'package:image/image.dart' as img;

class HorizontalGlitchFilter implements FilterInterface {
  img.Image photo;
  double range;
  int gap;

  HorizontalGlitchFilter(this.photo, this.range, this.gap);

  @override
  List<typed_data.Uint8List> applyFilter({onComplete}) {
    int xLength = photo.width;
    int yLength = photo.height;
    img.Image newPhoto1 = img.Image(
      xLength,
      yLength,
    );

    int counter = 0;
    bool reverse = false;
    int interval = (xLength * range).toInt();

    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));
        int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;

        Pixel newPixel = Pixel.fromColor(ColorConstant.neonPinkColor);

        if (!reverse) {
          newPhoto1.setPixelRgba(
              dx, dy, newPixel.red, pixel.green, pixel.blue, pixel.alpha);
          counter++;
          if (counter >= interval || dx == 0) {
            counter = 0;
            reverse = true;
          }
        } else {
          newPhoto1.setPixelRgba(
              dx + gap, dy, intensity, intensity, intensity, pixel.alpha);
          counter++;
          if (counter >= interval) {
            counter = 0;
            reverse = false;
          }
        }
      }
    }

    List<typed_data.Uint8List> list = List();

    list.add(img.encodeJpg(newPhoto1));
    return list;
  }
}
