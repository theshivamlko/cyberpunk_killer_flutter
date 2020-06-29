import 'dart:async';
import 'dart:typed_data' as typed_data;

import 'package:cyberpunkkillerapp/callbacks/ClickCallback.dart';
import 'package:cyberpunkkillerapp/filters/BackgroundFilter.dart';
import 'package:cyberpunkkillerapp/filters/ColoredGlitchFilter.dart';
import 'package:cyberpunkkillerapp/filters/GreyGlitchFilter.dart';
import 'package:cyberpunkkillerapp/filters/HorizontalGlitchFilter.dart';
import 'package:cyberpunkkillerapp/filters/HorizontalGlitchFilter2.dart';
import 'package:cyberpunkkillerapp/filters/MonoColorFilter.dart';
import 'package:cyberpunkkillerapp/filters/OverlayFilter.dart';
import 'package:cyberpunkkillerapp/filters/SketchFilter.dart';
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
    setImageBytes(imageByte);
    mainImageUnit8List = imageByte;
    originalImageUnit8List = mainImageUnit8List;
    resultImageUnit8List.add(mainImageUnit8List);
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

  void applyMonoFilter(material.Color color, {ClickCallback onComplete}) async {
    assert(onComplete != null);
    MonoColorFilter pinkFilter = MonoColorFilter(photo, color);
    resultImageUnit8List = pinkFilter.applyFilter();
    onComplete(true, null, null);
  }

  void sketchFilter(material.Color color,
      {material.Color outLineColor = material.Colors.black,
      ClickCallback onComplete}) async {
    assert(onComplete != null);
    SketchFilter sketchFilter =
        SketchFilter(photo, color, outLineColor: outLineColor);
    resultImageUnit8List = sketchFilter.applyFilter();

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
