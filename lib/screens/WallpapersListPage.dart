import 'package:cyberpunkkillerapp/HomeCard.dart';
import 'package:cyberpunkkillerapp/bloc/WallpaperBloc.dart';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'package:cyberpunkkillerapp/utils/Device.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';

class WallpapersListPage extends StatefulWidget {
  @override
  _WallpapersListPageState createState() => _WallpapersListPageState();
}

class _WallpapersListPageState extends State<WallpapersListPage>
    with TickerProviderStateMixin {
  Device device;

  AnimationController animationController;

  Animation animation;

  WallpaperBloc wallpaperBloc;

  @override
  Widget build(BuildContext context) {
    device = Device(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    animationController = AnimationController(
        lowerBound: 1.0,
        upperBound: 2.0,
        duration: Duration(seconds: 1),
        vsync: this);

    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    return Scaffold(
      backgroundColor: ColorConstant.primaryColor,
      body: Container(
        width: device.deviceWidth,
        height: device.deviceHeight,
        decoration: BoxDecoration(
          color: Colors.white,
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              TinyColor(Theme.of(context).primaryColor).darken(20).color,
              TinyColor(Theme.of(context).primaryColor).darken(15).color,
              TinyColor(ColorConstant.midPrimaryColor).darken(15).color,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              child: IconButton(
                  icon: Icon(
                    Icons.keyboard_arrow_left,
                    size: 40,
                    color: Theme.of(context).primaryIconTheme.color,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
            Container(
              padding: EdgeInsets.all(2),
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                 // return HomeCard();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
