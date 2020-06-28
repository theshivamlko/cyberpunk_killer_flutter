import 'package:cyberpunkkillerapp/bloc/ImgPickerBloc.dart';
import 'package:cyberpunkkillerapp/screens/ImageFilterPage.dart';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart';
import 'package:cyberpunkkillerapp/utils/Device.dart';
import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  Device device;

  ImgPickerBloc imagePickerBloc = ImgPickerBloc();

  @override
  Widget build(BuildContext context) {
    imagePickerBloc.context = context;
    device = Device(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(device.deviceWidth * .05),
          boxShadow: [
            BoxShadow(
              color: Colors.white,
              blurRadius: 1.0,
              spreadRadius: 2.0,
            ),
            BoxShadow(
              color: neonPinkColor,
              blurRadius: 3.0,
              spreadRadius: 3.0,
            ), BoxShadow(
              color: neonPinkColor,
              blurRadius: 8.0,
              spreadRadius: 5.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(device.deviceWidth * .05),
          child: Stack(
            children: <Widget>[
              Image.network(
                "https://r1.ilikewallpaper.net/iphone-wallpapers/download/82917/cyberpunk-2077-gameart-4k-iphone-wallpaper-ilikewallpaper_com.jpg",
                fit: BoxFit.fill,
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    "Image Filters",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'Cyberpunk',
                      shadows: [
                        Shadow(
                          color: midPrimaryColor.withOpacity(1),
                          //  offset: Offset(0.5, 0.0),
                          blurRadius: 5,
                        ),
                        Shadow(
                          color: neonPinkColor.withOpacity(1),
                          //  offset: Offset(0.5, 0.0),
                          blurRadius: 10,
                        ),
                        Shadow(
                          color: neonPinkColor.withOpacity(1),
                          // offset: Offset(0.5, 0.0),
                          blurRadius: 15,
                        ),
                        Shadow(
                          color: neonPinkColor.withOpacity(1),
                          //  offset: Offset(0.5, 0.0),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                        /*  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageFilterPage(null)),
                          );
*/
                             imagePickerBloc.imageFromGallery(
                              onProceed: (path, d2, d3) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImageFilterPage(path)),
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
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          imagePickerBloc.imageFromCamera();
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
                                style: Theme.of(context).textTheme.subtitle1,
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
          ),
        ));
  }
}
