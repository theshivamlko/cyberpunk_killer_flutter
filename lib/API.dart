import 'dart:convert' as convert;
import 'dart:io' as io;

import 'package:cyberpunkkillerapp/utils/AppConstant.dart' as AppConstant;
import 'package:http/http.dart' as http;

/// return List of notes of user
Future<List> getWallpapers() async {
  try {
    var response = await http
        .get("https://navoki.com/samples/cyberpunk-killer/wallpaper.json");
    if (response.statusCode == 200) {
      List list = convert.json.decode(response.body);
      print(list);
      return list;
    }

    return null;
  } catch (err) {
    throw err;
  }
}

/// return List of notes of user
Future<io.File> downloadWallpaper(String path) async {
  try {
    var response = await http.get(path);
    if (response.statusCode == 200) {
      //  List list = convert.json.decode(response.body);
      print(response.bodyBytes);

      io.File file = io.File(
          '${AppConstant.appDocDir.path}/Wallpaper_${DateTime.now().millisecondsSinceEpoch}.jpg');
      if (!file.existsSync()) file.createSync(recursive: true);
      file.writeAsBytesSync(response.bodyBytes);
      return file;
    }

    return null;
  } catch (err) {
    throw err;
  }
}
