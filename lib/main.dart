import 'package:cyberpunkkillerapp/HomePage.dart';
import 'package:cyberpunkkillerapp/screens/SplashScreen.dart';
import 'package:cyberpunkkillerapp/utils/ColorConstant.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Cyberpunk',
          primaryColor: primaryColor,
          accentColor: accentColor,
        ),
        home: SplashScreen(),
        //   home: ImageFilterPage(null),
      ),
    );
  }
}
