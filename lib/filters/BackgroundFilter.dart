import 'dart:typed_data' as typed_data;

import 'package:cyberpunkkillerapp/Pixel.dart';
import 'package:cyberpunkkillerapp/callbacks/FilterInterface.dart';
import 'package:flutter/material.dart' as material;
import 'package:image/image.dart' as img;

class BackgroundFilter implements FilterInterface {
  img.Image photo;
  typed_data.ByteData byteData;

  BackgroundFilter(this.photo, this.byteData);

  @override
  List<typed_data.Uint8List> applyFilter({onComplete}) {
    int xLength = photo.width;
    int yLength = photo.height;

    img.Image newPhoto1 = img.Image(xLength, yLength);

    img.Image backgroundPhoto = img.decodeImage(byteData.buffer.asUint8List());
    backgroundPhoto =
        img.copyResize(backgroundPhoto, width: xLength, height: yLength);

    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));
        if (pixel.green <= 255 &&
            pixel.green >= 100 &&
            pixel.red <= 110 &&
            pixel.blue <= 110) {
          newPhoto1.setPixelRgba(dx, dy, 0, 0, 0);
        } else
          newPhoto1.setPixel(dx, dy, material.Color(pixel32).value);
      }
    }
    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        Pixel pixel =
            Pixel.fromColor(material.Color(newPhoto1.getPixel(dx, dy)));
        Pixel newPixel =
            Pixel.fromColor(material.Color(backgroundPhoto.getPixel(dx, dy)));

        if (pixel.red <= 10 && pixel.blue <= 10 && pixel.green <= 10) {
          newPhoto1.setPixel(dx, dy, newPixel.toColor().value);
        } else {
          newPhoto1.setPixel(dx, dy, pixel.toColor().value);
        }
      }
    }

    List<typed_data.Uint8List> list = List();

    list.add(img.encodeJpg(newPhoto1, quality: 100));
    return list;
  }
}
