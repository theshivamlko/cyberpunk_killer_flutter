import 'dart:async';
import 'dart:io' as io;
import 'dart:typed_data' as typed_data;

import 'package:cyberpunkkillerapp/Pixel.dart';
import 'package:cyberpunkkillerapp/callbacks/ClickCallback.dart';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as img;

class ImageFiltersBloc {
  ImageFiltersBloc(this.imagePath);

  String imagePath;
  typed_data.Uint8List mainImageUnit8List;
  List<typed_data.Uint8List> resultImageUnit8List = List();
  typed_data.Uint8List originalImageUnit8List;
  img.Image photo;

  Future<bool> getImage() async {
    print('getImage');
    typed_data.ByteData byteData = await loadImageBundleBytes();
    mainImageUnit8List = byteData.buffer.asUint8List();
    // originalImageUnit8List = Uint8List(mainImageUnit8List.length);
    originalImageUnit8List = mainImageUnit8List;
    resultImageUnit8List.add(mainImageUnit8List);
    setImageBytes(mainImageUnit8List);

    return mainImageUnit8List != null;
  }

  Future<typed_data.ByteData> loadImageBundleBytes() async {
    typed_data.ByteData imageBytes = await rootBundle.load(imagePath);
    return imageBytes;
  }

  void setImageBytes(typed_data.Uint8List values) {
    photo = null;
    photo = img.decodeImage(values);
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

  void pinkFilter({ClickCallback onComplete}) async {
    assert(onComplete != null);
    resultImageUnit8List = List();
    int xLength = photo.width;
    int yLength = photo.height;
    int INTENSITY_FACTOR = 50;
    print('FILTER sketchFilter $xLength $yLength');
    img.Image newPhoto = img.Image(xLength, yLength);

    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));
        //  print('OLD Pixel ${pixel.red} ${pixel.green} ${pixel.blue} ');

        // int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;
        Pixel newPixel;
        newPixel = Pixel.fromColor(ColorConstant.neonPinkColor);

        newPhoto.setPixelRgba(
            dx, dy, newPixel.red, pixel.green, pixel.blue, pixel.alpha);
      }
    }

    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    mainImageUnit8List = img.encodeJpg(newPhoto);
    resultImageUnit8List.add(mainImageUnit8List);

    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  void yellowFilter({ClickCallback onComplete}) async {
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

        //int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;
        Pixel newPixel;
        newPixel = Pixel.fromColor(material.Colors.yellow);

        /*  print(
            'Pixel $dx $dy ${pixel.red} ${pixel.green} ${pixel.blue} ${pixel.alpha}');*/

        // photo.setPixelRgba(dx, dy, pixel.red, pixel.green, pixel.blue);
        //    print('NEW Pixel ${pixel.red} ${pixel.green} ${pixel.blue} ');
        newPhoto.setPixelRgba(
            dx, dy, newPixel.red, pixel.green, pixel.blue, newPixel.alpha);
      }
    }

    io.File file = io.File('/storage/emulated/0/ABC.jpg');
    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    mainImageUnit8List = img.encodeJpg(newPhoto);
    resultImageUnit8List.add(mainImageUnit8List);
    /*  String audioString =  convert.base64.encode(photo.getBytes(format: img.Format.argb));*/

    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  void greenFilter({ClickCallback onComplete}) async {
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

        //   int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;
        Pixel newPixel;
        //   newPixel = Pixel.fromColor(ColorConstant.neonPinkColor);
        newPixel = Pixel.fromColor(material.Colors.green);

        /*  print(
            'Pixel $dx $dy ${pixel.red} ${pixel.green} ${pixel.blue} ${pixel.alpha}');*/

        // photo.setPixelRgba(dx, dy, pixel.red, pixel.green, pixel.blue);
        //    print('NEW Pixel ${pixel.red} ${pixel.green} ${pixel.blue} ');
        newPhoto.setPixelRgba(
            dx, dy, pixel.red, newPixel.green, pixel.blue, newPixel.alpha);
      }
    }

    io.File file = io.File('/storage/emulated/0/ABC.jpg');
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

  void neonPinkFilter({ClickCallback onComplete}) async {
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

    io.File file = io.File('/storage/emulated/0/ABC.jpg');
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

    io.File file = io.File('/storage/emulated/0/ABC.jpg');
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

  void sketchFilter({ClickCallback onComplete}) async {
    assert(onComplete != null);

    resultImageUnit8List = List();
    int xLength = photo.width;
    int yLength = photo.height;
    int INTENSITY_FACTOR = 70;
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
          newPixel = Pixel.fromColor(material.Colors.yellow);
        } else {
          // apply black color
          newPixel = Pixel.fromColor(material.Colors.yellow);
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

  void neonGlitch1Filter({ClickCallback onComplete}) async {
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
        newPixel = Pixel.fromColor(ColorConstant.neonPinkColor);

        newPhoto.setPixelRgba(
            dx, dy, newPixel.red, pixel.green, pixel.blue, pixel.alpha);



      }
    }

    //io.File file = io.File('/storage/emulated/0/ABC.jpg');
    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    //  mainImageUnit8List = img.encodeJpg(newPhoto1);

    resultImageUnit8List.add(img.encodeJpg(newPhoto));
    // resultImageUnit8List.add(img.encodeJpg(newPhoto2));

    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  int abgrToArgb(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }

  void reset({ClickCallback onComplete}) {
    assert(onComplete != null);
    print('Reset');
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
