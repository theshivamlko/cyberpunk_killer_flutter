import 'package:cyberpunkkillerapp/bloc/WallpaperBloc.dart';
import 'package:cyberpunkkillerapp/utils/AppConstant.dart' as AppConstant;
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'file:///C:/Users/TheDoctor/FlutterProjects/cyberpunk_killer_app/lib/models/Device.dart';
import 'package:cyberpunkkillerapp/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:tinycolor/tinycolor.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

class WallpaperPage extends StatelessWidget {
  Device device;
  String imagePath;

  WallpaperPage(this.imagePath);

  WallpaperBloc wallpaperBloc = WallpaperBloc();

  @override
  Widget build(BuildContext context) {
    device = Device(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x00000000),
        elevation: 0,
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 40,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.save,
                size: 30,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              onPressed: () {
                wallpaperBloc.downloadWallpaper(imagePath).then((value) {
                  Utils.showToast('Saved at ${AppConstant.appDocDir.path}');
                });
              }),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imagePath),
                fit: BoxFit.cover,
              ),
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
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                wallpaperBloc.downloadWallpaper(imagePath).then((file) {
                  int location = WallpaperManager.HOME_SCREEN;
                  WallpaperManager.setWallpaperFromFile(file.path, location);
                  Utils.showToast('DONE!');
                });
              },
              child: Container(
                width: device.deviceWidth,
                height: 60,
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
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
                      child:
                          Text('Set Wallpaper', style: TextStyle(fontSize: 25)),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
