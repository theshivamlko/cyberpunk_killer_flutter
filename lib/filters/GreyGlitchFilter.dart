import 'dart:typed_data' as typed_data;

import 'file:///C:/Users/TheDoctor/FlutterProjects/cyberpunk_killer_app/lib/models/Pixel.dart';
import 'package:cyberpunkkillerapp/callbacks/FilterInterface.dart';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'package:cyberpunkkillerapp/utils/Utils.dart';
import 'package:flutter/material.dart' as material;
import 'package:image/image.dart' as img;

class GreyGlitchFilter implements FilterInterface {
  img.Image photo;

  GreyGlitchFilter(this.photo);

  @override
  List<typed_data.Uint8List> applyFilter({onComplete}) {
    int xLength = photo.width;
    int yLength = photo.height;
    img.Image newPhoto1 = img.Image(xLength, yLength);

    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));
        int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;

        if (Utils.inRectRange(
            xLength, yLength, dx, dy, 0.15, 0.30, 0.0, 0.70)) {
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto1.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else if (Utils.inRectRange(
            xLength, yLength, dx, dy, 0.60, 0.70, 0.20, 1.0)) {
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto1.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else if (Utils.inRectRange(
            xLength, yLength, dx, dy, 0.80, 0.85, 0.0, 1.0)) {
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto1.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else {
          newPhoto1.setPixelRgba(
              dx, dy, intensity, intensity, intensity, pixel.alpha);
        }
      }
    }

    img.Image newPhoto2 = img.Image(newPhoto1.width, newPhoto1.height);
    int xLength2 = newPhoto1.width;
    int yLength2 = newPhoto1.height;

    for (int dy = 0; dy < yLength2; dy++) {
      for (int dx = 0; dx < xLength2; dx++) {
        int pixel32 = newPhoto1.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));

        if (Utils.inRectRange(
            xLength2, yLength2, dx, dy, 0.25, 0.30, 0.0, 1.0)) {
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto2.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else if (Utils.inRectRange(
            xLength, yLength, dx, dy, 0.60, 0.62, 0.00, 0.50)) {
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto2.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else if (Utils.inRectRange(
            xLength, yLength, dx, dy, 0.87, 0.90, 0.70, 0.80)) {
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto2.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else {
          newPhoto2.setPixelRgba(
              dx, dy, pixel.red, pixel.green, pixel.blue, pixel.alpha);
        }
      }
    }

    List<typed_data.Uint8List> list = List();

    list.add(img.encodeJpg(newPhoto1));
    list.add(img.encodeJpg(newPhoto2));
    return list;
  }
}
