import 'package:cyberpunkkillerapp/utils/ColorConstant.dart' as ColorConstant;
import 'file:///C:/Users/TheDoctor/FlutterProjects/cyberpunk_killer_app/lib/models/Device.dart';
import 'package:cyberpunkkillerapp/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Device device;
  AnimationController animationController;
  Animation animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        lowerBound: 1.0,
        upperBound: 2.0,
        duration: Duration(seconds: 1),
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
    device = Device(
        MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Image.asset(
            'assets/images/splash.gif',
            width: device.deviceWidth,
            height: device.deviceHeight,
            fit: BoxFit.fitHeight,
          ),
          Align(
            alignment: Alignment(0.0, -0.7),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                '#Hack20',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 100,
                  fontFamily: 'PatinioBasica',
                  shadows: [
                    Shadow(
                      color: ColorConstant.midPrimaryColor,
                      //  offset: Offset(0.5, 0.0),
                      blurRadius: 30 * animationController.value,
                    ),
                    Shadow(
                      color: ColorConstant.neonPinkColor,
                      //  offset: Offset(0.5, 0.0),
                      blurRadius: 15 * animationController.value,
                    ),
                    Shadow(
                      color: ColorConstant.neonPinkColor,
                      // offset: Offset(0.5, 0.0),
                      blurRadius: 10 * animationController.value,
                    ),
                    Shadow(
                      color: ColorConstant.neonPinkColor,
                      //  offset: Offset(0.5, 0.0),
                      blurRadius: 5 * animationController.value,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                'Develop by:\n@theshivamlko',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 20,
                  fontFamily: 'PatinioBasica',
                  shadows: [
                    Shadow(
                      color: Colors.yellow,
                      //  offset: Offset(0.5, 0.0),
                      blurRadius: 20 * animationController.value,
                    ),
                    Shadow(
                      color: Colors.yellow,
                      //  offset: Offset(0.5, 0.0),
                      blurRadius: 15 * animationController.value,
                    ),
                    Shadow(
                      color: Colors.yellow,
                      // offset: Offset(0.5, 0.0),
                      blurRadius: 10 * animationController.value,
                    ),
                    Shadow(
                      color: Colors.yellow,
                      //  offset: Offset(0.5, 0.0),
                      blurRadius: 5 * animationController.value,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.7),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Container(
                width: 300,
                height: 60,
                alignment: Alignment.center,
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: AssetImage('assets/images/button3.png'))),
                child: Text(
                  'Let\'s GO',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Cyberpunk\nKiller',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 60,
                  fontFamily: 'Cyberpunk',
                  shadows: [
                    Shadow(
                      color: Colors.yellow,
                      //  offset: Offset(0.5, 0.0),
                      blurRadius: 20 * animationController.value,
                    ),
                    Shadow(
                      color: Colors.yellow,
                      //  offset: Offset(0.5, 0.0),
                      blurRadius: 15 * animationController.value,
                    ),
                    Shadow(
                      color: Colors.yellow,
                      // offset: Offset(0.5, 0.0),
                      blurRadius: 10 * animationController.value,
                    ),
                    Shadow(
                      color: Colors.yellow,
                      //  offset: Offset(0.5, 0.0),
                      blurRadius: 5 * animationController.value,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
