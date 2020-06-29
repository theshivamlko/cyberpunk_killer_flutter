import 'dart:typed_data' as typed_data;

import 'package:cyberpunkkillerapp/Pixel.dart';
import 'package:cyberpunkkillerapp/callbacks/FilterInterface.dart';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'package:flutter/material.dart' as material;
import 'package:image/image.dart' as img;

class HorizontalGlitchFilter2 implements FilterInterface {
  img.Image photo;
  double range;
  int gap;

  HorizontalGlitchFilter2(this.photo, this.range, this.gap);

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

        Pixel newPixel = Pixel.fromColor(ColorConstant.neonPinkColor);

        if (!reverse) {
          newPhoto1.setPixelRgba(
              dx, dy, newPixel.red, pixel.green, pixel.blue, pixel.alpha);
          counter++;
          if (counter >= interval || dx == 0) {
            print('reverse1 $reverse $counter');
            counter = 0;
            reverse = true;
          }
        } else {
          if (dx < xLength - interval)
            newPhoto1.setPixelRgba(
                dx + gap, dy, pixel.red, pixel.green, pixel.blue, pixel.alpha);
          /*    else
           newPhoto1.setPixelRgba(
              dx  , dy, pixel.red, pixel.green, pixel.blue, pixel.alpha);*/
          counter++;
          if (counter >= interval) {
            print('reverse2 $reverse $counter');
            counter = 0;
            reverse = false;
          }
        }
      }
    }

    int xLength2 = newPhoto1.width;
    int yLength2 = newPhoto1.height;
    for (int dy = 0; dy < yLength2; dy++) {
      for (int dx = 0; dx < xLength2; dx++) {
        int pixel32 = newPhoto1.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));
        Pixel newPixelPixel =
            Pixel.fromColor(material.Color(photo.getPixel(dx, dy)));

        if (pixel.red <= 20 && pixel.blue <= 20 && pixel.green <= 20) {
          print(
              'neonGlitch4Filter BLACK $dx $dy ${newPixelPixel.red} ${newPixelPixel.green}, ${newPixelPixel.blue} }');
          newPhoto1.setPixelRgba(dx, dy, newPixelPixel.red, newPixelPixel.green,
              newPixelPixel.blue, newPixelPixel.alpha);
        }
      }
    }

    List<typed_data.Uint8List> list = List();

    list.add(img.encodeJpg(newPhoto1));
    return list;
  }
}
