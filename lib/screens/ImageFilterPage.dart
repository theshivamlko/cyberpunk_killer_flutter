import 'package:cyberpunkkillerapp/bloc/ImageFiltersBloc.dart';
import 'package:cyberpunkkillerapp/utils/AppConstant.dart' as AppConstant;
import 'package:cyberpunkkillerapp/utils/Device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ImageFilterPage extends StatefulWidget {
  String imagePath;

  ImageFilterPage(this.imagePath);

  @override
  _ImageFilterPageState createState() => _ImageFilterPageState();
}

class _ImageFilterPageState extends State<ImageFilterPage> {
  GlobalKey paintKey = GlobalKey();

//  GlobalKey imageKey = GlobalKey();
  bool isLoading = true;
  ImageFiltersBloc imageFiltersBloc;
  PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    /*widget.imagePath =
        '/data/user/0/com.navoki.cyberpunkkillerapp/cache/image_picker8351625764446720074.jpg';*/

    // widget.imagePath = '/data/user/0/Download/dante.jpeg';

    imageFiltersBloc = ImageFiltersBloc(widget.imagePath);
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      imageFiltersBloc.getImage().then((isImage) {
        if (isImage) {
          isLoading = false;
          setState(() {});
        }
      });
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
        backgroundColor: Colors.green,
        body: Container(
          width: device.deviceWidth,
          height: device.deviceHeight,
          /*   decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                TinyColor(Theme.of(context).primaryColor).darken(20).color,
                TinyColor(Theme.of(context).primaryColor).darken(15).color,
                TinyColor(ColorConstant.midPrimaryColor).darken(8).color,
              ],
            ),
          ),*/
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
                            onPressed: () {}),
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
                        IconButton(
                            icon: Icon(
                              Icons.check,
                              size: 30,
                              color: Theme.of(context).primaryIconTheme.color,
                            ),
                            onPressed: () {}),
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
                  child: GestureDetector(
                    onPanDown: (details) {
                      //   searchPixel(details.globalPosition);
                    },
                    onPanUpdate: (details) {
                      //  searchPixel(details.globalPosition);
                    },
                    child: isLoading
                        ? Container(
                            height: 40,
                            width: 40,
                            child: CircularProgressIndicator())
                        : Stack(
                            children: imageFiltersBloc.resultImageUnit8List
                                .map((data) => Image.memory(
                                      data,
                                      //   key: imageKey,
                                      //color: Colors.red,
                                      //colorBlendMode: BlendMode.hue,
                                      //alignment: Alignment.bottomRight,
                                      fit: BoxFit.fitHeight,
                                      //scale: .8,
                                    ))
                                .toList()),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 60,
                  color: Colors.red,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: 30,
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
                                  color: Colors.green,
                                  alignment: Alignment.center,
                                  width: 100,
                                  child: Text(
                                    AppConstant.filterCategory[position],
                                    style: TextStyle(color: Colors.white),
                                  )),
                            );
                          },
                          itemCount:
                              AppConstant.filterCategory.length, // Can be null
                        ),
                      )
                    ],
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
      imageFiltersBloc.pinkFilter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    else if (AppConstant.filterCategory[position] == 'Yellow')
      imageFiltersBloc.yellowFilter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    else if (AppConstant.filterCategory[position] == 'Green')
      imageFiltersBloc.greenFilter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    else if (AppConstant.filterCategory[position] == 'NEON Pink')
      imageFiltersBloc.neonPinkFilter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    else if (AppConstant.filterCategory[position] == 'NEON Purple') {
      imageFiltersBloc.neonPurpleFilter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'NEON Glitch1') {
      imageFiltersBloc.neonGlitch1Filter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'NEON Glitch2') {
      imageFiltersBloc.neonGlitch2Filter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'NEON Glitch3') {
      imageFiltersBloc.neonGlitch3Filter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'NEON Glitch4') {
      imageFiltersBloc.neonGlitch4Filter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    } else if (AppConstant.filterCategory[position] == 'Sketch') {
      imageFiltersBloc.sketchFilter(onComplete: (refresh, p2, p3) {
        isLoading = false;
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    imageFiltersBloc.clear();
    super.dispose();
  }
}
