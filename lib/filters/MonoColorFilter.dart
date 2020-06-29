import 'dart:typed_data' as typed_data;

import 'file:///C:/Users/TheDoctor/FlutterProjects/cyberpunk_killer_app/lib/models/Pixel.dart';
import 'package:cyberpunkkillerapp/callbacks/FilterInterface.dart';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'package:flutter/material.dart' as material;
import 'package:image/image.dart' as img;

class MonoColorFilter implements FilterInterface {
  img.Image photo;
  material.Color color;

  MonoColorFilter(this.photo,this.color);

  @override
  List<typed_data.Uint8List> applyFilter({onComplete}) {
    int xLength = photo.width;
    int yLength = photo.height;
    print('MonoColorFilter $xLength $yLength $color');
    img.Image newPhoto = img.Image(xLength, yLength);

    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));
        Pixel newPixel = Pixel.fromColor(color);

        newPhoto.setPixelRgba(
            dx, dy, newPixel.red, pixel.green, pixel.blue, pixel.alpha);
      }
    }

    List<typed_data.Uint8List> list = List();

    list.add(img.encodeJpg(newPhoto));
    return list;
  }
}
