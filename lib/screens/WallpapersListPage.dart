 import 'package:cyberpunkkillerapp/widgets/HomeCard.dart';
 import 'package:cyberpunkkillerapp/bloc/WallpaperBloc.dart';
import 'package:cyberpunkkillerapp/screens/WallpaperPage.dart';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'file:///C:/Users/TheDoctor/FlutterProjects/cyberpunk_killer_app/lib/models/Device.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
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
  void initState() {
    super.initState();
    wallpaperBloc = WallpaperBloc();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      wallpaperBloc.getWallpapers().then((value) {
        setState(() {});
      });
    });
  }

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
//        backgroundColor: Colors.transparent,
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
      ),
      body: Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(2),
              height: device.deviceHeight - 70,
              width: device.deviceWidth,
              child: wallpaperBloc.wallpapersList.length > 0
                  ? GridView.builder(
                      itemCount: wallpaperBloc.wallpapersList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.6, crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        Map map = Map();
                        map['image'] =
                            'https://navoki.com/samples/cyberpunk-killer/images/${wallpaperBloc.wallpapersList[index]['mobile']}';
                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => WallpaperPage( map['image'])),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: HomeCard(map),
                          ),
                        );
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            )
          ],
        ),
      ),
    );
  }
}
