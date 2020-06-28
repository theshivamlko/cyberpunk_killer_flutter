import 'package:carousel_slider/carousel_slider.dart';
import 'package:cyberpunkkillerapp/HomeCard.dart';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'package:cyberpunkkillerapp/utils/Device.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  int _counter = 0;
  Device device;

  @override
  Widget build(BuildContext context) {
    device = Device(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Scaffold(
      body: Container(
        height: device.deviceHeight,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              TinyColor(Theme.of(context).primaryColor).darken(20).color,
              TinyColor(Theme.of(context).primaryColor).darken(15).color,
              TinyColor(ColorConstant.midPrimaryColor).darken(8).color,
              TinyColor(Theme.of(context).accentColor).lighten(3).color,
              TinyColor(Theme.of(context).accentColor).lighten(5).color,
            ],
          ),
        ),
        child: CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height - 200,
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,enableInfiniteScroll: false
          ),
          items: [1, 2].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return HomeCard();
              },
            );
          }).toList(),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
