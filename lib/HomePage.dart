import 'package:carousel_slider/carousel_slider.dart';
import 'package:cyberpunkkillerapp/HomeCard.dart';
import 'package:cyberpunkkillerapp/bloc/ImgPickerBloc.dart';
import 'package:cyberpunkkillerapp/screens/ImageFilterPage.dart';
import 'package:cyberpunkkillerapp/screens/WallpapersListPage.dart';
import 'package:cyberpunkkillerapp/utils/AppConstant.dart' as AppConstant;
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'package:cyberpunkkillerapp/utils/Device.dart';
import 'package:cyberpunkkillerapp/widgets/RippleBackground.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Device device;

  ImgPickerBloc imagePickerBloc = ImgPickerBloc();

  @override
  void initState() {
    super.initState();

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
        child: CarouselSlider(
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
                    if (map['title'] == 'Image Filters')
                      filterButtons(context)
                    else if (map['title'] == 'Wallpapers')
                      wallpaperButton(context)
                  ],
                );
              },
            );
          }).toList(),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Align filterButtons(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 60,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  imagePickerBloc.imageFromGallery(
                      onProceed: (path, imageByte, d3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ImageFilterPage(path, imageByte)),
                    );
                  });
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft:
                              Radius.circular(device.deviceWidth * .05)),
                      image: DecorationImage(
                          image: AssetImage('assets/images/button1.png'))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.image,
                        color: Colors.black,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Gallery',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  imagePickerBloc.imageFromCamera(
                      onProceed: (path, imageByte, d3) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ImageFilterPage(path, imageByte)),
                    );
                  });
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight:
                              Radius.circular(device.deviceWidth * .05)),
                      image: DecorationImage(
                          image: AssetImage('assets/images/button2.png'))),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Camera',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Align wallpaperButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WallpapersListPage()),
          );
        },
        child: Container(
          width: device.deviceWidth,
          height: 60,
          margin: EdgeInsets.all(4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(device.deviceWidth * .05),
                bottomRight: Radius.circular(device.deviceWidth * .05),
              ),
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/button3.png'))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.image,
                color: Colors.black,
                size: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Wallpapers',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
