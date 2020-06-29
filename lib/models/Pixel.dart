import 'package:flutter/material.dart' as material;

class Pixel {
  int red = 0;
  int green = 0;
  int blue = 0;
  int alpha = 0;

  Pixel.fromColor(material.Color color) {
    red = color.red;
    green = color.green;
    blue = color.blue;
    alpha = color.alpha;
  }

  material.Color toColor() {
    return material.Color.fromARGB(alpha, red, green, blue);
  }


}
