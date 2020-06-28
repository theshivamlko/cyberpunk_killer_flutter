import 'dart:io';

import 'package:cyberpunkkillerapp/callbacks/ClickCallback.dart';
import 'package:cyberpunkkillerapp/utils/AppConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImgPickerBloc {
  BuildContext context;
  final _picker = ImagePicker();

  void imageFromGallery({ClickCallback onProceed}) async {
    assert(onProceed != null);
    if (await checkGalleryPermission()) {
      createAppFolder();
      PickedFile image = await _picker.getImage(source: ImageSource.gallery);

      if (image != null) {
        print("imageFromGallery ${image.path}");
        onProceed(image.path, null, null);
      }
    } else {}
  }

  void imageFromCamera() {}

  Future<bool> checkGalleryPermission() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined || status.isDenied) {
      return await Permission.storage.request().isGranted;
    }
    return await Permission.storage.status.isGranted;
  }

  Future<bool> checkCameraPermission() async {
    var status1 = await Permission.camera.status;
    var status2 = await Permission.storage.status;
    bool isAllowed = false;
    if (status1.isUndetermined || status1.isDenied) {
      isAllowed = await Permission.camera.request().isGranted;
    }
    if (status2.isUndetermined || status2.isDenied) {
      if (isAllowed) isAllowed = await Permission.storage.request().isGranted;
    }
    status1 = await Permission.camera.status;
    status2 = await Permission.storage.status;

    return status1.isGranted && status2.isGranted;
  }

  void createAppFolder() async {
/*    Directory appDocDir = await getExternalStorageDirectory();
    print("appDocDir ${appDocDir.path}");*/
    Directory appDocDir = Directory('/storage/emulated/0/$saveFolderName');
    //  File imageFolder = File('/storage/emulated/0/$saveFolderName');
    print("Folder $appDocDir");
    print("Folder existsSync ${appDocDir.existsSync()}");
    if (!appDocDir.existsSync()) appDocDir.createSync(recursive: true);
  }
}
