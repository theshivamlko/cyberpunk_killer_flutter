import 'dart:async';
import 'dart:io' as io;
import 'dart:typed_data' as typed_data;

import 'package:cyberpunkkillerapp/Pixel.dart';
import 'package:cyberpunkkillerapp/callbacks/ClickCallback.dart';
import 'package:cyberpunkkillerapp/filters/BackgroundFilter.dart';
import 'package:cyberpunkkillerapp/filters/ColoredGlitchFilter.dart';
import 'package:cyberpunkkillerapp/filters/GreyGlitchFilter.dart';
import 'package:cyberpunkkillerapp/filters/HorizontalGlitchFilter.dart';
import 'package:cyberpunkkillerapp/filters/HorizontalGlitchFilter2.dart';
import 'package:cyberpunkkillerapp/filters/MonoColorFilter.dart';
import 'package:cyberpunkkillerapp/filters/OverlayFilter.dart';
import 'package:cyberpunkkillerapp/filters/SketchFilter.dart';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'package:cyberpunkkillerapp/utils/Utils.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img;

class ImageFiltersBloc {
  ImageFiltersBloc(this.imagePath);

  String imagePath;
  material.Size canvasSize;
  typed_data.Uint8List mainImageUnit8List;
  List<typed_data.Uint8List> resultImageUnit8List = List();
  typed_data.Uint8List originalImageUnit8List;
  img.Image photo;

  Future<bool> getImage(typed_data.Uint8List imageByte) async {
    print('getImage');
    //await Future.delayed(Duration(seconds: 1));

    // typed_data.ByteData byteData = await loadImageBundleBytes(imagePath);
    // if (byteData != null) {
    setImageBytes(imageByte);
    mainImageUnit8List = imageByte;

    // originalImageUnit8List = Uint8List(mainImageUnit8List.length);
    originalImageUnit8List = mainImageUnit8List;
    resultImageUnit8List.add(mainImageUnit8List);
    // }

    return mainImageUnit8List != null;
  }

  Future<typed_data.ByteData> loadImageBundleBytes(String imagePath) async {
    typed_data.ByteData imageBytes;
    try {
      imageBytes = await rootBundle.load(imagePath);
    } catch (e) {
      print('loadImageBundleBytes $e');
    }
    return imageBytes;
  }

  void setImageBytes(typed_data.Uint8List values) {
    photo = null;
    photo = img.decodeImage(values);
    photo = img.copyResize(photo,
        width: canvasSize.width.toInt(), height: canvasSize.height.toInt());
  }

