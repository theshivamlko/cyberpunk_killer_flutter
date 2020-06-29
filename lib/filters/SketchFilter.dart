import 'dart:typed_data' as typed_data;

import 'package:cyberpunkkillerapp/Pixel.dart';
import 'package:cyberpunkkillerapp/callbacks/FilterInterface.dart';
import 'package:flutter/material.dart' as material;
import 'package:image/image.dart' as img;

class SketchFilter implements FilterInterface {
  img.Image photo;
  material.Color color;

  SketchFilter(this.photo, this.color);

  @override
  List<typed_data.Uint8List> applyFilter({onComplete}) {
    int xLength = photo.width;
    int yLength = photo.height;
    const int INTENSITY_FACTOR = 120;
    print('FILTER sketchFilter $xLength $yLength');
    img.Image newPhoto = img.Image(xLength, yLength);

    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));

        int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;
        Pixel newPixel;
        if (intensity > INTENSITY_FACTOR) {
          // apply white color
          newPixel = Pixel.fromColor(material.Colors.white);
        } else if (intensity > 100) {
          newPixel = Pixel.fromColor(color);
        } else {
          newPixel = Pixel.fromColor(material.Colors.black);
        }

        newPhoto.setPixel(dx, dy, newPixel.toColor().value);
      }
    }

    List<typed_data.Uint8List> list = List();

    list.add(img.encodeJpg(newPhoto));
    return list;
  }
}
