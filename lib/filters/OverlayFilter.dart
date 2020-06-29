import 'dart:typed_data' as typed_data;

import 'package:cyberpunkkillerapp/callbacks/FilterInterface.dart';
import 'package:image/image.dart' as img;

class OverlayFilter implements FilterInterface {
  img.Image photo;
  typed_data.ByteData byteData;

  OverlayFilter(this.photo, this.byteData);

  @override
  List<typed_data.Uint8List> applyFilter({onComplete}) {
    int xLength = photo.width;
    int yLength = photo.height;

    img.Image overlayPhoto = img.decodeImage(byteData.buffer.asUint8List());
    overlayPhoto =
        img.copyResize(overlayPhoto, width: xLength, height: yLength);

    List<typed_data.Uint8List> list = List();

    list.add(img.encodeJpg(photo, quality: 100));
    list.add(img.encodePng(overlayPhoto));
    return list;
  }
}