  void redFilter() async {
    print('FILTER redFilter');
    int xLength = photo.width;
    int yLength = photo.height;
    print('FILTER redFilter $xLength $yLength');

    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        //   int hex = abgrToArgb(pixel32);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));

        // print('Hex $dx $dy $hex $pixel32');
        print(
            'Pixel $dx $dy ${pixel.red} ${pixel.green} ${pixel.blue} ${pixel.alpha}');
      }
    }
  }

  void applyMonoFilter(material.Color color, {ClickCallback onComplete}) async {
    assert(onComplete != null);
    MonoColorFilter pinkFilter = MonoColorFilter(photo, color);
    resultImageUnit8List = pinkFilter.applyFilter();
    onComplete(true, null, null);
  }

  void neonPinkFilter({ClickCallback onComplete}) async {
    assert(onComplete != null);
    resultImageUnit8List = List();
    int xLength = photo.width;
    int yLength = photo.height;
    int INTENSITY_FACTOR = 120;
    print('FILTER neonPinkFilter $xLength $yLength');
    img.Image newPhoto = img.Image(xLength, yLength);

    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));
        //  print('OLD Pixel ${pixel.red} ${pixel.green} ${pixel.blue} ');

        int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;
        Pixel newPixel;
        if (intensity > INTENSITY_FACTOR) {
          // apply white color
          newPixel = Pixel.fromColor(ColorConstant.neonPinkColor);
        } else if (intensity > 40) {
          // apply grey color
          // newPixel = Pixel.fromColor(material.Colors.grey);
          newPixel = Pixel.fromColor(material.Colors.black);
        } else {
          // apply black color
          newPixel = Pixel.fromColor(material.Colors.black);
        }

        /*  print(
            'Pixel $dx $dy ${pixel.red} ${pixel.green} ${pixel.blue} ${pixel.alpha}');*/

        // photo.setPixelRgba(dx, dy, pixel.red, pixel.green, pixel.blue);
        //    print('NEW Pixel ${pixel.red} ${pixel.green} ${pixel.blue} ');
        newPhoto.setPixelRgba(
            dx, dy, newPixel.red, newPixel.green, newPixel.blue, 10);
      }
    }

    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    mainImageUnit8List = img.encodeJpg(newPhoto);
    resultImageUnit8List.add(mainImageUnit8List);
    /*  String audioString =  convert.base64.encode(photo.getBytes(format: img.Format.argb));*/

    /*  if (!file.existsSync()) file.createSync(recursive: true);

    file.writeAsBytesSync(mainImageUnit8List);*/

    /*   print('New Image ${newPhoto.getBytes(format: img.Format.rgba)}');
    print('New Image ${newPhoto.getBytes(format: img.Format.rgba).length}');
    print('New Image ${newPhoto.getBytes(format: img.Format.argb)}');
    print('New Image ${newPhoto.getBytes(format: img.Format.argb).length}');*/
    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  void neonPurpleFilter({ClickCallback onComplete}) async {
    assert(onComplete != null);
    int xLength = photo.width;
    int yLength = photo.height;
    int INTENSITY_FACTOR = 120;
    print('FILTER neonPurpleFilter $xLength $yLength');
    img.Image newPhoto = img.Image(xLength, yLength);

    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));
        //  print('OLD Pixel ${pixel.red} ${pixel.green} ${pixel.blue} ');

        int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;
        Pixel newPixel;
        if (intensity > INTENSITY_FACTOR) {
          // apply white color
          newPixel = Pixel.fromColor(ColorConstant.primaryColor);
        } else if (intensity > 40) {
          // apply grey color
          // newPixel = Pixel.fromColor(material.Colors.grey);
          newPixel = Pixel.fromColor(material.Colors.black);
        } else {
          // apply black color
          newPixel = Pixel.fromColor(material.Colors.black);
        }

        /*  print(
            'Pixel $dx $dy ${pixel.red} ${pixel.green} ${pixel.blue} ${pixel.alpha}');*/

        // photo.setPixelRgba(dx, dy, pixel.red, pixel.green, pixel.blue);
        //    print('NEW Pixel ${pixel.red} ${pixel.green} ${pixel.blue} ');
        newPhoto.setPixelRgba(
            dx, dy, newPixel.red, newPixel.green, newPixel.blue, 10);
      }
    }

    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    //   mainImageUnit8List = img.encodeJpg(newPhoto);
    resultImageUnit8List.add(img.encodeJpg(newPhoto));

    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  void sketchFilter( material.Color color,{ClickCallback onComplete}) async {
    assert(onComplete != null);
    SketchFilter sketchFilter = SketchFilter(photo, color);
    resultImageUnit8List = sketchFilter.applyFilter();

    onComplete(true, null, null);
  }

  void coloredSketchFilter({ClickCallback onComplete}) async {
    assert(onComplete != null);

    resultImageUnit8List = List();
    int xLength = photo.width;
    int yLength = photo.height;
    int INTENSITY_FACTOR = 120;
    print('FILTER sketchFilter $xLength $yLength');
    img.Image newPhoto = img.Image(xLength, yLength);

    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));
        //  print('OLD Pixel ${pixel.red} ${pixel.green} ${pixel.blue} ');

        int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;
        Pixel newPixel;
        if (intensity > INTENSITY_FACTOR) {
          // apply white color
          newPixel = Pixel.fromColor(material.Colors.white);
        } else if (intensity > 100) {
          // apply grey color
          // newPixel = Pixel.fromColor(material.Colors.grey);
          newPixel = Pixel.fromColor(material.Colors.green);
        } else {
          // apply black color
          newPixel = Pixel.fromColor(material.Colors.black);
        }

        /*  print(
            'Pixel $dx $dy ${pixel.red} ${pixel.green} ${pixel.blue} ${pixel.alpha}');*/

        // photo.setPixelRgba(dx, dy, pixel.red, pixel.green, pixel.blue);
        //    print('NEW Pixel ${pixel.red} ${pixel.green} ${pixel.blue} ');
        newPhoto.setPixelRgba(
            dx, dy, newPixel.red, newPixel.green, newPixel.blue, 100);
      }
    }

    io.File file = io.File('/storage/emulated/0/ABC.jpg');
    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    resultImageUnit8List.add(img.encodeJpg(newPhoto));

    /*  String audioString =  convert.base64.encode(photo.getBytes(format: img.Format.argb));*/

    if (!file.existsSync()) file.createSync(recursive: true);

    file.writeAsBytesSync(mainImageUnit8List);

    /*   print('New Image ${newPhoto.getBytes(format: img.Format.rgba)}');
    print('New Image ${newPhoto.getBytes(format: img.Format.rgba).length}');
    print('New Image ${newPhoto.getBytes(format: img.Format.argb)}');
    print('New Image ${newPhoto.getBytes(format: img.Format.argb).length}');*/
    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  void neonYellowFilter({ClickCallback onComplete}) async {
    assert(onComplete != null);
    int xLength = photo.width;
    int yLength = photo.height;
    int INTENSITY_FACTOR = 120;
    print('FILTER sketchFilter $xLength $yLength');
    img.Image newPhoto = img.Image(xLength, yLength);

    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));
        //  print('OLD Pixel ${pixel.red} ${pixel.green} ${pixel.blue} ');

        int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;
        Pixel newPixel;
        if (intensity > INTENSITY_FACTOR) {
          // apply white color
          newPixel = Pixel.fromColor(material.Colors.amber);
        } else if (intensity > 40) {
          // apply grey color
          // newPixel = Pixel.fromColor(material.Colors.grey);
          newPixel = Pixel.fromColor(material.Colors.black);
        } else {
          // apply black color
          newPixel = Pixel.fromColor(material.Colors.black);
        }

        /*  print(
            'Pixel $dx $dy ${pixel.red} ${pixel.green} ${pixel.blue} ${pixel.alpha}');*/

        // photo.setPixelRgba(dx, dy, pixel.red, pixel.green, pixel.blue);
        //    print('NEW Pixel ${pixel.red} ${pixel.green} ${pixel.blue} ');
        newPhoto.setPixelRgba(
            dx, dy, newPixel.red, newPixel.green, newPixel.blue, 100);
      }
    }

    io.File file = io.File('/storage/emulated/0/ABC.jpg');
    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    mainImageUnit8List = img.encodeJpg(newPhoto);

    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  void neonGlitch1Filter({ClickCallback onComplete}) async {
    assert(onComplete != null);

    ColoredGlitchFilter pinkFilter = ColoredGlitchFilter(photo);
    resultImageUnit8List = pinkFilter.applyFilter();

    onComplete(true, null, null);
  }

  void neonGlitch2Filter({ClickCallback onComplete}) async {
    assert(onComplete != null);

    GreyGlitchFilter pinkFilter = GreyGlitchFilter(photo);
    resultImageUnit8List = pinkFilter.applyFilter();

    onComplete(true, null, null);
  }

  void neonGlitch3Filter({ClickCallback onComplete}) async {
    assert(onComplete != null);

    HorizontalGlitchFilter pinkFilter = HorizontalGlitchFilter(photo, 0.08, 0);
    resultImageUnit8List = pinkFilter.applyFilter();

    onComplete(true, null, null);
  }

  void neonGlitch4Filter({ClickCallback onComplete}) async {
    assert(onComplete != null);

    HorizontalGlitchFilter2 pinkFilter =
        HorizontalGlitchFilter2(photo, 0.08, 20);
    resultImageUnit8List = pinkFilter.applyFilter();

    onComplete(true, null, null);
  }

  void neonGlitch5Filter({ClickCallback onComplete}) async {
    assert(onComplete != null);

    HorizontalGlitchFilter2 pinkFilter =
        HorizontalGlitchFilter2(photo, 0.15, (photo.width * 0.02).toInt());
    resultImageUnit8List = pinkFilter.applyFilter();

    onComplete(true, null, null);
  }

  void setBackground(String imagePath, {ClickCallback onComplete}) async {
    assert(onComplete != null);

    typed_data.ByteData byteData = await Utils.loadImageBundleBytes(imagePath);
    BackgroundFilter pinkFilter = BackgroundFilter(photo, byteData);
    resultImageUnit8List = pinkFilter.applyFilter();
    onComplete(true, null, null);
  }

  void setOverLay(String imagePath, {ClickCallback onComplete}) async {
    assert(onComplete != null);

    typed_data.ByteData byteData = await Utils.loadImageBundleBytes(imagePath);
    OverlayFilter pinkFilter = OverlayFilter(photo, byteData);
    resultImageUnit8List = pinkFilter.applyFilter();
    onComplete(true, null, null);

    onComplete(true, null, null);
  }

  void reset({ClickCallback onComplete}) {
    assert(onComplete != null);
    mainImageUnit8List = originalImageUnit8List;
    resultImageUnit8List = List();
    resultImageUnit8List.add(originalImageUnit8List);
    onComplete(true, null, null);
  }

  void clear() {
    mainImageUnit8List = null;
    originalImageUnit8List = null;
    photo = null;
  }
}
