import 'package:cyberpunkkillerapp/bloc/ImgPickerBloc.dart';
import 'package:cyberpunkkillerapp/screens/ImageFilterPage.dart';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart';
import 'package:cyberpunkkillerapp/utils/Device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class HomeCard extends StatefulWidget {
  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> with TickerProviderStateMixin {
  Device device;

  AnimationController animationController;
  Animation animation;

  ImgPickerBloc imagePickerBloc = ImgPickerBloc();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        lowerBound: 1.0,
        upperBound: 2.0,
        duration: Duration(microseconds: 990),
        vsync: this);

    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      animationController.addListener(() {
        setState(() {});
      });
      animationController.repeat(reverse: true);
    });
  }

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
              color: neonPinkColor,
              blurRadius: 2.0 * animationController.value,
              spreadRadius: 3.0 * animationController.value,
            ),
            BoxShadow(
              color: Colors.white60,
              blurRadius: 1.0 * animationController.value,
              spreadRadius: 1.0 * animationController.value,
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
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 40,
                      fontFamily: 'Cyberpunk',
                      shadows: [
                        Shadow(
                          color: midPrimaryColor,
                          //  offset: Offset(0.5, 0.0),
                          blurRadius: 30* animationController.value,
                        ),
                        Shadow(
                          color: neonPinkColor,
                          //  offset: Offset(0.5, 0.0),
                          blurRadius: 15* animationController.value,
                        ),
                        Shadow(
                          color: neonPinkColor,
                          // offset: Offset(0.5, 0.0),
                          blurRadius: 10* animationController.value,
                        ),
                        Shadow(
                          color: neonPinkColor,
                          //  offset: Offset(0.5, 0.0),
                          blurRadius: 5* animationController.value,
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
                          imagePickerBloc.imageFromCamera(
                              onProceed: (path, d2, d3) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImageFilterPage(path)),
                                );
                              });                        },
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

  @override
  void dispose() {
    animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
