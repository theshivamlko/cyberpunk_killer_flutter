import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cyberpunkkillerapp/bloc/ImageFiltersBloc.dart';
import 'package:cyberpunkkillerapp/utils/AppConstant.dart' as AppConstant;
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'package:cyberpunkkillerapp/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_signature_view/flutter_signature_view.dart';
import 'package:tinycolor/tinycolor.dart';

import 'file:///C:/Users/TheDoctor/FlutterProjects/cyberpunk_killer_app/lib/models/Device.dart';

class ImageFilterPage extends StatefulWidget {
  String imagePath;
  Uint8List imageByte;

  ImageFilterPage(this.imagePath, this.imageByte);

  @override
  _ImageFilterPageState createState() => _ImageFilterPageState();
}

class _ImageFilterPageState extends State<ImageFilterPage>
    with TickerProviderStateMixin {
  GlobalKey paintKey = GlobalKey();

  AnimationController animationController;
  Animation animation;
  bool isLoading = false;
  bool needTransparent = false;
  ImageFiltersBloc imageFiltersBloc;
  PageController pageController = PageController();
  SignatureView signatureView;

  String drawPath;
  String backgroundType;

  @override
  void initState() {
    super.initState();

    imageFiltersBloc = ImageFiltersBloc(widget.imagePath);
    animationController = AnimationController(
        lowerBound: 1.0,
        upperBound: 2.0,
        duration: Duration(seconds: 1),
        vsync: this);

    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      imageFiltersBloc.canvasSize = paintKey.currentContext.size;
      imageFiltersBloc.getImage(widget.imageByte).then((isImage) {
        if (isImage) {
          print(
              "SchedulerBinding  getImage $isImage ${imageFiltersBloc.canvasSize}");
          isLoading = false;
          setState(() {});
        }
      });
      animationController.addListener(() {
        setState(() {});
      });
      animationController.repeat(reverse: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    Device device;

    device = Device(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);

    return SafeArea(
      top: true,
      child: Scaffold(
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                        icon: Icon(
                          Icons.keyboard_arrow_left,
                          size: 40,
                          color: Theme.of(context).primaryIconTheme.color,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(
                              Icons.save,
                              size: 30,
                              color: Theme.of(context).primaryIconTheme.color,
                            ),
                            onPressed: () async {
                              RenderRepaintBoundary boundary =
                                  paintKey.currentContext.findRenderObject();
                              ui.Image image = await boundary.toImage();
                              ByteData byteData = await image.toByteData(
                                  format: ui.ImageByteFormat.png);
                              Uint8List pngBytes =
                                  byteData.buffer.asUint8List();

                              Utils.saveToFile(pngBytes).then((saved) {
                                if (saved) {
                                  Utils.showToast(
                                      'Saved at ${AppConstant.appDocDir.path}');
                                }
                              });
                            }),
                        IconButton(
                            icon: Icon(
                              Icons.refresh,
                              size: 30,
                              color: Theme.of(context).primaryIconTheme.color,
                            ),
                            onPressed: () {
                              imageFiltersBloc.reset(onComplete: (d1, d2, d3) {
                                setState(() {});
                              });
                            }),

                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: device.deviceHeight - 200,
                color: Colors.transparent,
                child: RepaintBoundary(
                  key: paintKey,
                  child: isLoading
                      ? Container(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator())
                      : Container(
                          color: Colors.black,
                          child: Stack(
                            children: <Widget>[
                              Stack(
                                  children: imageFiltersBloc
                                      .resultImageUnit8List
                                      .map((data) => Image.memory(
                                            data,
                                            height: device.deviceHeight - 200,

                                            fit: BoxFit.fitWidth,
                                            //scale: .8,
                                          ))
                                      .toList()),
                              /*   if (signatureView != null && needTransparent)
                                Container(child: signatureView),*/
                              /*   if (signatureView2 != null) signatureView2*/
                            ],
                          ),
                        ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(2),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        onTap: () {
                          isLoading = true;
                          setState(() {});
                          print(AppConstant.filterCategory[position]);

                          applyFilter(position);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            margin:
                                EdgeInsets.only(right: 10, top: 2, bottom: 2),
                            height: 60,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  device.deviceWidth * .03),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorConstant.neonPinkColor,
                                  blurRadius: 1.0 * animationController.value,
                                  spreadRadius: 2.0 * animationController.value,
                                ),
                                BoxShadow(
                                  color: Colors.white60,
                                  blurRadius: 1.0 * animationController.value,
                                  spreadRadius: 1.0 * animationController.value,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  device.deviceWidth * .02),
                              child: Stack(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/${AppConstant.filterCategory[position].toString().toLowerCase()}.jpg',
                                    fit: BoxFit.fitWidth,
                                    width: 70,
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      AppConstant.filterCategory[position],
                                      style: TextStyle(color: Colors.white,fontFamily: 'Avenir',fontSize: 14),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      );
                    },
                    itemCount: AppConstant.filterCategory.length, // Can be null
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void applyFilter(int position) {
    if (AppConstant.filterCategory[position] == 'Pink')
      imageFiltersBloc.applyMonoFilter(ColorConstant.neonPinkColor,
          onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    else if (AppConstant.filterCategory[position] == 'Yellow')
      imageFiltersBloc.applyMonoFilter(Colors.yellow,
          onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    else if (AppConstant.filterCategory[position] == 'Green')
      imageFiltersBloc.applyMonoFilter(Colors.green,
          onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    else if (AppConstant.filterCategory[position] == 'NEON_Glitch1') {
      imageFiltersBloc.neonGlitch1Filter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'NEON_Glitch2') {
      imageFiltersBloc.neonGlitch2Filter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'NEON_Glitch3') {
      imageFiltersBloc.neonGlitch3Filter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'NEON_Glitch4') {
      imageFiltersBloc.neonGlitch4Filter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'NEON_Glitch5') {
      imageFiltersBloc.neonGlitch5Filter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'Sketch_Black') {
      imageFiltersBloc.sketchFilter(Colors.black,
          onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'Sketch_Green') {
      imageFiltersBloc.sketchFilter(Colors.green,
          onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'Sketch_Pink') {
      imageFiltersBloc.sketchFilter(ColorConstant.neonPinkColor,
          onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'Background1') {
      isLoading = false;
      setState(() {});

      print('$signatureView $needTransparent $isLoading');
      imageFiltersBloc
          .setBackground('assets/images/glitch_triangle_potrait.jpg',
              onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'Background2') {
      isLoading = false;
      setState(() {});

      print('$signatureView $needTransparent $isLoading');
      imageFiltersBloc.setBackground('assets/images/glitch_circle_potrait.jpg',
          onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
      isLoading = false;
    } else if (AppConstant.filterCategory[position] == 'Background3') {
      isLoading = false;
      setState(() {});

      print('$signatureView $needTransparent $isLoading');
      imageFiltersBloc.setBackground('assets/images/glitch_circle2_potrait.jpg',
          onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'Overlay1') {
      isLoading = false;
      setState(() {});

      print('$signatureView $needTransparent $isLoading');
      imageFiltersBloc.setOverLay('assets/images/fluid.png',
          onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'Overlay2') {
      isLoading = false;
      setState(() {});

      print('$signatureView $needTransparent $isLoading');
      imageFiltersBloc.setOverLay('assets/images/glitch.png',
          onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'Overlay3') {
      isLoading = false;
      setState(() {});

      print('$signatureView $needTransparent $isLoading');
      imageFiltersBloc.setOverLay('assets/images/glitch_triangle_potrait.png',
          onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'Overlay4') {
      isLoading = false;
      setState(() {});

      print('$signatureView $needTransparent $isLoading');
      imageFiltersBloc.setOverLay('assets/images/glitch_circle_potrait.png',
          onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'Overlay5') {
      isLoading = false;
      setState(() {});

      print('$signatureView $needTransparent $isLoading');
      imageFiltersBloc.setOverLay('assets/images/glitch_circle2_potrait.png',
          onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    imageFiltersBloc.clear();
    animationController.dispose();
    super.dispose();
  }
}
