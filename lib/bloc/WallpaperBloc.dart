import 'dart:io' as io;

import 'package:cyberpunkkillerapp/API.dart' as API;

class WallpaperBloc {
  List wallpapersList=List();

  Future<Null> getWallpapers() async {
    wallpapersList = await API.getWallpapers();
  }
  Future<io.File> downloadWallpaper(String imagePath) async  {
   return await API.downloadWallpaper(imagePath);
  }
}
