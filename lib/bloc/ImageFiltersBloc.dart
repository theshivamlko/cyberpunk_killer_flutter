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
  material.Size  canvasSize;
  typed_data.Uint8List mainImageUnit8List;
  List<typed_data.Uint8List> resultImageUnit8List = List();
  typed_data.Uint8List originalImageUnit8List;
  img.Image photo;

  Future<bool> getImage(typed_data.Uint8List imageByte) async {
    print('getImage');
    //await Future.delayed(Duration(seconds: 1));

    // typed_data.ByteData byteData = await loadImageBundleBytes(imagePath);
    // if (byteData != null) {
    mainImageUnit8List = imageByte;

    // originalImageUnit8List = Uint8List(mainImageUnit8List.length);
    originalImageUnit8List = mainImageUnit8List;
    resultImageUnit8List.add(mainImageUnit8List);
    setImageBytes(mainImageUnit8List);
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
    photo=   img.copyResize(photo, width: canvasSize.width.toInt(), height: canvasSize.height.toInt());
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
    print('FILTER yellowFilter $xLength $yLength');
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
    print('FILTER greenFilter $xLength $yLength');
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

  void sketchFilter({ClickCallback onComplete}) async {
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

    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  void neonGlitch1Filter({ClickCallback onComplete}) async {
    assert(onComplete != null);
    resultImageUnit8List = List();
    int xLength = photo.width;
    int yLength = photo.height;
    print('FILTER sketchFilter $xLength $yLength');
    img.Image newPhoto1 = img.Image(xLength, yLength);

    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));

        if (inRectRange(xLength, yLength, dx, dy, 0.25, 0.40, 0.0, 0.70)) {
          //    print('FILTER APPLY  neonPinkColor');
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto1.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else if (inRectRange(
            xLength, yLength, dx, dy, 0.80, 0.85, 0.0, 1.0)) {
          //    print('FILTER APPLY  neonPinkColor');
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto1.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else if (inRectRange(
            xLength, yLength, dx, dy, 0.60, 0.70, 0.20, 1.0)) {
          //    print('FILTER APPLY  neonPinkColor');
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto1.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else {
          //   print('FILTER APPLY  green');
          Pixel newPixel2 = Pixel.fromColor(material.Colors.green);
          newPhoto1.setPixelRgba(
              dx, dy, newPixel2.red, pixel.green, pixel.blue, pixel.alpha);
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
        int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;

        if (inRectRange(xLength2, yLength2, dx, dy, 0.05, 0.10, 0.0, 1.0)) {
          //    print('FILTER APPLY  neonPinkColor');
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto2.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else if (inRectRange(
            xLength, yLength, dx, dy, 0.50, 0.52, 0.00, 0.90)) {
          //    print('FILTER APPLY  neonPinkColor');
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto2.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else {
          newPhoto2.setPixelRgba(
              dx, dy, pixel.red, pixel.green, pixel.blue, pixel.alpha);
        }
      }
    }

    //io.File file = io.File('/storage/emulated/0/ABC.jpg');
    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    //  mainImageUnit8List = img.encodeJpg(newPhoto1);

    resultImageUnit8List.add(img.encodeJpg(newPhoto1));
    resultImageUnit8List.add(img.encodeJpg(newPhoto2));

    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  void neonGlitch2Filter({ClickCallback onComplete}) async {
    assert(onComplete != null);
    resultImageUnit8List = List();
    int xLength = photo.width;
    int yLength = photo.height;
    print('FILTER sketchFilter $xLength $yLength');
    img.Image newPhoto1 = img.Image(xLength, yLength);

    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));
        int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;

        if (inRectRange(xLength, yLength, dx, dy, 0.15, 0.30, 0.0, 0.70)) {
          //    print('FILTER APPLY  neonPinkColor');
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto1.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else if (inRectRange(
            xLength, yLength, dx, dy, 0.60, 0.70, 0.20, 1.0)) {
          //    print('FILTER APPLY  neonPinkColor');
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto1.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else if (inRectRange(
            xLength, yLength, dx, dy, 0.80, 0.85, 0.0, 1.0)) {
          //    print('FILTER APPLY  neonPinkColor');
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto1.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else {
          //   print('FILTER APPLY  green');
          //   Pixel newPixel2 = Pixel.fromColor(material.Colors.green);
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
        int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;

        if (inRectRange(xLength2, yLength2, dx, dy, 0.25, 0.30, 0.0, 1.0)) {
          //    print('FILTER APPLY  neonPinkColor');
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto2.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else if (inRectRange(
            xLength, yLength, dx, dy, 0.60, 0.62, 0.00, 0.50)) {
          //    print('FILTER APPLY  neonPinkColor');
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto2.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else if (inRectRange(
            xLength, yLength, dx, dy, 0.87, 0.90, 0.70, 0.80)) {
          //    print('FILTER APPLY  neonPinkColor');
          Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto2.setPixelRgba(
              dx, dy, newPixel1.red, pixel.green, pixel.blue, pixel.alpha);
        } else {
          newPhoto2.setPixelRgba(
              dx, dy, pixel.red, pixel.green, pixel.blue, pixel.alpha);
        }
      }
    }

    //io.File file = io.File('/storage/emulated/0/ABC.jpg');
    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    //  mainImageUnit8List = img.encodeJpg(newPhoto1);

    resultImageUnit8List.add(img.encodeJpg(newPhoto1));
    resultImageUnit8List.add(img.encodeJpg(newPhoto2));
    // resultImageUnit8List.add(img.encodeJpg(newPhoto2));

    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  void neonGlitch3Filter({ClickCallback onComplete}) async {
    assert(onComplete != null);
    resultImageUnit8List = List();
    int xLength = photo.width;
    int yLength = photo.height;
    print('FILTER sketchFilter $xLength $yLength');
    img.Image newPhoto1 = img.Image(xLength, yLength);

    int counter = 0;
    bool reverse = false;

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
          if (counter >= 20 || dx == 0) {
            print('reverse1 $reverse $counter');
            counter = 0;
            reverse = true;
          }
        } else {
          newPhoto1.setPixelRgba(
              dx, dy, intensity, intensity, intensity, pixel.alpha);
          counter++;
          if (counter >= 20) {
            print('reverse2 $reverse $counter');
            counter = 0;
            reverse = false;
          }
        }
      }
    }

    //io.File file = io.File('/storage/emulated/0/ABC.jpg');
    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    //  mainImageUnit8List = img.encodeJpg(newPhoto1);

    resultImageUnit8List.add(img.encodeJpg(newPhoto1));
    //  resultImageUnit8List.add(img.encodeJpg(newPhoto2));

    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  void neonGlitch4Filter({ClickCallback onComplete}) async {
    assert(onComplete != null);
    resultImageUnit8List = List();
    int xLength = photo.width;
    int yLength = photo.height;
    print('FILTER sketchFilter $xLength $yLength');
    img.Image newPhoto1 = img.Image(xLength, yLength);

    int counter = 0;
    bool reverse = false;
    int interval = (xLength * .08).toInt();
    int gap = 20;

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

    //  img.Image newPhoto2 = img.Image(photo.width, photo.height);
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

    //io.File file = io.File('/storage/emulated/0/ABC.jpg');
    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    //  mainImageUnit8List = img.encodeJpg(newPhoto1);

    resultImageUnit8List.add(img.encodeJpg(newPhoto1));
    // resultImageUnit8List.add(img.encodeJpg(newPhoto2));

    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  void neonGlitch5Filter({ClickCallback onComplete}) async {
    assert(onComplete != null);
    resultImageUnit8List = List();
    int xLength = photo.width;
    int yLength = photo.height;
    print('FILTER sketchFilter $xLength $yLength');
    img.Image newPhoto1 = img.Image(xLength, yLength);

    int counter = 0;
    bool reverse = false;
    int interval = (xLength * .15).toInt();
    int gap = (xLength * 0.05).toInt();

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

    //  img.Image newPhoto2 = img.Image(photo.width, photo.height);
    int xLength2 = newPhoto1.width;
    int yLength2 = newPhoto1.height;
    /*   for (int dy = 0; dy < yLength2; dy++) {
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
    }*/

    //io.File file = io.File('/storage/emulated/0/ABC.jpg');
    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    //  mainImageUnit8List = img.encodeJpg(newPhoto1);

    resultImageUnit8List.add(img.encodeJpg(newPhoto1));
    // resultImageUnit8List.add(img.encodeJpg(newPhoto2));

    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  void setBackground(String imagePath, {ClickCallback onComplete}) async {
    assert(onComplete != null);
    resultImageUnit8List = List();
    int xLength = photo.width;
    int yLength = photo.height;

    print('FILTER setBackground $xLength $yLength');
    img.Image newPhoto1 = img.Image(xLength, yLength);
    typed_data.ByteData byteData = await loadImageBundleBytes(imagePath);

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
          print('GREEN ${pixel.green}');
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
          int intensity = (pixel.red + pixel.blue + pixel.green) ~/ 3;
          //  Pixel newPixel1 = Pixel.fromColor(ColorConstant.neonPinkColor);
          newPhoto1.setPixel(dx, dy, pixel.toColor().value);
        }
      }
    }

    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    //  mainImageUnit8List = img.encodeJpg(newPhoto1);

    resultImageUnit8List.add(img.encodeJpg(newPhoto1, quality: 100));
    // resultImageUnit8List.add(img.encodeJpg(newPhoto2));

    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

  void setOverLay(String imagePath, {ClickCallback onComplete}) async {
    assert(onComplete != null);
    resultImageUnit8List = List();
    int xLength = photo.width;
    int yLength = photo.height;

    print('FILTER setBackground $xLength $yLength');
    // img.Image newPhoto1 = img.Image(xLength, yLength);
    typed_data.ByteData byteData = await loadImageBundleBytes(imagePath);

    img.Image overlayPhoto = img.decodeImage(byteData.buffer.asUint8List());
    overlayPhoto =
        img.copyResize(overlayPhoto, width: xLength, height: yLength);

/*    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
        int pixel32 = photo.getPixel(dx, dy);
        Pixel pixel = Pixel.fromColor(material.Color(pixel32));
        if (pixel.green <= 255 &&
            pixel.green >= 100 &&
            pixel.red <= 110 &&
            pixel.blue <= 110) {
          print('GREEN ${pixel.green}');
          newPhoto1.setPixelRgba(dx, dy, 0, 0, 0);
        } else
          newPhoto1.setPixel(dx, dy, material.Color(pixel32).value);
      }
    }*/

/*    for (int dy = 0; dy < yLength; dy++) {
      for (int dx = 0; dx < xLength; dx++) {
   */ /*     Pixel pixel =
            Pixel.fromColor(material.Color());*/ /*

        Pixel   pixel = Pixel.fromColor(
            material.Color(img.setAlpha(overlayPhoto.getPixel(dx, dy), 250)));
        photo.setPixel(dx, dy, pixel.toColor().value);
      }
    }*/

    print('Previous Image $mainImageUnit8List');
    print('Previous Image Length ${mainImageUnit8List.length}');
    print('Previous Image $mainImageUnit8List');
    //  mainImageUnit8List = newPhoto.getBytes(format: img.Format.rgba);
    //  mainImageUnit8List = img.encodeJpg(newPhoto1);

    resultImageUnit8List.add(img.encodeJpg(photo, quality: 100));
    resultImageUnit8List.add(img.encodePng(overlayPhoto));

    print('New Image $mainImageUnit8List');
    print('New Image Length ${mainImageUnit8List.length}');

    onComplete(true, null, null);
  }

/*  int abgrToArgb(int argbColor) {
    int r = (argbColor >> 16) & 0xFF;
    int b = argbColor & 0xFF;
    return (argbColor & 0xFF00FF00) | (b << 16) | r;
  }*/

  void reset({ClickCallback onComplete}) {
    assert(onComplete != null);
    print('Reset');
    mainImageUnit8List = originalImageUnit8List;
    resultImageUnit8List = List();
    resultImageUnit8List.add(originalImageUnit8List);
    onComplete(true, null, null);
  }

  bool inRectRange(int x, int y, int dx, int dy, double top, double bottom,
      double left, double right) {
    double y1 = top * y;
    double y2 = bottom * y;

    double x1 = left * x;
    double x2 = right * x;

    return (dy > y1 && dy < y2) && (dx > x1 && dx < x2);
  }

  void clear() {
    mainImageUnit8List = null;
    originalImageUnit8List = null;
    photo = null;
  }
}
