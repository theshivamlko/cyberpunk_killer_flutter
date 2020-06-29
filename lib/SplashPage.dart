import 'package:carousel_slider/carousel_slider.dart';
import 'package:cyberpunkkillerapp/HomeCard.dart';
import 'package:cyberpunkkillerapp/bloc/ImgPickerBloc.dart';
import 'package:cyberpunkkillerapp/screens/ImageFilterPage.dart';
import 'package:cyberpunkkillerapp/utils/AppConstant.dart' as AppConstant;
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'package:cyberpunkkillerapp/utils/Device.dart';
import 'package:cyberpunkkillerapp/widgets/RippleBackground.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Device device;
  RippleBackground rippleBackground1;
  RippleBackground rippleBackground2;
  RippleBackground rippleBackground3;
  RippleBackground rippleBackground4;
  RippleBackground rippleBackground5;
  ImgPickerBloc imagePickerBloc = ImgPickerBloc();

  @override
  void initState() {
    super.initState();

    rippleBackground1 = RippleBackground(
      isPlaying: true,
      onComplete: () {
        print('Complete1');
        rippleBackground2.startAnimation();
      },
    );
    rippleBackground2 = RippleBackground(
      onComplete: () {
        print('Complete2');
        rippleBackground3.startAnimation();
      },
    );
    rippleBackground3 = RippleBackground(
      onComplete: () {
        print('Complete3');
        rippleBackground4.startAnimation();
      },
    );
    rippleBackground4 = RippleBackground(
      onComplete: () {
        print('Complete4');
        rippleBackground5.startAnimation();
      },
    );
    rippleBackground5 = RippleBackground(
      onComplete: () {
        print('Complete5');
        rippleBackground1.startAnimation();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    imagePickerBloc.context = context;
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
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: -device.deviceHeight / 2,
              left: -device.deviceWidth / 2,
              height: device.deviceHeight * 2,
              width: device.deviceWidth * 2,
              child: Stack(
                children: <Widget>[
                  rippleBackground2,
                  rippleBackground1,
                  rippleBackground3,
                  rippleBackground4,
                  rippleBackground5,
                ],
              ),
            ),
            CarouselSlider(
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height - 200,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false),
              items: AppConstant.mainOptions.map((map) {
                return Builder(
                  builder: (BuildContext context) {
                    return Stack(
                      children: <Widget>[
                        HomeCard(map),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.yellow,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red,
                                  blurRadius: 1.0,
                                  spreadRadius: 2.0,
                                ),
                                BoxShadow(
                                  color: Colors.orange,
                                  blurRadius: 8.0,
                                  spreadRadius: 3.0,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    imagePickerBloc.imageFromGallery(
                                        onProceed: (path, imageByte, d3) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ImageFilterPage(
                                                    path, imageByte)),
                                      );
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.image,
                                        color: Colors.orange,
                                        size: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Gallery',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    imagePickerBloc.imageFromCamera(
                                        onProceed: (path, imageByte, d3) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ImageFilterPage(
                                                    path, imageByte)),
                                      );
                                    });
                                  },
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.camera_alt,
                                        color: Colors.orange,
                                        size: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Camera',
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
